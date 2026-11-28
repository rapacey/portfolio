#!/usr/bin/env bash
# ==============================================================================
# Script Name: todo
# Course:      COP 2344 (Shell Scripting) - Project #8
# Description: Manages a personal to-do list stored in "$HOME/.todo" using
#              both non-interactive CLI options (getopts) and an interactive
#              menu-driven interface.
# ==============================================================================

# File path for the user's private to-do list (one task per line, unnumbered)
TODO_FILE="$HOME/.todo"

# Option flags (normalized states set during argument parsing)
LIST_OPT=0
ADD_OPT=0
REMOVE_OPT=0
HELP_OPT=0
VERSION_OPT=0
DEBUG_OPT=0

# Option argument holders
TASK_ARG=""
NUM_ARG=""

# ==============================================================================
# Helper Functions
# ==============================================================================

# Print usage instructions matching the project specification
show_help() {
    cat << 'EOF'
USAGE:
  todo [-d] [-1] [ -a TASK | -r NUM ]
  todo [-d] [-h | -v ]

Options:
  -d              Turn on debugging mode.
  -a "TASK"       Add the TASK string to the end of the list.
  -r NUM          Remove the NUM-th task from the list.
  -1              Display list of to-do tasks to standard output.
  -h              Display this help message.
  -v              Show author and version information.

If the -1 option is combined with either -a or -r, the modified list
will be displayed.
EOF
}

# Print version and author details
show_version() {
    echo "todo version 1.0 - COP 2344 Shell Scripting Project"
}

# Print debug messages to stderr only when -d is enabled
debug_msg() {
    if [ "$DEBUG_OPT" -eq 1 ]; then
        echo "[DEBUG] $*" >&2
    fi
}

# Ensure $TODO_FILE exists before attempting to read or modify it
ensure_todo_file() {
    if [ ! -f "$TODO_FILE" ]; then
        debug_msg "Creating missing file: $TODO_FILE"
        touch "$TODO_FILE" || {
            echo "Error: Unable to create $TODO_FILE." >&2
            exit 1
        }
    fi
}

# Count how many tasks currently exist in $TODO_FILE
get_task_count() {
    ensure_todo_file
    wc -l < "$TODO_FILE" | tr -d ' '
}

# Display all tasks with 1-based line numbers
view_tasks() {
    ensure_todo_file
    local count
    count=$(get_task_count)

    if [ "$count" -eq 0 ]; then
        echo "(Your to-do list is empty.)"
        return 0
    fi

    # Read line-by-line and print with sequential numbering
    local line_num=1
    while IFS= read -r task; do
        printf "%d. %s\n" "$line_num" "$task"
        line_num=$((line_num + 1))
    done < "$TODO_FILE"
}

# Append a new task string to the end of $TODO_FILE
add_task() {
    local new_task="$1"

    if [ -z "$new_task" ]; then
        echo "Error: Task description cannot be empty." >&2
        return 1
    fi

    ensure_todo_file
    debug_msg "Appending task to $TODO_FILE: '$new_task'"
    printf "%s\n" "$new_task" >> "$TODO_FILE"
}

# Remove the N-th task from $TODO_FILE safely using mktemp
remove_task() {
    local target_num="$1"
    ensure_todo_file

    local total_tasks
    total_tasks=$(get_task_count)

    if [ "$total_tasks" -eq 0 ]; then
        echo "** Your to-do list is currently empty; nothing to remove." >&2
        return 1
    fi

    # Verify target_num consists strictly of digits
    case "$target_num" in
        ''|*[!0-9]*)
            echo "** You must enter a number between 1 and $total_tasks!" >&2
            return 1
            ;;
    esac

    # Verify target_num falls within valid 1..total_tasks bounds
    if [ "$target_num" -lt 1 ] || [ "$target_num" -gt "$total_tasks" ]; then
        echo "** You must enter a number between 1 and $total_tasks!" >&2
        return 1
    fi

    # Create a secure temporary file to rebuild the list without line $target_num
    local tmp_file
    tmp_file=$(mktemp "${TMPDIR:-/tmp}/todo.XXXXXX") || {
        echo "Error: Failed to create temporary file." >&2
        return 1
    }

    local current_line=1
    while IFS= read -r task; do
        if [ "$current_line" -ne "$target_num" ]; then
            printf "%s\n" "$task" >> "$tmp_file"
        else
            debug_msg "Removing line $current_line: '$task'"
        fi
        current_line=$((current_line + 1))
    done < "$TODO_FILE"

    # Replace original file with updated temporary file
    mv "$tmp_file" "$TODO_FILE"
    return 0
}

# ==============================================================================
# Interactive Menu Mode (Extra Credit)
# ==============================================================================

run_interactive_menu() {
    local choice=""
    local new_task=""
    local del_num=""

    while true; do
        echo "1) Add"
        echo "2) Remove"
        echo "3) View"
        echo "4) Help"
        printf "Enter number from menu (q to quit, hit enter to redraw menu): "
        IFS= read -r choice

        # Pressing Enter alone simply loops back and redraws the menu
        if [ -z "$choice" ]; then
            continue
        fi

        case "$choice" in
            1|[Aa]|[Aa][Dd][Dd])
                echo "(Add)"
                printf "Enter new task to add (hit enter to cancel): "
                IFS= read -r new_task

                if [ -z "$new_task" ]; then
                    echo "Add cancelled."
                else
                    if add_task "$new_task"; then
                        echo "List Updated:"
                        view_tasks
                    fi
                fi
                ;;

            2|[Rr]|[Rr][Ee][Mm][Oo][Vv][Ee])
                view_tasks
                local total
                total=$(get_task_count)

                # Only prompt for a task number if there is at least one item
                if [ "$total" -gt 0 ]; then
                    while true; do
                        printf "(Remove) Enter task number to remove (hit enter or \"q\" to cancel): "
                        IFS= read -r del_num

                        # Cancel removal on empty Enter or 'q'/'Q'
                        if [ -z "$del_num" ] || [ "$del_num" = "q" ] || [ "$del_num" = "Q" ]; then
                            break
                        fi

                        # Attempt removal; if out of range, print error, redisplay list, and re-prompt
                        if remove_task "$del_num"; then
                            echo "List Updated:"
                            view_tasks
                            break
                        else
                            view_tasks
                        fi
                    done
                fi
                ;;

            3|[Vv]|[Vv][Ii][Ee][Ww])
                view_tasks
                ;;

            4|[Hh]|[Hh][Ee][Ll][Pp])
                show_help
                ;;

            [Qq]|[Qq][Uu][Ii][Tt]|[Ee][Xx][Ii][Tt])
                break
                ;;

            *)
                echo "** Invalid selection: '$choice'. Please choose 1-4 or 'q' to quit."
                ;;
        esac
    done
}

# ==============================================================================
# Main Execution & Command-Line Option Parsing
# ==============================================================================

# Parse command-line options using POSIX getopts
# Leading ':' switches getopts to silent error mode for custom error messages
while getopts ":1a:r:hvd" opt; do
    case "$opt" in
        1)
            LIST_OPT=1
            ;;
        a)
            ADD_OPT=1
            TASK_ARG="$OPTARG"
            ;;
        r)
            REMOVE_OPT=1
            NUM_ARG="$OPTARG"
            ;;
        h)
            HELP_OPT=1
            ;;
        v)
            VERSION_OPT=1
            ;;
        d)
            DEBUG_OPT=1
            ;;
        :)
            echo "Error: Option -$OPTARG requires an argument." >&2
            exit 1
            ;;
        \?)
            echo "Error: Invalid option -$OPTARG." >&2
            echo "Try 'todo -h' for more information." >&2
            exit 1
            ;;
    esac
done

# Shift processed options out of positional parameters
shift $((OPTIND - 1))

# Reject unexpected extra positional arguments (e.g., unquoted multi-word tasks)
if [ "$#" -gt 0 ]; then
    echo "Error: Unexpected argument '$1'. Did you forget quotes around a task?" >&2
    exit 1
fi

debug_msg "Parsed flags: LIST=$LIST_OPT ADD=$ADD_OPT REMOVE=$REMOVE_OPT HELP=$HELP_OPT VERSION=$VERSION_OPT"

# Check if NO command-line options were provided -> launch interactive mode
if [ "$LIST_OPT" -eq 0 ] && \
   [ "$ADD_OPT" -eq 0 ] && \
   [ "$REMOVE_OPT" -eq 0 ] && \
   [ "$HELP_OPT" -eq 0 ] && \
   [ "$VERSION_OPT" -eq 0 ] && \
   [ "$DEBUG_OPT" -eq 0 ]; then
    run_interactive_menu
    exit 0
fi

# Prevent mutually exclusive -a and -r flags from being combined
if [ "$ADD_OPT" -eq 1 ] && [ "$REMOVE_OPT" -eq 1 ]; then
    echo "Error: Options -a and -r cannot be used together." >&2
    exit 1
fi

# Handle -h (Help) and -v (Version)
if [ "$HELP_OPT" -eq 1 ]; then
    show_help
    exit 0
fi

if [ "$VERSION_OPT" -eq 1 ]; then
    show_version
    exit 0
fi

# Process Add (-a) or Remove (-r) BEFORE List (-1) so "-a ... -1" or "-r ... -1"
# displays the updated list as specified in the usage notes
if [ "$ADD_OPT" -eq 1 ]; then
    add_task "$TASK_ARG" || exit 1
fi

if [ "$REMOVE_OPT" -eq 1 ]; then
    remove_task "$NUM_ARG" || exit 1
fi

if [ "$LIST_OPT" -eq 1 ]; then
    view_tasks
fi

exit 0

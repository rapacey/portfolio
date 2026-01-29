#!/bin/sh

# 0. Configuration

SCRIPT=fortune.sh
FAILURES=0

# 0. Utilities

error() {
    echo "ERROR: $@" 1>&2
}

# 1. Check script
if [ ! -r ${SCRIPT} ]; then
    error "${SCRIPT} is not readable!"
    exit 1
fi

if [ ! -x ${SCRIPT} ]; then
    error "${SCRIPT} is not executable!"
    exit 2
fi

# 2. Test Asking Question
for i in $(seq 1 5); do
    echo "Testing Asking Question $i..."
    ./${SCRIPT}  <<EOF
Will I pass this test ($i)?
EOF
    sleep 1
done

# 2. Test Signals
for signal in HUP INT TERM; do
    echo "Testing SIG$signal..."
    (sleep 2; ps ux | grep $SCRIPT | grep -v test | grep -v grep | awk '{print $2}' | xargs kill -$signal) &
    ./${SCRIPT}
done

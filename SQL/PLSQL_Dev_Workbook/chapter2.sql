-- Oracle PL/SQL Developer Handbook
-- by Steven Feuerstein
-- Chapter 2 Exercises

-- 2-9 
/* For each of 20 years in the loan processing cycle, calculate the outstanding
loan balance for the specified customer. If the customer is a preferred vendor,
stop the calculations after 12 years */

DECLARE
    year_index NUMBER := 1; 
    max_years NUMBER := 20;
    preferred_vendor BOOLEAN := TRUE;

BEGIN
    IF preferred_vendor THEN
        -- Cap preferred vendor at 12 years
        max_years := 12;
END IF;

-- Pre-test loop checks the condition

WHILE year_index <= max_years LOOP 
    calc_balance(year_index);
    year_index := year_index + 1; 
    END LOOP;
END;

-- 2-10
-- Display the name and address of each employee returned by the following query

SELECT name, address FROM employee;

DECLARE 
    CURSOR employee_info IS     
        SELECT name, address    
        FROM employee; 
    employee_record employee_info%ROWTYPE;

BEGIN
    OPEN employee_info;
    LOOP 
    FETCH employee_info INTO employee_record;
    EXIT WHEN employee_info%NOTFOUND;
    -- Display employee record
        dbms_output.put_line(employee_record.name || ' - ' || employee_record.address));
    END LOOP;
    CLOSE employee_info;
END;

-- 2-11 
/* Scan through the list of employees in the PL/SQL table, keeping a count of all salaries greater than $50,000.
 Don't start the scan if the table is empty, or if today is a Saturday, or if the first employee in the table
 is the president of the company. */

 -- Option A: Boolean Guard Flag

 DECLARE
    -- Mocking the employee record structure and collection for context
    TYPE t_emp IS RECORD (job_title VARCHAR2(50), salary NUMBER);
    TYPE t_emp_list IS TABLE OF t_emp INDEX BY PLS_INTEGER;
    emp_list     t_emp_list;
    
    salary_count PLS_INTEGER := 0;
    run_scan     BOOLEAN := TRUE;
    i            PLS_INTEGER := 1;

BEGIN
    -- Check all 3 'don't start' conditions
    IF emp_list.COUNT = 0
       OR TO_CHAR(SYSDATE, 'DY') = 'SAT'
       OR emp_list(1).job_title = 'President' THEN
        run_scan := FALSE;
    END IF;

    -- Loop only runs if none of the stop conditions were met
    IF run_scan THEN
        WHILE i <= emp_list.COUNT LOOP
            IF emp_list(i).salary > 50000 THEN
                salary_count := salary_count + 1; 
            END IF;
            i := i + 1;
        END LOOP;
    END IF;
END;

-- Option B: Simple Loop w/ Initial Guard

DECLARE
    -- Mocking the employee record structure and collection for context
    TYPE t_emp IS RECORD (job_title VARCHAR2(50), salary NUMBER);
    TYPE t_emp_list IS TABLE OF t_emp INDEX BY PLS_INTEGER;
    emp_list     t_emp_list;
    
    salary_count PLS_INTEGER := 0;
    i            PLS_INTEGER := 1;

BEGIN   
    -- Don't start if any condition IS met
    IF emp_list.COUNT > 0
       AND TO_CHAR(SYSDATE, 'DY') <> 'SAT'
       AND emp_list(1).job_title <> 'President' THEN

        WHILE i <= emp_list.COUNT LOOP
            IF emp_list(i).salary > 50000 THEN
                salary_count := salary_count + 1;
            END IF;
            i := i + 1; 
        END LOOP;
    END IF;
END;

-- 2-24 
-- Set the status of each company to closed for each company whose ID is defined as a row number in a table of integers.


DECLARE
    -- Declare a custom type for a table of integers
    TYPE company_id_table IS TABLE OF INT; 
    -- Create sample data
    my_ids company_id_table := company_id_table (10, 20, 30);

BEGIN
    -- Numeric FOR loop iterating through collection elements
    FOR i IN 1 .. my_ids.COUNT LOOP
        UPDATE company
        SET status = 'Closed'
        WHERE company_id = my_ids(i);
    
    END LOOP;
END;

-- 2-25 
-- Write a piece of code that prints all the numbers between 1 and 100 evenly divisible by 3.

-- Use the MOD Function as part of a FOR loop

DECLARE
    test_number NUMBER;

BEGIN
    FOR i IN 1 .. 100 LOOP
        test_number := MOD(i, 3);
    IF test_number = 0 THEN
    dbms_output.put_line(i);
    END IF;
END LOOP;
END;

-- If i/3 equals its own integer part, it's divisible by 3

BEGIN
    FOR i in 1 .. 100 LOOP
    IF (i/3) = TRUNC(i/3) THEN
        dbms_output.put_line(i);
    END IF;
END LOOP;
END;

-- Write a loop that starts at 3 and counts up by 3

BEGIN
    FOR i IN 1 .. 33 LOOP
        dbms_output.put_line(i * 3);
    END LOOP;
END;

-- 2-26
-- Write your own version of the Oracle POWER Function

SET SERVEROUTPUT ON;

DECLARE
    base NUMBER := &enter_base;
    exponent INTEGER := &enter_exponent;
    result NUMBER := 1;
BEGIN
    -- Loop 'exponent' times to multiply the base repeatedly ex. 2 * 2 * 2 is 2 ^ 3 = 8
    FOR i IN 1 .. exponent LOOP
        result := result * base;
    END LOOP;

-- Print the final result
    dbms_output.put_line(base || ' raised to the power of ' || exponent || ' is ' || result);
END;

-- detect PLSQL language

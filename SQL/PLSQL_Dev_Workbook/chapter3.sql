-- Oracle PL/SQL Developer's Workbook
-- by Steven Feuerstein
-- Chapter 3 Exercsies

-- 3.10
/* Rewrite the following IF statements so that you do not have to use an 
IF statement to set the value of no_revenue */

DECLARE 
  total_sales NUMBER := sales_for_year (company_id => 1056, yearnum => 2026);
  no_revenue BOOLEAN;

BEGIN 
  IF total_sales <= 0
  THEN 
    no_revenue := TRUE;
  ELSIF total_sales > 0
  THEN
    no_revenue := FALSE;
  END IF;
END;

-- First attempt

CASE
  WHEN total_sales <= 0 THEN
  no_revenue := TRUE;
  WHEN total_sales > 0 THEN
  no_revenue := FALSE;
END CASE;

-- Cleaner code

CASE WHEN total_sales <= 0
THEN TRUE
ELSE FALSE
END CASE;

-- Evaluate directly to a Boolean value

BEGIN
  no_revenue := (total_sales <= 0);
END;

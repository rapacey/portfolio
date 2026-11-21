-- Murach PL/SQL for Developers, 3rd Edition
-- Chapter 3 Exercises

-- 5. Write a Select Statement that returns 3 colums from the Vendors table.
-- Add code so that it sorts the result set by last name and then first name.

SELECT 
vendor_name,
vendor_contact_last_name,
vendor_contact_first_name
FROM Vendors
ORDER BY vendor_contact_last_name, vendor_contact_first_name;

-- 6. Write a Select statement that returns one column from the Vendors table named full_name
-- Sort the results by last name, then first name. Filter the result set for contacts whose 
-- last name begins with the letter A, B, C or E

SELECT vendor_contact_last_name || ', ' || vendor_contact_first_name AS full_name
FROM Vendors
WHERE vendor_contact_last_name LIKE 'A%', 
OR vendor_contact_last_name LIKE 'B%',
OR vendor_contact_last_name LIKE 'C%',
OR vendor_contact_last_name LIKE 'E%'
ORDER BY vendor_contact_last_name, vendor_contact_first_name;

SELECT vendor_contact_last_name || ', ' || vendor_contact_first_name AS full_name
FROM Vendors
WHERE SUBSTR(UPPER(vendor_contact_last_name), 1, 1) IN ('A', 'B', 'C', 'E')
ORDER BY vendor_contact_last_name, vendor_contact_first_name;

SELECT vendor_contact_last_name || ', ' || vendor_contact_first_name AS full_name
FROM Vendors
WHERE REGEXP_LIKE(vendor_contact_last_name, '^[ABCE]', 'i')
ORDER BY vendor_contact_last_name, vendor_contact_first_name;

--7. Write a Select statement that returns 4 columns named Due Date, Invoice Total, 10% and Plus 10%

SELECT 
    invoice_due_date AS "Due Date",
    invoice_total AS "Invoice Total",
    invoice_total * .10 AS "10%",
    invoice_total + (invoice_total * .10) AS "Plus 10%"
FROM Invoices
WHERE invoice_total BETWEEN 500 and 1000
ORDER BY invoice_due_date DESC;

-- 8. Write a Select statement that returns 4 columns from the Invoices table
-- Filter for invoices with a balance due that's greater than or equal to $500
-- The result set should contain only the rows with the 10 largest balance dues.

SELECT
    invoice_number AS "Number",
    invoice_total AS "Total",
    payment_total + credit_total AS "Credits",
    invoice_total - payment_total - credit_total AS "Balance Due"
FROM Invoices
WHERE invoice_total - payment_total - credit_total >= 500
ORDER BY "Balance Due" DESC
FETCH FIRST 10 ROWS ONLY;

-- 9. Write a Select statement that returns the balance due and the payment date
-- from the Invoices table, but only when the payement date column contains a null value.

SELECT 
    invoice_total - payment_total - credit_total AS "Balance Due",
    payment_date
FROM Invoices
WHERE payment_date IS NULL 
    AND "Balance Due" = 0;

-- 10. Use the Dual Table to create a row with these columns.

SELECT
    51000 AS "Starting Principal",
    51000 * 1.1 AS "New Principal",
    (51000 * 1.1) * 0.065 AS "Interest",
    (5100 * 1.1) + ((51000 * 1.1) * 0.065) AS "Principal + Interest",
    TO_CHAR(SYSDATE, 'dd-mon-yyyy hh24:mi:ss') AS "System Date"
FROM dual;

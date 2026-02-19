USE automobile;
GO

-- 1. Dealerships (Expanding across regions)
INSERT INTO dealership VALUES (101, 'Irvine Toyota Sales', '100 Alton St', 'Irvine', 'CA');
INSERT INTO dealership VALUES (102, 'Paxton Auto Group', '500 Market St', 'Paxton', 'IL');
INSERT INTO dealership VALUES (103, 'Desert Wheels', '2 Central Blvd', 'Yuma', 'AZ');

-- 2. Salespersons (Establishing a hierarchy)
INSERT INTO salesperson VALUES (201, 'Joe Salesperson');
INSERT INTO salesperson VALUES (202, 'Angela Manager');
INSERT INTO salesperson VALUES (203, 'Kyle Owner');
INSERT INTO salesperson VALUES (204, 'Sarah Seller');
INSERT INTO salesperson VALUES (205, 'Mike Mentor');

-- 3. Reports To (Management Structure)
INSERT INTO reports_to VALUES (201, 202); -- Joe reports to Angela
INSERT INTO reports_to VALUES (202, 203); -- Angela reports to Kyle
INSERT INTO reports_to VALUES (204, 205); -- Sarah reports to Mike
INSERT INTO reports_to VALUES (205, 203); -- Mike reports to Kyle

-- 4. Cars (Diverse inventory)
INSERT INTO car VALUES ('1A11BCD1E1111F1G1', 'Toyota', 'Camry', 2024, 0, 28500.00, 24000.00);
INSERT INTO car VALUES ('2B22CDE2F2222G2H2', 'Mazda', 'Protege', 1991, 143570, 2300.00, 1100.00);
INSERT INTO car VALUES ('3C33DEF3G3333H3I3', 'Ford', 'F-150', 2021, 35000, 42000.00, 38000.00);
INSERT INTO car VALUES ('4D44EFG4H4444I4J4', 'Honda', 'Civic', 2022, 12000, 24000.00, 21000.00);
INSERT INTO car VALUES ('5E55FGH5I5555J5K5', 'Tesla', 'Model 3', 2023, 5000, 45000.00, 41000.00);
INSERT INTO car VALUES ('6F66GHI6J6666K6L6', 'Toyota', 'Corolla', 2024, 10, 23000.00, 20000.00);

-- 5. Customers
INSERT INTO customer VALUES ('123456789', 'Jane Customer', '1 Main St', 'Fountain Valley', 'CA');
INSERT INTO customer VALUES ('234567890', 'Howard Buyer', '2 Central Blvd', 'Yuma', 'AZ');
INSERT INTO customer VALUES ('456789012', 'Alice Jenkins', '456 Oak St', 'Irvine', 'CA');
INSERT INTO customer VALUES ('345678901', 'Rob Pacey', '123 Tech Lane', 'Paxton', 'IL');

-- 6. Works At (Salary and location history)
INSERT INTO works_at VALUES (201, 101, '2026-01-01', 2500.00);
INSERT INTO works_at VALUES (202, 101, '2026-01-01', 4500.00);
INSERT INTO works_at VALUES (204, 102, '2026-01-01', 3000.00);
INSERT INTO works_at VALUES (205, 102, '2026-01-01', 5000.00);

-- 7. Inventory (Tracking which car is where)
INSERT INTO inventory VALUES ('1A11BCD1E1111F1G1', 101);
INSERT INTO inventory VALUES ('4D44EFG4H4444I4J4', 102);
INSERT INTO inventory VALUES ('5E55FGH5I5555J5K5', 103);
INSERT INTO inventory VALUES ('6F66GHI6J6666K6L6', 101);

-- 8. Sales (Transactions)
-- Note: VINs in 'sale' should generally be removed from 'inventory' in a real app logic
INSERT INTO sale VALUES ('2B22CDE2F2222G2H2', '123456789', 201, 101, 2100.00, '2026-01-15');
INSERT INTO sale VALUES ('3C33DEF3G3333H3I3', '234567890', 204, 102, 41500.00, '2026-02-10');
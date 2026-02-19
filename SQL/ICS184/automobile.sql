-- ICS 184 Summer 2006
-- Assignment #2

-- This is an SQL script that creates the automobile sales database that
-- we're working with in this assignment, along with some test data to populate it.

DROP DATABASE IF EXISTS automobile;
CREATE DATABASE automobile;

-- "Use" the database, so that subsequent commands will be executed on it.

USE automobile;

-- Create the tables.  Other than specifying primary keys, no attempt was
-- made to specify constraints on the data or relationships between data
-- in different tables.  We'll address these concerns later this quarter.

CREATE TABLE car (
    vin CHAR(17) PRIMARY KEY,
    make VARCHAR(20) NOT NULL,
    model VARCHAR(20) NOT NULL,
    year INT NOT NULL,
    mileage INT DEFAULT 0,
    asking_price MONEY,
    invoice_price MONEY
);

CREATE TABLE dealership (
    dealership_id INT PRIMARY KEY,
    dealership_name VARCHAR(50) NOT NULL,
    dealership_street_address VARCHAR(100),
    dealership_city VARCHAR(50),
    dealership_state CHAR(2)
);

CREATE TABLE salesperson (
    salesperson_id INT PRIMARY KEY,
    salesperson_name VARCHAR(50) NOT NULL
);

CREATE TABLE customer (
    social_security_number CHAR(9) PRIMARY KEY,
    customer_name VARCHAR(50) NOT NULL,
    customer_street_address VARCHAR (100),
    customer_city VARCHAR(50),
    customer_state CHAR(2)
);

CREATE TABLE reports_to (       -- Self-referencing foreign key
    salesperson_id INT PRIMARY KEY,
    managing_salesperson_id INT,
    CONSTRAINT FK_Salesperson FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id),
    CONSTRAINT FK_Manager FOREIGN KEY (managing_salesperson_id) REFERENCES salesperson(salesperson_id)
);

CREATE TABLE works_at (         -- Composite foreign keys
    salesperson_id INT,
    dealership_id INT,
    month_worked DATE,
    base_salary_for_month MONEY,
    PRIMARY KEY (salesperson_id, dealership_id, month_worked),
    CONSTRAINT FK_WorksAt_Salesperson FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id),
    CONSTRAINT FK_WorksAt_Dealership FOREIGN KEY (dealership_id) REFERENCES dealership(dealership_id)
);

CREATE TABLE inventory (        -- Links cars to locations
    vin CHAR(17) PRIMARY KEY,
    dealership_id INT,
    CONSTRAINT FK_Inventory_Car FOREIGN KEY (vin) REFERENCES car(vin),
    CONSTRAINT FK_Inventory_Dealership FOREIGN KEY (dealership_id) REFERENCES dealership(dealership_id)
);

CREATE TABLE sale (             -- Central transaction table
    vin CHAR(17) PRIMARY KEY,
    social_security_number CHAR(9),
    salesperson_id INT,
    dealership_id INT,
    sale_price MONEY,
    sale_date DATE NOT NULL,
    CONSTRAINT FK_Sale_Car FOREIGN KEY (vin) REFERENCES car(vin),
    CONSTRAINT FK_Sale_Customer FOREIGN KEY (social_security_number) REFERENCES customer(social_security_number),
    CONSTRAINT FK_Sale_Salesperson FOREIGN KEY (salesperson_id) REFERENCES salesperson(salesperson_id),
    CONSTRAINT FK_Sale_Dealership FOREIGN KEY (dealership_id) REFERENCES dealership(dealership_id)
);
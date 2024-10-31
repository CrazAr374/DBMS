-- Use the database
USE SamDB;

-- Create client_master table
CREATE TABLE client_master(
    client_no INT,
    client_name VARCHAR(20),
    address VARCHAR(50),
    city VARCHAR(10),
    pincode INT,
    state VARCHAR(20),
    bal_due FLOAT,
    PRIMARY KEY(client_no)
);

-- Insert data into client_master table
INSERT INTO client_master VALUES
('001', 'Sam', 'nasik', 'nasik', '422004', 'MH', 5000),
('002', 'Piyu', 'nasik', 'nasik', '422004', 'MH', 10000),
('003', 'Abd', 'nasik', 'nasik', '422003', 'MH', 5000),
('004', 'Nut', 'nasik', 'nasik', '422003', 'MH', 5000),
('005', 'Abc', 'nasik', 'nasik', '422003', 'MH', 5000);

-- Create product_master table
CREATE TABLE product_master(
    product_no INT,
    description VARCHAR(20),
    profit_per FLOAT,
    unit_measure VARCHAR(10),
    quantity INT,
    reorder INT,
    sell_price FLOAT,
    cost_price FLOAT,
    PRIMARY KEY(product_no)
);

-- Insert data into product_master
INSERT INTO product_master VALUES
('001', 'Shampoo', 1, 'one', 4, 2, 10, 15),
('002', 'Oil', 13, 'one', 4, 2, 11, 16);

-- Alter client_master to add telephone_no
ALTER TABLE client_master ADD telephone_no INT;

-- Insert more data into client_master
INSERT INTO client_master VALUES ('006', 'Xyz', 'nasik', 'nasik', '422004', 'MH', 6000);

-- Create an index on client_master
CREATE INDEX client_search ON client_master(client_no);

-- Create auto_increment table
CREATE TABLE auto(
    roll_no INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(20),
    PRIMARY KEY(roll_no)
);

-- Insert data into auto table
INSERT INTO auto VALUES (NULL, 'Abc');
INSERT INTO auto VALUES (NULL, 'Adc');

-- Change auto_increment starting point
ALTER TABLE auto AUTO_INCREMENT=100;

-- Insert more data into auto table
INSERT INTO auto VALUES (NULL, 'Abd');
INSERT INTO auto VALUES (NULL, 'Reh');

-- Update client_name in client_master
UPDATE client_master SET client_name="Nutan" WHERE client_no='004';

-- Create an index on client_master for client_name and city
CREATE INDEX client_find ON client_master(client_name, city);

-- Describe product_master
DESC product_master;

-- Rename client_master to c_master
ALTER TABLE client_master RENAME TO c_master;

-- Insert new product into product_master
INSERT INTO product_master VALUES ('003', 'Nutela', 15, 'three', 40, 5, 110, 123);

-- Modify sell_price to have 2 decimal places
ALTER TABLE product_master MODIFY sell_price FLOAT(10, 2);

-- Create a view for client
CREATE VIEW client_view AS SELECT client_no, client_name FROM c_master;

-- Show the created view
SELECT * FROM client_view;

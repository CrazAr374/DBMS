-- Use the appropriate database
USE info;

-- Step 1: Create the Library Table
CREATE TABLE Library (
    roll_no INT PRIMARY KEY,
    name VARCHAR(20),
    date_of_issue DATE,
    book_name VARCHAR(50),
    status VARCHAR(20),
    author VARCHAR(20)
);

-- Step 2: Create the Library_Audit Table
CREATE TABLE Library_Audit (
    roll_no INT,
    name VARCHAR(20),
    date_of_issue DATE,
    book_name VARCHAR(50),
    status VARCHAR(20),
    author VARCHAR(20),
    ts TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Step 3: Insert Sample Data into Library
INSERT INTO Library VALUES (1, 'Nick', '2018-06-10', 'Wings of Fire', 'available', 'APJ');
INSERT INTO Library VALUES (2, 'Mira', '2018-05-11', 'Leaves of Life', 'not_available', 'Borwarkar');
INSERT INTO Library VALUES (3, 'Rina', '2018-02-12', 'Unusual', 'available', 'Johar');
INSERT INTO Library VALUES (4, 'Harsha', '2018-06-20', 'Skylimit', 'available', 'Ingle');
INSERT INTO Library VALUES (5, 'Tej', '2018-04-20', 'Highway', 'not_available', 'KLM');

-- Step 4: Create After Insert Trigger
DELIMITER //
CREATE TRIGGER after_insert_library 
AFTER INSERT ON Library 
FOR EACH ROW 
BEGIN
    INSERT INTO Library_Audit (roll_no, name, date_of_issue, book_name, status, author, ts) 
    VALUES (NEW.roll_no, NEW.name, NEW.date_of_issue, NEW.book_name, NEW.status, NEW.author, CURRENT_TIMESTAMP);
END; //
DELIMITER ;

-- Step 5: Create After Update Trigger
DELIMITER //
CREATE TRIGGER after_update_library 
AFTER UPDATE ON Library 
FOR EACH ROW 
BEGIN
    INSERT INTO Library_Audit (roll_no, name, date_of_issue, book_name, status, author, ts) 
    VALUES (OLD.roll_no, OLD.name, OLD.date_of_issue, OLD.book_name, OLD.status, OLD.author, CURRENT_TIMESTAMP);
END; //
DELIMITER ;

-- Step 6: Create After Delete Trigger
DELIMITER //
CREATE TRIGGER after_delete_library 
AFTER DELETE ON Library 
FOR EACH ROW 
BEGIN
    INSERT INTO Library_Audit (roll_no, name, date_of_issue, book_name, status, author, ts) 
    VALUES (OLD.roll_no, OLD.name, OLD.date_of_issue, OLD.book_name, OLD.status, OLD.author, CURRENT_TIMESTAMP);
END; //
DELIMITER ;

-- Optional: Check the structure of tables created
SHOW TABLES;
DESCRIBE Library;
DESCRIBE Library_Audit;

-- Optional: Verify triggers
SHOW TRIGGERS;

-- Step 7: Testing the triggers (Uncomment to execute)
-- Insert a New Entry
-- INSERT INTO Library VALUES (6, 'XYZ', '2018-09-06', 'AAA', 'available', 'XXX');

-- Update an Existing Entry
-- UPDATE Library SET book_name = 'Leaf', roll_no = 8 WHERE name = 'XYZ';

-- Delete an Entry
-- DELETE FROM Library WHERE roll_no = 5;

-- Check the Library_Audit Table
-- SELECT * FROM Library_Audit;

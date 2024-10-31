-- Use the specified database
USE Atharva;

-- Create the Borrower table
CREATE TABLE IF NOT EXISTS Borrower (
    roll_no INT PRIMARY KEY,
    name VARCHAR(50),
    DOI DATE,  -- Date of Issue
    book_name VARCHAR(50),
    status VARCHAR(10)  -- 'issued' or 'returned'
);

-- Create the Fine table
CREATE TABLE IF NOT EXISTS Fine (
    roll_no INT,
    fine_date DATE,
    amount DECIMAL(10, 2),
    FOREIGN KEY (roll_no) REFERENCES Borrower(roll_no)
);

-- Insert sample data into Borrower table
INSERT INTO Borrower (roll_no, name, DOI, book_name, status) VALUES
(12, 'Patel', '2018-07-01', 'xyz', 'issued'),
(14, 'Shinde', '2018-06-01', 'oop', 'issued'),
(16, 'Bhangale', '2018-05-01', 'coa', 'returned'),
(18, 'Rebello', '2018-06-15', 'toc', 'returned'),
(20, 'Patil', '2018-05-15', 'mp', 'issued');

-- Create the stored procedure for processing book returns
DELIMITER //

CREATE PROCEDURE ProcessBookReturn(
    IN studentRollNo INT,
    IN bookTitle VARCHAR(20)
)
BEGIN
    DECLARE daysOverdue INT;

    -- Declare a handler for when no record is found
    DECLARE CONTINUE HANDLER FOR NOT FOUND
    BEGIN
        SELECT 'NO RECORD FOUND' AS Message;
    END;

    -- Calculate the number of overdue days
    SELECT DATEDIFF(CURDATE(), DOI) INTO daysOverdue
    FROM Borrower
    WHERE roll_no = studentRollNo AND book_name = bookTitle;

    -- Check if the student has overdue days
    IF daysOverdue IS NULL THEN
        SELECT 'NO RECORD FOUND' AS Message;
        LEAVE ProcessBookReturn; -- Exit if no record is found
    END IF;

    -- Fine calculation and insert into Fine table based on overdue days
    IF daysOverdue > 15 AND daysOverdue <= 30 THEN
        INSERT INTO Fine VALUES(studentRollNo, CURDATE(), (daysOverdue * 5));
    ELSEIF daysOverdue > 30 THEN
        INSERT INTO Fine VALUES(studentRollNo, CURDATE(), (daysOverdue * 50));
    END IF;

    -- Update the status of the borrowed book to 'returned'
    UPDATE Borrower 
    SET status = 'returned' 
    WHERE roll_no = studentRollNo AND book_name = bookTitle;

END;
//

DELIMITER ;

-- Example calls to the stored procedure
CALL ProcessBookReturn(12, 'xyz');
CALL ProcessBookReturn(20, 'mp');

-- View the contents of the Fine table to check fines
SELECT * FROM Fine;

-- View the contents of the Borrower table to check status updates
SELECT * FROM Borrower;

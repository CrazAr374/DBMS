-- Switch to the database
USE AR;

-- Create the marks table
CREATE TABLE marks (
    roll_no INT,
    name VARCHAR(20),
    total_marks VARCHAR(20)
);

-- Create the result table
CREATE TABLE result (
    roll_no INT,
    name VARCHAR(20),
    class VARCHAR(20)
);

-- Insert sample data into marks table
INSERT INTO marks VALUES ('1', 'Abhi', '1400');
INSERT INTO marks VALUES ('2', 'Piyush', '980');
INSERT INTO marks VALUES ('3', 'Hitesh', '880');
INSERT INTO marks VALUES ('4', 'Ashley', '820');
INSERT INTO marks VALUES ('5', 'Partik', '740');
INSERT INTO marks VALUES ('6', 'Patil', '640');

-- Create the stored procedure for grading
DELIMITER //
CREATE PROCEDURE proc_Grade(IN marks INT, OUT class CHAR(20))
BEGIN
    IF (marks >= 990 AND marks <= 1500) THEN
        SET class = 'Distinction';
    ELSEIF (marks >= 900 AND marks < 990) THEN
        SET class = 'First Class';
    ELSEIF (marks >= 825 AND marks < 900) THEN
        SET class = 'Higher Second Class';
    ELSEIF (marks >= 750 AND marks < 825) THEN
        SET class = 'Second Class';
    ELSEIF (marks >= 650 AND marks < 750) THEN
        SET class = 'Passed';
    ELSE
        SET class = 'Fail';
    END IF;
END //
DELIMITER ;

-- Create the stored function to process the result
DELIMITER //
CREATE FUNCTION final_result(R1 INT) RETURNS INT
BEGIN
    DECLARE fmarks INT;
    DECLARE grade VARCHAR(20);
    DECLARE stud_name VARCHAR(20);
    
    -- Retrieve marks and student name based on roll number
    SELECT total_marks, name INTO fmarks, stud_name FROM marks WHERE roll_no = R1;
    
    -- Call the procedure to get the class
    CALL proc_Grade(fmarks, grade);
    
    -- Insert the result into the result table
    INSERT INTO result VALUES (R1, stud_name, grade);
    
    -- Return the roll number for confirmation
    RETURN R1;
END //
DELIMITER ;

-- Call the function to categorize results
SELECT final_result(1);
SELECT final_result(2);
SELECT final_result(3);
SELECT final_result(4);
SELECT final_result(5);
SELECT final_result(6);

-- Display results from the result table
SELECT * FROM result;

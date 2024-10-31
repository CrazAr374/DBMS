-- Use the specified database
USE AR;

-- Create the O_RollCall table
CREATE TABLE IF NOT EXISTS O_RollCall (
    roll_no INT PRIMARY KEY,
    name VARCHAR(20),
    address VARCHAR(20)
);

-- Create the N_RollCall table
CREATE TABLE IF NOT EXISTS N_RollCall (
    roll_no INT PRIMARY KEY,
    name VARCHAR(20),
    address VARCHAR(20)
);

-- Insert sample data into O_RollCall table
INSERT INTO O_RollCall (roll_no, name, address) VALUES
(1, 'Hitesh', 'Nandura'),
(2, 'Piyush', 'MP'),
(3, 'Ashley', 'Nsk'),
(4, 'Kalpesh', 'Dhule'),
(5, 'Abhi', 'Satara');

-- Insert additional data into O_RollCall for testing
INSERT INTO O_RollCall (roll_no, name, address) VALUES
(6, 'Patil', 'Kolhapur');

-- Create the stored procedure using a parameterized cursor
DELIMITER //

CREATE PROCEDURE MergeRollCall(IN r1 INT)
BEGIN
    DECLARE r2 INT;
    DECLARE exit_loop BOOLEAN;
    
    -- Declare the parameterized cursor
    DECLARE c1 CURSOR FOR 
        SELECT roll_no FROM O_RollCall WHERE roll_no > r1;

    -- Declare continue handler for not found condition
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET exit_loop = TRUE;

    -- Open the cursor
    OPEN c1;

    -- Loop through the cursor
    e_loop: LOOP
        FETCH c1 INTO r2;  -- Fetch roll_no into r2

        -- If r2 is NULL, exit the loop
        IF exit_loop THEN
            LEAVE e_loop;
        END IF;

        -- Check if the roll_no already exists in N_RollCall
        IF NOT EXISTS (SELECT * FROM N_RollCall WHERE roll_no = r2) THEN
            -- Insert into N_RollCall if it does not exist
            INSERT INTO N_RollCall (roll_no, name, address)
            SELECT roll_no, name, address FROM O_RollCall WHERE roll_no = r2;
        END IF;
    END LOOP e_loop;

    -- Close the cursor
    CLOSE c1;
END;
//

DELIMITER ;

-- Example calls to the stored procedure
CALL MergeRollCall(3);  -- This will merge roll_no 4, 5, and 6 into N_RollCall
CALL MergeRollCall(0);  -- This will merge all entries from O_RollCall into N_RollCall

-- View the contents of the N_RollCall table
SELECT * FROM N_RollCall;

-- Additional example to test with new data
CALL MergeRollCall(4);  -- This will merge roll_no 5 and 6 into N_RollCall

-- View the contents of the N_RollCall table again
SELECT * FROM N_RollCall;

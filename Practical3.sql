use Atharva;

-- Create Tables
CREATE TABLE state (
    state_no INT PRIMARY KEY,
    state_name VARCHAR(50) NOT NULL
);

CREATE TABLE capital (
    cap_no INT PRIMARY KEY,
    cap_name VARCHAR(50) NOT NULL,
    state_no INT,
    FOREIGN KEY (state_no) REFERENCES state(state_no)
);

-- Insert Sample Data
INSERT INTO state (state_no, state_name) VALUES 
(1, 'State1'),
(2, 'State2'),
(3, 'State3'),
(4, 'State4');

INSERT INTO capital (cap_no, cap_name, state_no) VALUES 
(1, 'KAR', 1),
(2, 'CAP', 2),
(3, 'MAP', 3),
(4, 'NAP', 4);

-- 1. Inner Join
SELECT c.cap_name, s.state_name
FROM capital c
INNER JOIN state s ON c.state_no = s.state_no;

-- 2. Left Join
SELECT c.cap_name, s.state_name
FROM capital c
LEFT JOIN state s ON c.state_no = s.state_no;

-- 3. Right Join
SELECT s.state_name, c.cap_name
FROM state s
RIGHT JOIN capital c ON s.state_no = c.state_no;

-- 4. Full Outer Join (Using UNION)
SELECT c.cap_name, s.state_name
FROM capital c
LEFT JOIN state s ON c.state_no = s.state_no
UNION
SELECT c.cap_name, s.state_name
FROM capital c
RIGHT JOIN state s ON c.state_no = s.state_no;

-- 5. Cross Join
SELECT c.cap_name, s.state_name
FROM capital c
CROSS JOIN state s;

-- 6. Subquery to Find Capitals with States
SELECT cap_name
FROM capital
WHERE state_no > (SELECT AVG(state_no) FROM state);

-- 7. Subquery in Select Statement
SELECT cap_name, (SELECT state_name FROM state WHERE state_no = c.state_no) AS state_name
FROM capital c;

-- 8. Create a View
CREATE VIEW CapitalStateView AS
SELECT c.cap_name, s.state_name
FROM capital c
INNER JOIN state s ON c.state_no = s.state_no;

-- 9. Querying the View
SELECT * FROM CapitalStateView;

-- 10. Update using a Join
UPDATE state s
INNER JOIN capital c ON s.state_no = c.state_no
SET s.state_name = 'UpdatedStateName'
WHERE c.cap_name = 'KAR';

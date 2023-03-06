USE employees_mod;

# 2. Create a procedure that will provide the average salary of all employees
DELIMITER $$
CREATE FUNCTION avg_salary_all()
RETURNS DECIMAL(10,2)
BEGIN
DECLARE avg_salary DECIMAL(10,2);
Select avg(salary) INTO avg_salary
from t_salaries;
RETURN avg_salary;
END
$$ DELIMITER ;

SELECT avg_salary_all();
# Answer : 63151.73

# 3. Create a procedure called ‘emp_info’ that uses as parameters the first and the last name 
# of an individual, and returns their employee number.

DROP PROCEDURE IF EXISTS emp_info;

DELIMITER $$
CREATE PROCEDURE emp_info(IN first_name VARCHAR(50), IN last_name VARCHAR(50), OUT emp_no INT)
BEGIN
  SELECT t_employees.emp_no INTO emp_no FROM t_employees WHERE first_name = t_employees.first_name AND last_name = t_employees.last_name;
END
$$ DELIMITER ;

# 4. Call the procedures
CALL emp_info('Saniya', 'Kalloufi', @emp_no);
SELECT @emp_no;

# 5. Create a function called ‘emp_info’ that takes for parameters the first and last name of an employee, 
# and returns the salary from the newest contract of that employee. Hint: In the BEGIN-END block of this program, 
# you need to declare and use two variables – v_max_from_date that will be of the DATE type, and v_salary, 
# that will be of the DECIMAL (10,2) type.

DELIMITER $$
CREATE FUNCTION emp_info(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS DECIMAL(10,2)
BEGIN
DECLARE salary DECIMAL(10,2);
Select salary INTO salary
from t_employees
join t_salaries
ON  t_employees.emp_no = t_salaries.emp_no
WHERE MAX(to_date)
GROUP BY t_salaries.emp_no;
RETURN salary;
END
$$ DELIMITER ;

SELECT emp_info('Saniya', 'Kalloufi');

SELECT * FROM t_salaries;
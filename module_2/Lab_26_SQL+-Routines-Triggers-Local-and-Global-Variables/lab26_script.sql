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

DROP FUNCTION IF EXISTS emp_info;

DELIMITER $$
CREATE FUNCTION emp_info(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS DECIMAL(10,2)
BEGIN
	DECLARE v_max_from_date DATE;
	DECLARE v_salary DECIMAL(10,2);
	SELECT MAX(to_date), salary INTO v_max_from_date, v_salary
	FROM t_employees
	JOIN t_salaries
	ON t_employees.emp_no = t_salaries.emp_no
	WHERE t_employees.first_name = first_name AND t_employees.last_name = last_name
    GROUP BY t_employees.emp_no;
	RETURN v_salary;
END
$$ DELIMITER ;

# 6. Create a trigger that checks if the hire date of an employee is higher than the current date. 
# If true, set this date to be the current date. Format the output appropriately (YY-MM-DD)

DROP TRIGGER IF EXISTS check_hire;
DELIMITER $$
CREATE TRIGGER check_hire_date
BEFORE INSERT ON t_employees
FOR EACH ROW
BEGIN
    IF NEW.hire_date > CURRENT_DATE() THEN
        SET NEW.hire_date = DATE_FORMAT(CURRENT_DATE(), '%y-%m-%d');
    END IF;
END $$ DELIMITER ;

#7. Create ‘i_hire_date’ and Drop the ‘i_hire_date’ index.
CREATE INDEX i_hire_date
ON t_employees(hire_date);
DROP INDEX i_hire_date
ON t_employees;

# 9. Use Case statement and obtain a result set containing the employee number, first name, and last name 
# of all employees with a number higher than 109990. Create a fourth column in the query, indicating whether 
# this employee is also a manager, according to the data provided in the dept_manager table, or a regular employee.

SELECT t_employees.emp_no, t_employees.first_name, t_employees.last_name,
CASE WHEN t_dept_manager.emp_no IS NULL THEN 'Regular Employee' ELSE 'Manager' END AS employee_type
FROM t_employees
LEFT JOIN t_dept_manager
ON t_employees.emp_no = t_dept_manager.emp_no
WHERE t_employees.emp_no > 109990;

# 10. Extract a dataset containing the following information about the managers: employee number, # first name, 
# and last name. Add two columns at the end – one showing the difference between the # maximum and minimum salary 
# of that employee, and another one saying whether this salary raise was higher than $30,000 or NOT.

SELECT t_employees.emp_no, t_employees.first_name, t_employees.last_name, 
(max(t_salaries.salary) - min(t_salaries.salary)) AS salary_diff,
CASE WHEN salary_diff > 30000 THEN 'Higher' ELSE 'Not Higher' END AS salary_raise
FROM t_employees
INNER JOIN t_dept_manager ON t_employees.emp_no = t_dept_manager.emp_no
INNER JOIN (
   SELECT t_salaries.emp_no, MAX(t_salaries.salary) AS max_salary, MIN(t_salaries.salary) AS min_salary
   FROM t_salaries
   GROUP BY t_salaries.emp_no
) t_salaries ON t_employees.emp_no = t_salaries.emp_no;
# i get an error "unknown column t_salaries.salary in field list" which i don't understand

SELECT * FROM t_dept_emp;

# 11. Extract the employee number, first name, and last name of the first 100 employees, 
#and add a fourth column, called “current_employee” saying “Is still employed” if the employee 
# is still working in the company, or “Not an employee anymore” if they aren’t. Hint: You’ll need to use data from both the ‘employees’ and the ‘dept_emp’ table to solve this exercise.

SELECT t_employees.emp_no, t_employees.first_name, t_employees.last_name,
  CASE WHEN t_dept_emp.to_date = '9999-01-01' THEN 'Is still employed' ELSE 'Not an employee anymore' END AS current_employee
FROM t_employees
INNER JOIN t_dept_emp ON t_employees.emp_no = t_dept_emp.emp_no
ORDER BY t_employees.emp_no
LIMIT 100;
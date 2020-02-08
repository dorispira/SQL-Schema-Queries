DROP TABLE IF EXISTS departments;
DROP TABLE IF EXISTS dept_emp;
DROP TABLE IF EXISTS dept_manager;
DROP TABLE IF EXISTS employees;
DROP TABLE IF EXISTS salaries;
DROP TABLE IF EXISTS titles;

CREATE TABLE "departments" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "dept_name" VARCHAR(255)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INTEGER   NOT NULL,
    "dept_no" VARCHAR(255)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR(255)   NOT NULL,
    "emp_no" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INTEGER   NOT NULL,
    "birth_date" DATE   NOT NULL,
    "first_name" VARCHAR(255)   NOT NULL,
    "last_name" VARCHAR(255)   NOT NULL,
    "gender" VARCHAR(255)   NOT NULL,
    "hire_date" DATE   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INTEGER   NOT NULL,
    "salary" INTEGER   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "emp_no" INTEGER   NOT NULL,
    "title" VARCHAR(255)   NOT NULL,
    "from_date" DATE   NOT NULL,
    "to_date" DATE   NOT NULL
);

SELECT * FROM departments
SELECT * FROM dept_emp
SELECT * FROM dept_manager
SELECT * FROM employees
SELECT * FROM salaries
SELECT * FROM titles

--List the following details of each employee: employee number, last name, first name, gender, and salary.
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.gender, salaries.salary
FROM employees
JOIN salaries ON employees.emp_no = salaries.emp_no

--List employees who were hired in 1986
SELECT emp_no, last_name, first_name, hire_date
FROM employees
WHERE hire_date BETWEEN '1986-01-01' AND '1987-01-01'

--List the manager of each department with the following information: 
--department number, department name, the manager's employee number, last name, first name, and start and end employment dates.
SELECT dm.dept_no, dpt.dept_name, dm.emp_no, e.last_name, e.first_name, e.hire_date, dm.to_date
FROM dept_manager dm
JOIN departments dpt ON dpt.dept_no = dm.dept_no
JOIN employees e ON dm.emp_no = e.emp_no

--List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, dpt.dept_name
FROM dept_emp de
JOIN employees e ON e.emp_no = de.emp_no
JOIN departments dpt ON dpt.dept_no = de.dept_no

--List all employees whose first name is "Hercules" and last names begin with "B."
SELECT first_name, last_name
FROM employees
WHERE first_name = 'Hercules' AND last_name LIKE 'B%'

--List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, dpt.dept_name
FROM dept_emp de
JOIN employees e ON e.emp_no = de.emp_no
JOIN departments dpt ON dpt.dept_no = de.dept_no
WHERE dept_name = 'Sales'

--List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT de.emp_no, e.last_name, e.first_name, dpt.dept_name
FROM dept_emp de
JOIN employees e ON e.emp_no = de.emp_no
JOIN departments dpt ON dpt.dept_no = de.dept_no
WHERE dept_name = 'Sales' OR dept_name = 'Development'

--In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name, COUNT(last_name) AS "Total"
FROM employees
GROUP BY last_name
ORDER BY "Total" DESC

--Bonus: SEE JUPYTER NOTEBOOK

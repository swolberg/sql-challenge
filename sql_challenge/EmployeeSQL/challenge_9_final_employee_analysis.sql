-- Table Creation Statements

    CREATE TABLE IF NOT EXISTS departments (
        dept_no CHAR(4) PRIMARY KEY,
        dept_name VARCHAR(40) NOT NULL
    );
    

    CREATE TABLE IF NOT EXISTS employees (
        emp_no INT PRIMARY KEY,
        birth_date DATE NOT NULL,
        first_name VARCHAR(50) NOT NULL,
        last_name VARCHAR(50) NOT NULL,
        hire_date DATE NOT NULL
    );
    

    CREATE TABLE IF NOT EXISTS salaries (
        emp_no INT PRIMARY KEY,
        salary INT NOT NULL,
        FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
    );
    

    CREATE TABLE IF NOT EXISTS titles (
        emp_no INT PRIMARY KEY,
        title VARCHAR(50) NOT NULL,
        FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
    );
    

    CREATE TABLE IF NOT EXISTS dept_emp (
        emp_no INT NOT NULL,
        dept_no CHAR(4) NOT NULL,
        PRIMARY KEY (emp_no, dept_no),
        FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
        FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
    );
    

    CREATE TABLE IF NOT EXISTS dept_manager (
        emp_no INT NOT NULL,
        dept_no CHAR(4) NOT NULL,
        PRIMARY KEY (emp_no, dept_no),
        FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
        FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
    );
    

-- Analysis Queries
-- 1. Employee details and salaries

        SELECT employees.emp_no, employees.last_name, employees.first_name, salaries.salary
        FROM employees
        JOIN salaries ON employees.emp_no = salaries.emp_no;
    
-- 2. Employees hired in 1986

        SELECT first_name, last_name, hire_date
        FROM employees
        WHERE hire_date LIKE '1986%';
    
-- 3. Managers and their departments

        SELECT dept_manager.dept_no, departments.dept_name, employees.emp_no, employees.last_name, employees.first_name
        FROM dept_manager
        JOIN departments ON dept_manager.dept_no = departments.dept_no
        JOIN employees ON dept_manager.emp_no = employees.emp_no;
    
-- 4. Department details for employees

        SELECT dept_emp.dept_no, employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
        FROM dept_emp
        JOIN employees ON dept_emp.emp_no = employees.emp_no
        JOIN departments ON dept_emp.dept_no = departments.dept_no;
    
-- 5. Employees named Hercules B*

        SELECT first_name, last_name
        FROM employees
        WHERE first_name = 'Hercules' AND last_name LIKE 'B%';
    
-- 6. Employees in Sales department

        SELECT employees.emp_no, employees.last_name, employees.first_name
        FROM employees
        JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
        JOIN departments ON dept_emp.dept_no = departments.dept_no
        WHERE departments.dept_name = 'Sales';
    
-- 7. Employees in Sales and Development

        SELECT employees.emp_no, employees.last_name, employees.first_name, departments.dept_name
        FROM employees
        JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
        JOIN departments ON dept_emp.dept_no = departments.dept_no
        WHERE departments.dept_name IN ('Sales', 'Development');
    
-- 8. Frequency of last names

        SELECT last_name, COUNT(last_name) AS name_count
        FROM employees
        GROUP BY last_name
        ORDER BY name_count DESC;
    

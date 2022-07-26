-- Deliverable 1

--Retiring Employees into retirement_titles
SELECT e.emp_no,
	e.first_name,
	e.last_name,
	t.title,
	t.from_date,
	t.to_date
INTO retirement_titles
FROM employees as e
LEFT JOIN titles as t
ON e.emp_no = t.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY e.emp_no;

-- Retiring employees most recent titles
SELECT DISTINCT ON (emp_no) emp_no,
    first_name,
	last_name,
    title
INTO unique_titles
FROM retirement_titles
WHERE to_date = '9999-01-01'
ORDER BY emp_no, to_date DESC;

--Retrieve number of retiring employees by job title
SELECT COUNT(title) as Count,
    title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY Count DESC;


-- Deliverable 2

SELECT DISTINCT ON (e.emp_no) e.emp_no,
    e.first_name,
    e.last_name,
    e.birth_date,
    de.from_date,
    de.to_date,
    t.title
--INTO mentorship_eligibility
FROM employees as e
LEFT JOIN dept_emp as de
ON e.emp_no = de.emp_no
LEFT JOIN titles as t
ON t.emp_no = e.emp_no
WHERE (de.to_date = '9999-01-01' AND e.birth_date BETWEEN '1965-01-01' AND '1965-12-31')
ORDER BY emp_no; 


-- Deliverable 3

-- Count of current employees
SELECT COUNT (emp_no) as Current_Employee_Count
FROM dept_emp
WHERE to_date = '9999-01-01';
-- OUTPUT: 240,124

-- Count of current retiring-age employees
SELECT COUNT (emp_no) as Retiree_count
FROM current_emp;
--OUTPUT: 33,118

-- Count of mentorship_eligible retirees
SELECT COUNT (emp_no) as Retirees_Born_1965
FROM mentorship_eligibility;
-- OUTPUT: 1549


-- Additional Queries

-- Current Retirees and Years Served
SELECT ce.emp_no,
    ce.first_name,
    ce.last_name,
    e.hire_date,
    (current_date - e.hire_date)/365  AS years_served
FROM current_emp as ce
LEFT JOIN employees as e
ON ce.emp_no = e.emp_no
ORDER BY e.hire_date;

-- Most experienced mentors
SELECT me.emp_no,
    me.first_name,
    me.last_name,
    e.hire_date,
    (current_date - e.hire_date)/365 AS years_served
FROM mentorship_eligibility as me
LEFT JOIN employees as e
ON me.emp_no = e.emp_no
ORDER BY e.hire_date;

--Revenue available by department if all eligible were to retire
SELECT sum(s.salary) AS retiree_salaries,
	di.dept_name
FROM dept_info as di
LEFT JOIN salaries as s
ON di.emp_no = s.emp_no
GROUP BY di.dept_name;
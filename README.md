# Pewlitt-Hackard-Analysis

## Overview
Pewlit-Hackard is a large company of 240,124 employees as of 7/24/22.  With that many employees it is important to keep track of how many are retiring so that there are not a large number of vacant positions at once, which can impact external customers as the company scrambles to correct a worker shortage.  In order to be proactive and reduce the impact of a coming wave of retirees, I have completed several queries on the PH-EmployeeDB database to determine how many are close to retiring age, which departments will see shortages, and who might be good employee candidates for a mentorship program to utilize their years of experience before they leave the company.  Using this information, Human Resources can begin recruiting to fill positions before the potential "silver tsunami" hits.

## Results
![Retire_Count_By_Title](https://user-images.githubusercontent.com/102555125/180856259-55ae2288-3ad5-4516-8dd8-507739da5778.png)

### Retiring Employee Count by Job Title
- From this table you can see that Engineers are going to be heavily impacted by retirement in the near future.  Between Senior Engineers, Engineers, and Assitant Engineers, there is a potential deficit of 36,291 engineers of various levels.  Therefore, recruitment for engineers and promotion of Engineers and Assistant Engineers should be prioritized to fill that need.  Perhaps the mentorship program would be able to assist in both the hiring of new engineers and preparing the non-retiring engineers to move up and fill the senior positions.

- The next largest category for recruitment is in Senior Staff and Staff with a total of 32,562 potential retirees.  Since this category is likely to include a diverse range of duties and skills, I would recommend recruiting experts from within departments or teams to aid in recruitment of Senior Staff and new staff.

### Mentorship Eligibility
- There are 1,549 potential retirees spread over all departments who would be eligible for a mentorship program comprised of all current employees who were born in 1965.  

- I realize the intent of narrowing the query to only those born in 1965 was likely to reduce the number of results, but employees born before 1965 should also be considered for the mentorship program.  Depending on how the mentorship program will work, the 1,549 retirees eligible under the rule that they be born in 1965 would be spread too thinly to be effective: each mentor would have about 133 non-retiring employees to mentor.  Even expanding the mentorship program query to those born in 1964 and 1965 would reduce the number of employees per mentor from 133 to 12.

## Summary

### Number of Roles to be Filled
![retiree_count](https://user-images.githubusercontent.com/102555125/180857315-dc9ee24c-2c63-4146-9efa-c3b99eee6a95.png)

Without evaluation of departmental needs, there is a potential for 33,118 vacancies by the time the "silver tsunami" is complete.  Engineering roles will be the hardest hit, followed by general staff.  It would be wise to ask these potential retirees if they have plans to retire in the next year in order to prepare to fill those positions first.

### Qualified Mentors
![current_emp_count](https://user-images.githubusercontent.com/102555125/180856179-0ab7013b-78af-4aa5-b176-22b60cadc5ee.png)
![retirees_1965](https://user-images.githubusercontent.com/102555125/180856195-3447ffa3-8014-4000-afad-5c17f7b34637.png)

As mentioned previously, there are not enough eligible mentors in the mentorship program to mentor the next generation of Pewlitt Hackard employees.  Even if all employees born in 1965 were to agree to mentor other employees, 133 younger employees per mentor would be too many to be effective.  Expanding the program to include those born in 1964 would be better, but given willing participation requirements, it may need to be expanded even further.  My recommedation would be to, instead, survey all potential retirees to gauge who would be willing to participate in order to get enough mentors to be effective.

### Queries

#### Queries used above
To use the above queries, access the sql file called Employee_database_challenge.sql in Queries folder in this repository.

#### Additional Queries
##### Years of Service
Given there are so many employees approaching retirement age, two additional queries pasted below pulls in a list of all currently employed retirees with their years employed with Pewlitt Hackard and a similar list of just mentorship-program-eligible employees.  This will be useful in both recognizing dedicated employees for their years of service, and finding the most experienced mentors to recruit for the mentorship program.

```
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
```

```
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
```

##### Available Revenue by Department
With so many people retiring, there will be extra funding available to hire new employees.  Since most of these employees have been with the company for more than 20 years, that amount of money will be significant.  Below is a query that tallies the salaries of all retirees by department to give each department an idea of how much money will be available per year as eligible employees retire.  It may be worth it in some instances to offer early retirement in order to save money or hire additional resources.

![Salary_by_dept](https://user-images.githubusercontent.com/102555125/180860158-e5a5b401-6333-4615-959c-d4ec8bcf57c9.png)
```
--Revenue available by department if all eligible were to retire
SELECT sum(s.salary) AS retiree_salaries,
	di.dept_name
FROM dept_info as di
LEFT JOIN salaries as s
ON di.emp_no = s.emp_no
GROUP BY di.dept_name;
```

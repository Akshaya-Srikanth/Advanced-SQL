/*Company_code, founder name, total number of lead managers, total number of senior managers, total number of managers, and total number of employees. Order your output by ascending company_code.*/

select cp.company_code, cp.founder , count(distinct lm.lead_manager_code) lead_manager_code, count(distinct sm.senior_manager_code) senior_manager_code , count(distinct mn.manager_code) manager_code, count(distinct ep.employee_code) employee_code from Company cp join Lead_Manager lm on lm.company_code = cp.company_code join Senior_Manager sm on sm.company_code = lm.company_code join Manager mn on mn.company_code = sm.company_code join Employee ep on ep.company_code = mn.company_code

group by cp.company_code, cp.founder order by cp.company_code asc;
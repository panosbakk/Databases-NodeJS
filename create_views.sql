CREATE VIEW project_info AS
SELECT
projects.id, title, summary, budget, starting_date, end_date,
TIMESTAMPDIFF(month, starting_date, end_date) AS duration,
employee_id, emp_name AS employee_name
FROM projects
INNER JOIN ELIDEK_employees ON ELIDEK_employees.id = projects.employee_id;

CREATE VIEW researcher_info AS
SELECT DISTINCT
researchers.id AS id,
CONCAT(first_name, ' ', last_name) AS full_name,
TIMESTAMPDIFF(year, researchers.birth_date, CURRENT_DATE()) as age, sex, organization_id, org_name
FROM researchers
INNER JOIN organizations ON researchers.organization_id = organizations.id
ORDER BY researchers.id;

CREATE VIEW projects_by_researcher AS
SELECT DISTINCT researchers.id AS researcher_id, CONCAT(first_name, ' ', last_name) as full_name, projects.id AS project_id, title
FROM projects
INNER JOIN project_researcher_relationship ON project_researcher_relationship.project_id = projects.id
INNER JOIN researchers ON project_researcher_relationship.researcher_id = researchers.id
ORDER BY researcher_id

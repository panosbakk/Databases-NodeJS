/* =====================
	QUERY 3.1
===================== */

SELECT * from programs;

SET @id = 3;

SELECT DISTINCT
researchers.id,
CONCAT(first_name, ' ', last_name) as full_name,
TIMESTAMPDIFF(year, researchers.birth_date, CURRENT_DATE()) as age,
sex
FROM researchers
INNER JOIN project_researcher_relationship ON project_researcher_relationship.researcher_id = id
INNER JOIN projects ON project_researcher_relationship.project_id = projects.id
WHERE projects.id = @id;
ORDER BY researchers.id

SET @starting_date = '';
SET @duration = 25;
SET @employee_id = 1;

SELECT * FROM project_info
WHERE starting_date = @starting_date OR duration = @duration OR employee_id = @employee_id

/* =====================
	QUERY 3.2
===================== */

SELECT * FROM projects_by_researcher;
SELECT * FROM project_info;

/* ===================
	QUERY 3.3
=================== */

SET @field_name = 'Natural science';

SELECT project_researcher_relationship.project_id, projects.title, project_researcher_relationship.researcher_id, CONCAT(first_name, ' ', last_name) as full_name
FROM projects
INNER JOIN project_researcher_relationship ON project_researcher_relationship.project_id = projects.id
INNER JOIN researchers ON project_researcher_relationship.researcher_id = researchers.id
INNER JOIN project_scientific_field ON project_scientific_field.project_id = projects.id
INNER JOIN scientific_fields ON project_scientific_field.field_id = scientific_fields.id
WHERE field_name = @field_name AND projects.end_date IS NULL

/* ==================
	QUERY 3.4
================== */

SELECT l.organization_id, l.org_name, l.projects_number
FROM ( 
	SELECT DISTINCT A.organization_id, org_name, COUNT(A.id) AS projects_number
	FROM projects A
	INNER JOIN organizations ON A.organization_id = organizations.id
	WHERE EXISTS (
		SELECT 1 FROM projects B
		INNER JOIN organizations ON B.organization_id = organizations.id
		WHERE B.organization_id = A.organization_id
		AND year(A.starting_date) = year(B.starting_date) + 1)
GROUP BY A.organization_id) AS l 
INNER JOIN (
	SELECT DISTINCT A.organization_id, COUNT(A.id) AS projects_number
	FROM projects A
	INNER JOIN organizations ON A.organization_id = organizations.id
	WHERE EXISTS (
		SELECT 1 FROM projects B
		INNER JOIN organizations ON B.organization_id = organizations.id
		WHERE B.organization_id = A.organization_id
		AND year(B.starting_date) = year(A.starting_date) + 1)
GROUP BY A.organization_id) AS m
ON l.organization_id = m.organization_id
WHERE l.projects_number = m.projects_number AND l.projects_number >= 1
GROUP BY l.organization_id
ORDER BY l.projects_number DESC

/* =================
	QUERY 3.5
================= */

SELECT DISTINCT field_pair, COUNT(field_pair) AS sum
FROM (
	SELECT CONCAT(A.field_id, ' ', B.field_id) AS field_pair, A.project_id
	FROM project_scientific_field A, project_scientific_field B
	WHERE A.field_id != B.field_id AND A.project_id = B.project_id
	ORDER BY A.project_id) AS kekw
WHERE field_pair LIKE '1_2' OR field_pair LIKE '1_3' OR field_pair LIKE '1_4' OR field_pair LIKE '2_3' OR field_pair LIKE '2_4' OR field_pair LIKE '3_4'
GROUP BY kekw.field_pair
ORDER BY sum DESC, field_pair ASC
LIMIT 3

/* ================
	QUERY 3.6
================ */

SELECT DISTINCT
CONCAT(first_name, ' ', last_name) AS full_name,
COUNT(project_researcher_relationship.project_id) AS projects_number
FROM researchers
INNER JOIN project_researcher_relationship ON project_researcher_relationship.researcher_id = researchers.id
INNER JOIN projects ON project_researcher_relationship.project_id = projects.id
WHERE projects.end_date IS NULL AND TIMESTAMPDIFF(year, researchers.birth_date, CURRENT_DATE()) < 40 
GROUP BY researchers.id
ORDER BY projects_number DESC

/* ================
	QUERY 3.7
================ */

SELECT emp_name, org_name AS company_name, SUM(projects.budget) AS total_finance
FROM ELIDEK_employees
INNER JOIN projects ON projects.employee_id = ELIDEK_employees.id
INNER JOIN organizations ON projects.organization_id = organizations.id
INNER JOIN company ON company.organization_id = organizations.id
GROUP BY organizations.id
ORDER BY total_finance DESC
LIMIT 5

/* ================
	QUERY 3.8
================ */

SELECT DISTINCT
CONCAT(first_name, ' ', last_name) AS full_name,
COUNT(project_researcher_relationship.project_id) AS projects_number
FROM researchers
INNER JOIN project_researcher_relationship ON project_researcher_relationship.researcher_id = researchers.id
WHERE NOT EXISTS (
	SELECT * FROM deliverable WHERE deliverable.project_id = project_researcher_relationship.project_id
)
GROUP BY researchers.id
HAVING COUNT(project_researcher_relationship.project_id) >= 5
ORDER BY projects_number DESC
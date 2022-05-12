/* =====================
	CREATE ENTITIES 
======================*/

DROP TABLE IF EXISTS projects;
CREATE TABLE projects
(
	id int auto_increment PRIMARY KEY,
    title varchar (10) not null,
	summary varchar (200) not null,
	amount int not null,
	starting_date date,
    end_date date
);

DROP TABLE IF EXISTS researchers;
CREATE TABLE researchers
(
	id int auto_increment PRIMARY KEY,
    first_name varchar (20) not null,
    last_name varchar (20) not null,
    sex varchar (6) not null,
	birth_date date
);

DROP TABLE IF EXISTS organizations;
CREATE TABLE organizations
(
	id int auto_increment PRIMARY KEY,
    org_name varchar (10) not null,
	abbreviation varchar (5) not null,
    street varchar (20) not null,
    street_number int not null,
    postal_code int not null,
    city varchar (20) not null,
    phone varchar (20) not null,
    category varchar (20) not null,
    budget int not null
);

DROP TABLE IF EXISTS ELIDEK_employee;
CREATE TABLE ELIDEK_employee
(
	id int auto_increment PRIMARY KEY,
    emp_name varchar (20) not null
);

DROP TABLE IF EXISTS programs;
CREATE TABLE programs
(
	id int auto_increment PRIMARY KEY,
    prog_name varchar (20) not null,
	prog_address varchar (20) not null

);

DROP TABLE IF EXISTS scientific_fields;
CREATE TABLE scientific_fields
(
	field_name varchar (20) not null
);

DROP TABLE IF EXISTS delivery;
CREATE TABLE delivery
(
	title varchar (10) not null,
    summary varchar (200) not null
);

/* ============================
    CREATE ENTITY RELATIONS
============================ */

DROP TABLE IF EXISTS assessment;
CREATE TABLE assessment
(
	assessment_date date,
    grade int
);

DROP TABLE IF EXISTS scientific_director;
CREATE TABLE scientific_director
(
	researcher_ID int,
    FOREIGN KEY (researcher_ID) REFERENCES researcher(id),
    project_ID int,
    FOREIGN KEY (project_ID) REFERENCES project(id)
);

DROP TABLE IF EXISTS employee_relatioship;
CREATE TABLE employee_relatioship
(
	researcher_ID int,
    FOREIGN KEY (researcher_ID) REFERENCES researcher(id),
    organization_ID int,
    FOREIGN KEY (organization_ID) REFERENCES organization(id),
    hire_date date
);

/* ========================================
	ADD ALL FOREIGN KEYS (1-N relations)
======================================== */
ALTER TABLE delivery
ADD project_ID int,
ADD FOREIGN KEY (project_ID) REFERENCES project(id);

ALTER TABLE researcher
ADD organization_ID int,
ADD FOREIGN KEY (organization_ID) REFERENCES organization(id);

ALTER TABLE project
ADD employee_ID int,
ADD FOREIGN KEY (employee_ID) REFERENCES ELIDEK_employee(id),
ADD program_ID int,
ADD FOREIGN KEY (program_ID) REFERENCES ELIDEK_program(id),
ADD researcher_ID int,
ADD FOREIGN KEY (researcher_ID) REFERENCES researcher(id),
ADD organization_ID int,
ADD FOREIGN KEY (organization_ID) REFERENCES organization(id);
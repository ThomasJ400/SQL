CREATE DATABASE exercise3;

USE exercise3;

CREATE TABLE student
(
	stu_id VARCHAR(254),
	stu_pps VARCHAR(254) UNIQUE NOT NULL,
	stu_fname VARCHAR(254),
	stu_sname VARCHAR(254) NOT NULL,
	stu_gender ENUM("M","F","m","f"),
	PRIMARY KEY(stu_id)
);

SHOW TABLES;

DESCRIBE student;

INSERT INTO student VALUES("K10023","P10089","John","Barry","M");
INSERT INTO student VALUES("K10025","P10355","Jim","Ryan","M");
INSERT INTO student VALUES("K10045","P10089","Mary","Bishop","F");
INSERT INTO student VALUES("K10023","P10034","Mark","O'Carroll","X");
INSERT INTO student VALUES("K12234","P12334","Frank",null,"m");
INSERT INTO student VALUES("K11122","P10345",null,"Ryan","f");
INSERT INTO student VALUES("K10023","P10032","Grace","Black","F");
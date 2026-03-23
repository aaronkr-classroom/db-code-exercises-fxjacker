/*

[Entities / 개체]
-Professor

[Properties / 속성]
-id 			(BIFSERIAL) -- 자동으로 증가하는 숫자
-name			(VARCHAR(30))
-dept 			(VARCHAR(50))
-salary 		(NUMRIC)
-salary_level	(NUMRIC)
-hire_Date		(DATE)
-students
*/
CREATE TABLE prof(
	id bigserial,
	name varchar(30),
	dept varchar(50),
	salary numeric,
	salary_level numeric,
	hire_date date
);

select * from prof;

-- 데이터 삽입하기
INSERT INTO prof (name, dept, salary, salary_level, hire_date)
VALUES 
    ('김정은', '컴퓨터 공학과', 100000, 2, '1998-12-31'),
    ('박지성', 'AI공학', 60000, 2, '2000-07-23'),
    ('이재성', '컴퓨터 공학과', 70000, 2, '1985-05-11'),
    ('류현진', '간호학과', 20000, 2, '1924-01-21'),
    ('양정효', '소프트웨어 공학과', 90000, 2, '2007-12-31');

SELECT name, salary FROM porf;
SELECT name, salary FROM prof ORDER BY salary DESC; -- ASC
SELECT name, salary FROM prof WHERE salary > 90000;

SELECT name, salary FROM prof WHERE name LIKE '김%'; -- POSTSQL 대.소문자 상관없다

SELECT name, dept FROM prof
	WHERE dept LIKE'%공%'
	ORDER BY dept ASC;

SELECT name, salary FROM prof WHERE salary BETWEEN 70000 and 90000;

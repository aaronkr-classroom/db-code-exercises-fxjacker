/*
-- 문화센터 예시

-- 릴레이션 스키마
	강사(강사번호(PK), 이름, 전문분야, 연락처)
	강좌(강좌번호(PK),강좌명,수강료,최대인원,강사번호(FK))
	회원(회원번호(PK),이름, 전화번호, 가입일)
	수강신청(회원번호(FK),강좌번호(FK),신청일)

-- 간단한 ERD
	강사 --- 1:N --- 강좌 ---N:M --- 회원 (원래)
	강사 --- 1:N --- 강좌 --- 1:N --- 수강신청 --- N:1 --- 회원
*/
CREATE TABLE instructors(
	instructors_id INT PRIMARY KEY, --- 자동 인덱스
	name VARCHAR(30) NOT NULL,
	specialty VARCHAR(50),
	phone VARCHAR(13)
);

CREATE TABLE classes(
	---최대인원은 5-50명! CHECK 필수
	class_id INT PRIMARY KEY, -- 자동인덱스
	class_name VARCHAR(50) NOT NULL,
	fee INT CHECK (fee>=0),
	max_students INT CHECK(max_students BETWEEN 5 AND 50),
	instructors_id INT, -- FK

	FOREIGN KEY(instructors_id)
		REFERENCES instructors(instructors_id)
);

CREATE TABLE members(
	member_id INT PRIMARY KEY, -- 자동 인덱스
	name VARCHAR(30) NOT NULL,
	phone VARCHAR(13),
	join_date DATE
);

CREATE TABLE registrations(
    member_id INT,
    class_id INT,
    register_date DATE,

    PRIMARY KEY(member_id, class_id),

    FOREIGN KEY(member_id)
        REFERENCES members(member_id)
        ON DELETE CASCADE,

    FOREIGN KEY(class_id)
        REFERENCES classes(class_id)
        ON DELETE CASCADE
);

-- INSERT
INSERT INTO instructors VALUES
(1, '김영희', '요가','010-1111-1111'),
(2,'박민수','드로잉','010-2222-2222'),
(3,'이지은','영어회화','010-3333-3333');

INSERT INTO classes VALUES 
(101, '아침요가', 50000, 20, 1),
(102, '수채화기초', 70000, 15, 2),
(103, '영어 회화', 60000, 25, 3);

INSERT INTO members VALUES
(1001,'홍길동','010-9999-9999','2026-03-01'),
(1002,'김철수','010-8888-8888','2026-03-02'),
(1003,'이영희','010-7777-7777','2026-03-03');

INSERT INTO registrations VALUES
(1001,101,'2026-03-04'),
(1001,103,'2026-03-05'),
(1002,101,'2026-03-06'),
(1003,102,'2026-03-07');

-- JOIN
SELECT m.name,
       c.class_name
FROM registrations r
JOIN members m ON r.member_id = m.member_id
JOIN classes c ON r.class_id = c.class_id;

--INDEX
--members에서 100,000만명 추가
CREATE TABLE members2(
	member_id SERIAL PRIMARY KEY,
	name VARCHAR(30) NOT NULL,
	phone VARCHAR(13),
	join_date DATE
);

INSERT INTO members2( name, phone, join_date)
SELECT 
    'Member_' || g,
    '010' || LPAD((random()*9999)::int::text,4,'0')
          || '-'
          || LPAD((random()*9999)::int::text,4,'0'),
    CURRENT_DATE - (random()*1000)::int
FROM generate_series(1,100000) g;

INSERT INTO members2(name, phone, join_date)
values('홍길동','010-1234-5678',current_date);

TABLE members2;

-- 검색 시간 확인하기
EXPLAIN ANALYZE
SELECT * FROM members2
WHERE name = '홍길동'; --
-- Planning time 1.483ms
-- Execution time: 7.417ms

-- index 추가
CREATE INDEX idx_members_name2
ON members2(name);

EXPLAIN ANALYZE
SELECT * FROM members2
WHERE name = '홍길동'; 
-- Planning time 2.707ms
-- Execution time: 0.169ms




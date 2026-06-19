-- =================================================================
-- DB Final Project
-- Student Name: 안광현 
-- Student ID: 2126092
-- =================================================================

-- 기존 테이블 삭제
DROP TABLE IF EXISTS assign_bus CASCADE;
DROP TABLE IF EXISTS assign_driver CASCADE;
DROP TABLE IF EXISTS reserve CASCADE;
DROP TABLE IF EXISTS tour CASCADE;
DROP TABLE IF EXISTS staff CASCADE;
DROP TABLE IF EXISTS customer CASCADE;
DROP TABLE IF EXISTS task_code CASCADE;
DROP TABLE IF EXISTS class_code CASCADE;
DROP TABLE IF EXISTS driver CASCADE;
DROP TABLE IF EXISTS tour_bus CASCADE;


-- 1. CREATE TABLE

-- class_code
CREATE TABLE class_code (
    code INTEGER PRIMARY KEY,
    class VARCHAR(10) NOT NULL,
    basis VARCHAR(50)
);

-- task_code
CREATE TABLE task_code (
    code INTEGER PRIMARY KEY,
    task VARCHAR(30) NOT NULL
);

-- customer
CREATE TABLE customer (
    cus_id VARCHAR(15) PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    cell VARCHAR(20) NOT NULL UNIQUE,
    addr VARCHAR(100),
    C_Code INTEGER DEFAULT 3,
    FOREIGN KEY (C_Code) REFERENCES class_code(code)
);

-- staff
CREATE TABLE staff (
    staff_id INTEGER PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    birthday CHAR(6) NOT NULL,
    tel VARCHAR(20),
    salary INTEGER,
    t_code INTEGER NOT NULL,
    hire_date CHAR(8) NOT NULL,
    FOREIGN KEY (t_code) REFERENCES task_code(code)
);

-- tour
CREATE TABLE tour (
    tour_num CHAR(8) PRIMARY KEY,
    departure VARCHAR(50) NOT NULL,
    arrival VARCHAR(50) NOT NULL,
    program VARCHAR(100),
    start_dt TIMESTAMP NOT NULL,
    end_dt TIMESTAMP NOT NULL,
    min_num INTEGER,
    max_num INTEGER,
    expense INTEGER NOT NULL,
    deposit INTEGER,
    dept_yn CHAR(1) DEFAULT 'N',
    staff_id INTEGER,
    FOREIGN KEY (staff_id) REFERENCES staff(staff_id)
);

-- reserve
CREATE TABLE reserve (
    cus_id VARCHAR(15),
    tour_num CHAR(8),
    res_date CHAR(8) DEFAULT TO_CHAR(CURRENT_DATE, 'YYYYMMDD'),
    dep_yn CHAR(1) DEFAULT 'N',
    exp_yn CHAR(1) DEFAULT 'N',
    PRIMARY KEY (cus_id, tour_num),
    FOREIGN KEY (cus_id) REFERENCES customer(cus_id),
    FOREIGN KEY (tour_num) REFERENCES tour(tour_num)
);

-- driver
CREATE TABLE driver (
    driver_id INTEGER PRIMARY KEY,
    name VARCHAR(20) NOT NULL,
    birthday CHAR(6) NOT NULL,
    cell VARCHAR(20) NOT NULL,
    pay INTEGER DEFAULT 15000,
    cont_date CHAR(8),
    cont_term CHAR(8)
);

-- tour_bus
CREATE TABLE tour_bus (
    bus_id INTEGER PRIMARY KEY,
    seat INTEGER,
    del_year INTEGER
);

-- assign_driver
CREATE TABLE assign_driver (
    tour_num CHAR(8),
    driver_id INTEGER,
    work_hour INTEGER,
    PRIMARY KEY (tour_num, driver_id),
    FOREIGN KEY (tour_num) REFERENCES tour(tour_num),
    FOREIGN KEY (driver_id) REFERENCES driver(driver_id)
);

-- assign_bus
CREATE TABLE assign_bus (
    tour_num CHAR(8),
    bus_id INTEGER,
    PRIMARY KEY (tour_num, bus_id),
    FOREIGN KEY (tour_num) REFERENCES tour(tour_num),
    FOREIGN KEY (bus_id) REFERENCES tour_bus(bus_id)
);


-- 2. INSERT DATA

INSERT INTO class_code VALUES (1, '최우수', '우수고객');
INSERT INTO class_code VALUES (2, '우수', '단골고객');
INSERT INTO class_code VALUES (3, '일반', '신규고객');

INSERT INTO task_code VALUES (1, '여행상품관리');
INSERT INTO task_code VALUES (2, '예약관리');
INSERT INTO task_code VALUES (3, '관광버스배차관리');
INSERT INTO task_code VALUES (4, '직원관리');
INSERT INTO task_code VALUES (5, '고객관리');

INSERT INTO customer VALUES ('cus01', '김지훈', '010-1111-2222', '서울시 강남구', 1);
INSERT INTO customer VALUES ('cus02', '이민서', '010-3333-4444', '경기도 수원시', 3);
INSERT INTO customer VALUES ('cus03', '박준영', '010-5555-6666', '인천시 부평구', 2);
INSERT INTO customer VALUES ('cus04', '최예진', '010-7777-8888', '충북 충주시', 3);
INSERT INTO customer VALUES ('cus05', '정우진', '010-9999-0000', '강원도 원주시', 2);

INSERT INTO staff VALUES (101, '이철수', '880123', '02-555-1234', 3500000, 1, '20200101');
INSERT INTO staff VALUES (102, '김영희', '920515', '02-444-5678', 3200000, 2, '20210315');
INSERT INTO staff VALUES (103, '박민석', '951025', '010-2222-8888', 2800000, 3, '20230501');
INSERT INTO staff VALUES (104, '최수민', '900707', '02-333-9999', 4000000, 4, '20181101');
INSERT INTO staff VALUES (105, '한재희', '970312', '010-7777-3333', 2700000, 5, '20240901');

INSERT INTO tour VALUES ('T001', '서울', '제주도', 'http://tour.com/jeju', '2026-07-01 09:00:00', '2026-07-04 18:00:00', 10, 30, 350000, 50000, 'N', 101);
INSERT INTO tour VALUES ('T002', '서울', '경주', 'http://tour.com/gyeongju', '2026-07-10 08:00:00', '2026-07-11 17:00:00', 15, 40, 120000, 20000, 'N', 101);
INSERT INTO tour VALUES ('T003', '부산', '설악산', 'http://tour.com/seorak', '2026-08-05 07:00:00', '2026-08-05 20:00:00', 20, 45, 60000, 10000, 'N', 102);
INSERT INTO tour VALUES ('T004', '대전', '여수', 'http://tour.com/yeosu', '2026-08-15 06:00:00', '2026-08-17 19:00:00', 12, 30, 250000, 30000, 'N', 103);
INSERT INTO tour VALUES ('T005', '서울', '단양', 'http://tour.com/danyang', '2026-09-01 09:00:00', '2026-09-01 18:00:00', 10, 25, 50000, 5000, 'N', 101);

INSERT INTO reserve VALUES ('cus01', 'T001', '20260501', 'Y', 'Y');
INSERT INTO reserve VALUES ('cus02', 'T001', '20260502', 'Y', 'N');
INSERT INTO reserve VALUES ('cus03', 'T002', '20260503', 'Y', 'Y');
INSERT INTO reserve VALUES ('cus04', 'T003', '20260504', 'N', 'N');
INSERT INTO reserve VALUES ('cus05', 'T005', '20260505', 'Y', 'Y');

INSERT INTO driver VALUES (501, '김기사', '781105', '010-1234-1111', 15000, '20210101', '24');
INSERT INTO driver VALUES (502, '박기사', '820412', '010-5678-2222', 16000, '20220301', '12');
INSERT INTO driver VALUES (503, '이기사', '750920', '010-9012-3333', 15000, '20200515', '36');
INSERT INTO driver VALUES (504, '최기사', '850630', '010-3456-4444', 15000, '20230710', '12');
INSERT INTO driver VALUES (505, '정기사', '800228', '010-7890-5555', 17000, '20191101', '24');

INSERT INTO tour_bus VALUES (1, 45, 2020);
INSERT INTO tour_bus VALUES (2, 45, 2021);
INSERT INTO tour_bus VALUES (3, 28, 2019);
INSERT INTO tour_bus VALUES (4, 45, 2022);
INSERT INTO tour_bus VALUES (5, 28, 2023);

INSERT INTO assign_driver VALUES ('T001', 501, 24);
INSERT INTO assign_driver VALUES ('T002', 502, 12);
INSERT INTO assign_driver VALUES ('T003', 503, 8);
INSERT INTO assign_driver VALUES ('T004', 504, 16);
INSERT INTO assign_driver VALUES ('T005', 505, 9);

INSERT INTO assign_bus VALUES ('T001', 1);
INSERT INTO assign_bus VALUES ('T002', 2);
INSERT INTO assign_bus VALUES ('T003', 3);
INSERT INTO assign_bus VALUES ('T004', 4);
INSERT INTO assign_bus VALUES ('T005', 5);


-- 3. INDEX

CREATE INDEX tour_arrival_idx ON tour (arrival ASC);
CREATE INDEX driver_name_idx ON driver (name ASC);


-- 4. TEST QUERIES

-- 1. 고객 등급 검색
SELECT c.name AS "이름", cc.class AS "등급"
FROM customer c
JOIN class_code cc ON c.C_Code = cc.code 
WHERE c.cus_id = 'cus01';

-- 2. 직원 담당업무 검색
SELECT s.name AS "이름", tc.task AS "담당업무"
FROM staff s
JOIN task_code tc ON s.t_code = tc.code 
WHERE s.staff_id = 101;

-- 3. 여행상품 예약 고객 검색
SELECT c.name AS "고객명", r.res_date AS "예약일자", r.dep_yn AS "예약금결제여부"
FROM reserve r
JOIN customer c ON r.cus_id = c.cus_id 
WHERE r.tour_num = 'T001';

-- 4. 여행상품 배정 운전기사 검색
SELECT t.departure AS "출발지", d.name AS "기사이름", d.cell AS "휴대폰번호"
FROM assign_driver ad
JOIN tour t ON ad.tour_num = t.tour_num 
JOIN driver d ON ad.driver_id = d.driver_id 
WHERE t.tour_num = 'T001';

-- 5. 신규 고객 등록
INSERT INTO customer (cus_id, name, cell, addr, C_Code)
VALUES ('cus06', '홍길동', '010-1234-5678', '충북 청주시', 3);

-- 6. 직원 급여 수정
UPDATE staff 
SET salary = salary + 200000 
WHERE staff_id = 101;

-- 7. 예약 정보 삭제
DELETE FROM reserve 
WHERE cus_id = 'cus04' AND tour_num = 'T003';
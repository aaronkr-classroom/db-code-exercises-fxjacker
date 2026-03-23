-- 1. 테이블 생성 (CREATE TABLE)
-- 그림의 PK(밑줄) 속성들을 PRIMARY KEY로 설정했습니다.

CREATE TABLE Member (
    member_id VARCHAR(20) PRIMARY KEY,
    name VARCHAR(30) NOT NULL,
    points NUMERIC DEFAULT 0
);

CREATE TABLE Employee (
    emp_id BIGSERIAL PRIMARY KEY,
    emp_name VARCHAR(30) NOT NULL,
    dept VARCHAR(50)
);

CREATE TABLE Product (
    product_id BIGSERIAL PRIMARY KEY,
    product_name VARCHAR(100) NOT NULL,
    price NUMERIC CHECK (price > 0),
    managed_by BIGINT REFERENCES Employee(emp_id) -- '관리하다' 관계 반영
);

CREATE TABLE Orders (
    order_id BIGSERIAL PRIMARY KEY,
    member_id VARCHAR(20) REFERENCES Member(member_id), -- '주문하다' 관계 반영
    product_id BIGINT REFERENCES Product(product_id),   -- '포함하다' 관계 반영
    order_date DATE DEFAULT CURRENT_DATE
);

-- 2. 데이터 5개 이상 입력 (INSERT)
-- 요구사항에 맞춰 각 테이블당 데이터를 넉넉히 넣었습니다.

INSERT INTO Member VALUES 
('user1', '안수빈', 5000), 
('user2', '윤정환', 1200), 
('user3', '김철수', 3000), 
('user4', '이영희', 800), 
('user5', '최민수', 10000);

INSERT INTO Employee (emp_name, dept) VALUES 
('홍길동', '마케팅팀'), 
('김영철', '물류팀'), 
('이지혜', '고객센터'), 
('박상준', '개발팀'), 
('최유리', '인사팀');

INSERT INTO Product (product_name, price, managed_by) VALUES 
('기계식 키보드', 120000, 2),
('무선 마우스', 45000, 2),
('C타입 케이블', 15000, 1),
('노트북 거치대', 38000, 2),
('웹캠', 85000, 1);

INSERT INTO Orders (member_id, product_id) VALUES 
('user1', 1),
('user2', 2),
('user5', 3),
('user3', 5),
('user1', 4);

-- 3. 요구사항 쿼리 작성

-- a. 전체 조회 (전체 상품 목록)
SELECT * FROM Product;

-- b. 정렬 (가격이 비싼 순으로 회원 포인트 정렬)
SELECT name, points FROM Member ORDER BY points DESC;

-- c. 조건 검색 (가격이 5만원 이상인 상품만 조회)
SELECT product_name, price FROM Product WHERE price >= 50000;
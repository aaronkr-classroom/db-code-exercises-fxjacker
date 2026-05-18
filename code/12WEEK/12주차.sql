TABLE users;

SELECT user_level FROM users;

-- check 유저 레벨은 1~100만 가능하다
ALTER TABLE users
ADD CONSTRAINT chk_user_level
CHECK (user_level >= 1 AND user_level <= 100);

UPDATE users
SET USER_LEVEL = 100
WHERE user_id = 1;

-- 2: 접속 상태는 online 또는 offline만 가능하다.
SELECT status FROM user;

ALTER TABLE users
ADD CONSTRAINT chk_user_status
CHECK (status in ('online','connecting','offline'));

UPDATE users
SET status = 'sleeping'
WHERE user_id = 2;

-- 3: 아이템 가격은 0원 이상이여야 한다
SELECT price FROM items;

ALTER TABLE items
ADD CONSTRAINT chk_item_price
CHECK (price>=0);

UPDATE items
SET price = -10
WHERE item_id = 1001;

-- 4: 아이템 등급을 정해진 값만 가능하다(S,A,B,C,D,E,F)
SELECT grade FROM items;

ALTER TABLE items
ADD CONSTRAINT chk_item_grade
CHECK (grade IN ('S', 'A', 'B', 'C', 'D', 'E', 'F'));

UPDATE items
SET grade = 'Z'
WHERE item_id = 1001;

-- 5: 닉네임은 중복되면 안된다.
ALTER TABLE users
ADD CONSTRAINT uq_user_nickname
UNIQUE(nickname);

INSERT INTO users VALUES
(6,'홍길동','DRAGONKING', 10, '2026-05-18','home@home.com','offline');

-------------------------------------------
SELECT CONSTRAINT_NAME, TABLE_NAME
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS
WHERE CONSTRAINT_TYPE = 'FOREIGN KEY'
AND TABLE_NAME = 'PLAYS';
--PLAYS_user_id_fkey
--plays_game_user_id_fkey
--user_items_user_id_fkey
--user_items_item_id_fkey

ALTER TABLE plays
DROP CONSTRAINT PLAYS_user_id_fkey;

ALTER TABLE plays
DROP CONSTRAINT plays_game_user_id_fkey;

ALTER TABLE plays
DROP CONSTRAINT user_items_user_id_fkey;

ALTER TABLE plays
DROP CONSTRAINT user_items_item_id_fkey;

table plays;

-- 새 fk 추가
-- 1: 유저가 삭제되면 플레이 기록도 삭제되게 하기
ALTER TABLE plays
ADD CONSTRAINT fk_plays_users
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE CASCADE;

--2: 게임은 플레이 기록이 있으면 삭제하지 못하게 하기
ALTER TABLE plays
ADD CONSTRAINT fk_plays_games
FOREIGN KEY (game_id)
REFERENCES games(game_id)
ON DELETE RESTRICT;

--3: 유저가 삭제되면 보유 아이템 기록도 삭제되게 하기
ALTER TABLE items
ADD CONSTRAINT fk_user_items_users
FOREIGN KEY (user_id)
REFERENCES users(user_id)
ON DELETE CASCADE;

--4: 아이템 누군가 보유 중이면 삭제하지 못하게 하기
ALTER TABLE user_items
DROP CONSTRAINT fk_user_items_items;

ALTER TABLE items
ADD CONSTRAINT fk_user_items_items
FOREIGN KEY (item_id)
REFERENCES items(item_id)
ON DELETE RESTRICT;

SELECT * FROM PLAYS WHERE USER_ID =1;
SELECT * FROM USER_ITEMS WHERE USER_ID = 1;

DELETE FROM USER WHERE USER_ID = 1;

-- RESTRICT 테스트
TABLE GAME;

DELETE FROM GAMES WHERE GAME_ID = 101;
DELETE FROM ITEMS WHERE ITEM_ID = 1004;


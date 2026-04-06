create table UserAcount(
	user_id INT PRIMARY KEY,
	email VARCHAR(100),
	password VARCHAR(100),
	created_at TIMESTAMP
);

create table Character(
	character_id INT PRIMARY KEY,
	user_id INT,
	name VARCHAR(100),
	LEVEL INT,
	Class VARCHAR(50),
	FOREIGN KEY(user_id) REFERENCES UserAcount(user_id)
);


create table Item(
	item_id INT PRIMARY KEY,
	name VARCHAR(100),
	type VARCHAR(50)
);

CREATE TABLE Inventory (
    character_id INT,
    item_id INT,
    quantity INT,
    PRIMARY KEY (character_id, item_id),
    FOREIGN KEY (character_id) REFERENCES Character(character_id),
    FOREIGN KEY (item_id) REFERENCES item(item_id)
);
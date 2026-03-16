create database ut;

create table animals(
	id bigserial, 
	name varchar(20),
	age integer,
	kind varchar(20),
	dob date,
	location varchar(50)
);

table animals;
--select * from animals;

INSERT INTO animals (name, age, kind, dob, location)
VALUES('cat', 45, 'tiger', '2010-10-10', 'SEOUL, KOREA'),
    ('POOH', 13, 'BEAR', '1931-01-03', 'ENGland'),
    ('togo', 13, 'dog', '1897-12-13', 'alaska, usa'),
    ('michaelangelo', 12, 'turtle', '1981-04-05', 'usa'),
    ('baghera', 27, 'panther', '1888-12-12', 'Engleand');

select * from animals;

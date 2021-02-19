USE [Table_Tennis]
GO

create table SponsorShip(
	SpId int primary key,
	Brand varchar(50),
	ItemType varchar(50)
	)

create table Country(
	CId int primary key,
	Style varchar(50)
	)

create table tennisTable(
	TbId int primary key,
	Material varchar(50),
	Color varchar(50)
	)

CREATE TABLE Team
	(TId INT PRIMARY KEY,
	name VARCHAR(50) UNIQUE,
	coach VARCHAR(50),
	CId int references Country(CId)
	)

create table Balls(
	BId int primary key,
	weight smallint,
	color varchar(50)
	)

create table Team_Balls(
	TId int references Team(TId),
	BId int references Balls(BId)
	Primary Key(TId, BId)
	)

create table Team_Table(
	TId int references Team(TId),
	TbId int references tennisTable(TbId),
	Primary Key(TId, TbId)
	)

CREATE TABLE PLAYER
	(PId INT PRIMARY KEY,
	Name VARCHAR(50),
	HEIGHT INT,
	EXPERIENCE INT,
	SpId int references SponsorShip(SpId),
	TId INT REFERENCES Team(TId)
	)


CREATE TABLE ROCKET
	(RId INT PRIMARY KEY,
	Wood VARCHAR(30),
	GameType VARCHAR(30))


CREATE TABLE Player_Rocket
	(PId INT REFERENCES PLAYER(PId),
	RId INT REFERENCES ROCKET(RId)
	PRIMARY KEY(PId, RId))
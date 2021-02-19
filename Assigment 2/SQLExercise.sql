USE [Table_Tennis]
GO


-- Insertion in tables

-- Insert in tennisTable
--INSERT tennisTable(TbId, Material, Color) VALUES (10, 'Plastic', 'green')
--INSERT tennisTable(TbId, Material, Color) VALUES (11, 'Plastic', 'blue')
--INSERT tennisTable(TbId, Material, Color) VALUES (31, 'Wood', 'green')
--INSERT tennisTable(TbId, Material, Color) VALUES (42, 'Metal', 'grey')
--INSERT tennisTable(TbId, Material, Color) VALUES (32, 'Wood', 'blue')

-- Insert in Team_Table
--INSERT Team_Table(TId, TbId) VALUES (21, 10)
--INSERT Team_Table(TId, TbId) VALUES (28, 32)
--INSERT Team_Table(TId, TbId) VALUES (22, 31)
--INSERT Team_Table(TId, TbId) VALUES (30, 11)

-- Insert in Balls
-- select * from Balls
 --insert Balls(BId, weight, color) values(12,6,'white')
 --insert Balls(BId, weight, color) values(10,6,'orange')
 --insert Balls(BId, weight, color) values(18,9,'black')
 --insert Balls(BId, weight, color) values(14,10,'white')

-- Insert in Team_Balls
 --INSERT Team_Balls(TId, BId) VALUES (29, 10)
 --INSERT Team_Balls(TId, BId) VALUES (29, 18)
 --INSERT Team_Balls(TId, BId) VALUES (30, 12)
 --INSERT Team_Balls(TId, BId) VALUES (21, 10)


-- Insert in SponsorShip
 --insert SponsorShip(SpId, Brand, ItemType) values (58, 'Nike', 'T-shirt')
 --insert SponsorShip(SpId, Brand, ItemType) values (59, 'Adidas', 'training')
 --insert SponsorShip(SpId, Brand, ItemType) values (52, 'Puma', 'shoes')
 --INSERT SponsorShip(SpId, Brand, ItemType) values (34, 'Puma', 'shorts')
 --INSERT SponsorShip(SpId, Brand, ItemType) values (37, 'Converse', 'shoes')
 --INSERT SponsorShip(SpId, Brand, ItemType) values (39, 'Under Armour', 'hoodies')
 
-- Insert in Country
 --insert Country(CId, Style) values (11, 'Butterfly')
 --insert Country(CId, Style) values (12, 'Turtle')
 --insert Country(CId, Style) values(13, 'Fish')
 --insert Country(CId, Style) values (44, 'pingu')
 --INSERT Country(CId, Style) values (55, 'Flamingo')
 --INSERT Country(CId, Style) values (60, NULL)
 --INSERT Country(CId, Style) VALUES (80, NULL)

-- Insert in Teams
 --insert Team(TId, name, coach, CId) values (22, 'National China', 'Honko', 11)
 --insert Team(TId, name, coach, CId) values (28, 'National Japan', 'Korishima', 12)
 --insert Team(TId, name, coach, CId) values (21, 'National Romania', 'Ionut', 13)
 --insert Team(TId, name, coach, CId) values (30, 'Antartica', 'Pinguin', 44)
 --insert Team(TId, name, coach, CId) VALUES (29, 'USA Minnesota', 'Tommy', 80)
 --insert Team(TId, name, coach, CId) VALUES (31, 'USA New York', 'NULL', NULL)


-- Insert in ROCKET
--INSERT ROCKET(RId, Wood, GameType) VALUES (123, 'Cedar', 'Speed')
--INSERT ROCKET(RId, Wood, GameType) VALUES (124, 'Rose', 'Effect')
--INSERT ROCKET(RId, Wood, GameType) VALUES (125, 'Ash', 'Begginer')
--INSERT ROCKET(RId, Wood, GameType) VALUES (133, 'Oak', 'Effect')
--INSERT ROCKET(RId, Wood, GameType) VALUES (162, 'Pine', 'Speed')

-- Insert in PLAYER_ROCKET
 --INSERT Player_Rocket(PId,RId) VALUES (91, 123)
 --INSERT Player_Rocket(PId,RId) VALUES (90, 162)
 --INSERT Player_Rocket(PId,RId) VALUES (92, 125)
 --INSERT Player_Rocket(PId,RId) VALUES (94, 133)
 --INSERT Player_Rocket(PId, RId) VALUES (91, 162)
 --INSERT Player_Rocket(PId, RId) values (92, 162)
 --INSERT Player_Rocket(PId, RId) values (91, 124)

-- Insert in PLAYER
 --insert PLAYER(PId, Name, HEIGHT, EXPERIENCE, SpId, TId) values (91, 'Ilinca Irimia', 170, 14, 58, 22)
 --insert PLAYER(PId, Name, HEIGHT, EXPERIENCE, SpId, TId) values (90, 'Andrei Zavo', 180, 2, 59, 28)
 --insert PLAYER(PId, Name, HEIGHT, EXPERIENCE, SpId, TId) values (92, 'Mircea Pop', 190, 20, 52, 21)
 --insert PLAYER(PId, Name, HEIGHT, EXPERIENCE, SpId, TId) values (93, 'Iulius Cesar', 150, 20, 52, 21)
 --insert PLAYER(PId, Name, HEIGHT, EXPERIENCE, SpId, TId) values (94, 'Sun Tsu', 140, 50, 34, 22)
 --insert PLAYER(PId, Name, HEIGHT, EXPERIENCE, SpId, TId) values (95, 'John Doe', 200, 1, 52, 29)
 --insert PLAYER(PId, Name, HEIGHT, EXPERIENCE, SpId, TId) values (96, NULL, 200, 1, 52, NULL)
 --insert PLAYER(PId, Name, HEIGHT, EXPERIENCE, SpId, TId) values (99, NULL, NULL, NULL, NULL, 29)
 --insert PLAYER(PId, Name, HEIGHT, EXPERIENCE, SpId, TId) values (97, 'Ulrich Konis', 185, 4, NULL, 29)
 --insert PLAYER(PId, Name, HEIGHT, EXPERIENCE, SpId, TId) values (98, 'Yghor Polinski', 195, 1, 58, 21)

-- Update tables


-- select * from PLAYER
-- update PLAYER
-- set name = 'Marcel Radu'
-- where EXPERIENCE = 20
-- select * from PLAYER

-- select * from Country
-- update Country
-- set Style = 'Spade Fish'
-- where CId IN (13, 11, 60) AND CId IS NOT NULL
-- select * from Country


--  Delete data

-- select * from Balls
-- delete
-- from Balls
-- where weight BETWEEN 12 AND 18 
-- select * from Balls

-- select * from Team
-- delete
-- from Team
-- where coach LIKE 'ping%'
-- select * from Team

-- A) UNION

-- SELECT  name FROM PLAYER
-- UNION ALL
-- SELECT name FROM Team 

 --SELECT color FROM Balls
 --UNION
 --SELECT ItemType FROM SponsorShip

-- B) INTERSECT

--SELECT P.Name
--FROM PLAYER P, SponsorShip S
--WHERE S.Brand in ('Puma', 'Nike') AND P.EXPERIENCE > 5
--INTERSECT
--SELECT P.Name 
--FROM PLAYER P, SponsorShip S
--WHERE P.HEIGHT > 150 AND S.ItemType = 'shoes'

--SELECT T.name
--FROM Team T
--WHERE T.name IN ('National Japan', 'National China', 'National Romania')
--INTERSECT
--SELECT T.name
--FROM Team T
--WHERE T.CId > 11

-- C) EXCEPT

-- Q: What is the ID of the players that their name doesn't start with 'I' but doesn't use a rocket that is used for speed or effect
--SELECT P.PId
--FROM PLAYER P,  ROCKET R
--WHERE P.Name NOT LIKE ('I%') 
--EXCEPT
--SELECT PR.PId
--FROM Player_Rocket PR, ROCKET R
--WHERE R.GameType IN ('Speed', 'Effect')

-- Q: What teams use tables made of wood but doesn't use black balls?
--SELECT Tt.Tid
--FROM Team_Table Tt, tennisTable t
--WHERE t.Material = 'Wood'
--EXCEPT
--SELECT TB.Tid
--FROM Team_Balls TB, Balls B
--WHERE B.color != 'black'

-- D) JOIN

-- Q: I want to see a table with the player name, the team in which he plays, and the country from where is the team
--SELECT PLAYER.Name, Team.name, Country.Style
--FROM PLAYER
--LEFT JOIN Team ON PLAYER.TId = Team.TId
--LEFT JOIN Country ON Team.CId = Country.CId

-- Q: What are tHe balls are used on the team's tennis tables, the teams and the tennis tables?
--SELECT B.BId, T.name, tT.TbId 
--FROM Team_Balls B
--INNER JOIN Team T ON B.TId = T.TId
--INNER JOIN Team_Table tT ON tT.TId = T.TId

-- Q: What are the names of the players and from what wood is their rocket made of?
--SELECT P.Name, R.Wood
--FROM ROCKET R
--FULL JOIN Player_Rocket Pr ON R.RId = Pr.RId
--FULL JOIN PLAYER P ON P.PId = Pr.PId

-- Q: What are the coaches and what styles do they practice in their country?
--SELECT T.coach, C.style
--FROM Team T
--RIGHT JOIN Country C ON C.CId = T.CId
 

-- E)  Subquery

-- Q: What are the brands that don't sponsor 'National Romania'?
--SELECT S.Brand
--FROM SponsorShip S
--WHERE S.SpId NOT IN(
--					SELECT P.SpId
--					FROM PLAYER P
--					WHERE P.TId = 21
--					)

-- Q: What are the tennis table ids that are used in the country with the id 13?
--SELECT TeamT.TbId
--FROM Team_Table TeamT
--WHERE TeamT.TId IN (
--					SELECT T.TId
--					FROM Team T
--					WHERE T.CId = 13
--					)

-- F) EXISTS
-- Q: Which wood is being used by players with an experience grater then 5 years
--SELECT R.Wood
--FROM ROCKET R
--WHERE EXISTS(SELECT PR.RId
--			 FROM Player_Rocket PR, PLAYER P
--			WHERE P.PId = PR.PId AND P.EXPERIENCE > 10
--			)

-- Q: What players are sponsored by Nike?
--SELECT P.Name
--FROM PLAYER P
--WHERE EXISTS(SELECT S.Brand
--			 FROM SponsorShip S
--			 WHERE S.SpId = P.SpId AND S.Brand = 'Nike'
--				);

-- G) FROM

-- Q: What are the names of the players that have an experience lower then 10 years?

--SELECT BegginersTable.Name
--FROM (SELECT P.Name, P.EXPERIENCE 
--	  FROM PLAYER P 
--	  WHERE P.EXPERIENCE < 10
--	  ) AS BegginersTable

--Q: What teams are playing with orange colored balls?

--SELECT TeamColorBall.name
--FROM (SELECT T.Name, B.color FROM Team T, Balls B) 
--	  AS TeamColorBall
--	  WHERE TeamColorBall.color = 'orange'


-- H) GROUP BY

-- Q: How many balls are white, how about orange, now about black?
--SELECT COUNT(B.BId), B.color
--FROM Balls B
--GROUP BY B.color
--ORDER BY COUNT(B.BId) DESC;

-- Q: What is the averages of the players that have at least 5 years of experience as average? 

--SELECT COUNT(P.PID) AS Nr_Of_Players, AVG(P.EXPERIENCE) AS AvgExp
--FROM PLAYER P
--GROUP BY P.EXPERIENCE
--HAVING 5 <= AVG(P.EXPERIENCE)
--ORDER BY COUNT(P.PID) DESC;

-- Q:

-- I) ANY & ALL

-- Q: What brands sponsor players with an experience lower then 5 years?
-- v1:
--SELECT Brand
--FROM SponsorShip 
--WHERE SpId = ANY (SELECT SpId FROM PLAYER WHERE EXPERIENCE < 5);
-- v2:
--SELECT S.Brand
--FROM SponsorShip S
--WHERE SpId IN (SELECT SpId FROM PLAYER WHERE EXPERIENCE < 5);

-- Q: All teams have green table? and if so how many are they?
-- v1:
--SELECT COUNT(TId) AS Number_of_teams
--FROM Team
--WHERE TId = ALL (SELECT T_T.TId FROM Team_Table T_T 
--				WHERE T_T.TbId IN (SELECT TbId FROM tennisTable WHERE Color = 'green'));
-- v2:
--SELECT COUNT(TId) AS Number_of_teams
--FROM Team
--HAVING COUNT(TId) = (SELECT COUNT(T_T.TId) FROM Team_Table T_T 
--				WHERE T_T.TbId IN (SELECT TbId FROM tennisTable WHERE Color = 'green'));

-- Q: What styles are practiced by national teams?
-- v1
--SELECT TOP 2 Style, CId
--FROM Country
--WHERE CId = ANY (SELECT CId FROM Team WHERE name LIKE 'National%');
-- v2
--SELECT TOP 2 Style, CId
--FROM Country
--WHERE CId IN (SELECT CId FROM Team WHERE name LIKE 'National%');

-- Q: What players have an experience gratter then average?
-- v1

-- v2
SELECT Name
FROM PLAYER
WHERE EXPERIENCE > (SELECT AVG(EXPERIENCE) AS Average_Exp FROM PLAYER);

select * from PLAYER

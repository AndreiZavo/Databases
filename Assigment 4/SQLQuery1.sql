USE [Table_Tennis]
GO


---begin
 
 
---3 tables: 
---1 single column PK and no FK: Conference
---1 single column PK and 1 FK: NBA_Team
---multicolumn PK: SponsoredBy
 
 
---3 views
---1 SELECT on 1 table
---1 SELECT on at least 2 tables
---1 SELECT on at least 2 tables + 1 GROUP BY

-- VIEW

CREATE OR ALTER VIEW ViewPlayers
AS
	SELECT *
	FROM PLAYER
GO

CREATE OR ALTER VIEW ViewPlayersAndCoachesAndSponsors
AS
	SELECT P.Name, T.coach, S.Brand
	FROM PLAYER P
	INNER JOIN Team T ON P.TId = T.TId
	INNER JOIN SponsorShip S ON P.SpId = S.SpId
GO

CREATE OR ALTER VIEW ViewAveragePlayers
AS
	SELECT Average.Name, Average.AverageExp
	FROM (	SELECT P.Name, AVG(P.EXPERIENCE) AS AverageExp
			FROM PLAYER P
			GROUP BY P.Name
			) AS Average
GO


-- INSERT IN TABLE

CREATE OR ALTER PROCEDURE insertRowsInTable @Table VARCHAR(50)
AS
    DECLARE @columnName VARCHAR(50);
    DECLARE @columnType VARCHAR(50);
    DECLARE @allColumns VARCHAR(100);
    DECLARE @allValues VARCHAR(100);
    DECLARE @query VARCHAR(1000);
    DECLARE @randomString VARCHAR(500);
    DECLARE @counter INT;
 
    DECLARE cursor_types CURSOR
    FOR SELECT C.name AS 'column', T.name AS 'Type'
        FROM sys.objects O 
        INNER JOIN sys.columns C ON O.object_id = C.object_id
        INNER JOIN sys.types T ON T.user_type_id = C.user_type_id
        WHERE type = 'U' and O.name = @Table and C.is_identity = 0
    
	OPEN cursor_types
    FETCH NEXT FROM cursor_types INTO @columnName, @columnType;
    SET @allColumns = '';
    SET @allValues = '';
    SET @counter = 1;
    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @allColumns = @allColumns + ', ' + @columnName;
        IF @columnType = 'int'
        BEGIN
            BEGIN
                SET @allValues = @allValues + ', ' + CONVERT(varchar, (FLOOR(RAND()*(10-1+1)+1)));
            END
        END
        ELSE IF @columnType = 'varchar' OR @columnType = 'nvarchar'
        BEGIN
            
            SET @randomString = SUBSTRING(REPLACE(CONVERT(varchar(255), NEWID()), '-', ''), 1, 5)
            SET @allValues = @allValues + ', ' + '''' + @randomString + '''';
        END
		ELSE IF @columnType = 'float' OR @columnType = 'decimal'
		BEGIN
			SET @allValues = @allValues + ', ' + CONVERT(varchar, (RAND()*(100-1+1)+1));
		END 
        ELSE
        BEGIN
            SET @allValues = @allValues + 'NULL, '
        END
 
        FETCH NEXT FROM cursor_types INTO @columnName, @columnType;
    END
    
    SET @allColumns = SUBSTRING(@allColumns, 3, LEN(@allColumns));
	SET @allValues = SUBSTRING(@allValues, (CHARINDEX(' ', @allValues)), LEN(@allValues));
    CLOSE cursor_types;
    DEALLOCATE cursor_types;
	
    SET @query = 'INSERT INTO ' + @Table+ '(' + @allColumns + ') ' + 'VALUES ' + '(' + @allValues +')'; 
    
    EXEC (@query);

GO

CREATE OR ALTER PROCEDURE clearTable @table VARCHAR(50)
AS
	
	DECLARE @querty VARCHAR(50)
	SET @querty = 'DELETE FROM ' + @table
	EXEC (@querty)
	DECLARE @rseed VARCHAR(50)
	IF EXISTS (SELECT * from syscolumns where id = Object_ID(@table) and colstat & 1 = 1)
	BEGIN
    SET @rseed = 'DBCC CHECKIDENT (' + @table + ', RESEED, 0)'
	EXEC (@rseed)
	END
GO


CREATE OR ALTER PROCEDURE selectView @view VARCHAR(50)
AS
	DECLARE @command VARCHAR(100)
	SET @command = 'SELECT * FROM ' + @view;
	EXEC (@command)
GO

--ALTER TABLE Player_Rocket DROP CONSTRAINT FK__Player_Rock__PId__3D5E1FD2
--ALTER TABLE PLAYER DROP CONSTRAINT PK__PLAYER__C577554060147FEF
--ALTER TABLE PLAYER DROP CONSTRAINT FK__PLAYER__SpId__37A5467C
--ALTER TABLE PLAYER DROP CONSTRAINT FK__PLAYER__TId__38996AB5
--ALTER TABLE Team_Balls DROP CONSTRAINT FK__Team_Balls__TId__300424B4
--ALTER TABLE Team_Table DROP CONSTRAINT FK__Team_Table__TId__33D4B598

--ALTER TABLE Team DROP CONSTRAINT PK__Team__C456D7498D2E3092
--ALTER TABLE Team DROP COLUMN TId
--ALTER TABLE Team ADD TId INT PRIMARY KEY IDENTITY

--ALTER TABLE Team DROP CONSTRAINT FK__Team__CId__2B3F6F97
--ALTER TABLE Team DROP COLUMN CId
--ALTER TABLE Team ADD CId INT REFERENCES Country(CId)

--ALTER TABLE Country DROP CONSTRAINT PK__Country__C1F8DC397FD698E8
--ALTER TABLE Country DROP COLUMN CId
--ALTER TABLE COuntry ADD CId INT PRIMARY KEY IDENTITY 


--ALTER TABLE PLAYER ALTER COLUMN Name VARCHAR(50) NOT NULL

--ALTER TABLE PLAYER ALTER COLUMN Pid INT NOT NULL

--ALTER TABLE PLAYER ADD PRIMARY KEY(Pid, [Name])

--INSERT INTO Tables(Name) VALUES ('Country'), ('Team'), ('PLAYER');
--INSERT INTO Views(Name) VALUES ('viewPlayers'), ('ViewPlayersAndCoachesAndSponsors'), ('ViewAveragePlayers');
--INSERT INTO Tests(Name) VALUES ('test1'), ('test2');

GO
-- create test runs

CREATE OR ALTER PROCEDURE addTestTables
@tableName VARCHAR(50),
@testName VARCHAR(50),
@noRows INT,
@position INT
AS	
	DECLARE @testID INT, @tableID INT
	SET @testID = (SELECT TestID FROM Tests WHERE Name = @testName)
	SET @tableID = (SELECT TableID FROM Tables WHERE Name = @tableName)
	BEGIN TRY
		INSERT TestTables(TestID, TableID, NoOfRows, Position)
		VALUES (@testID, @tableID, @noRows, @position)
	END TRY
	BEGIN CATCH
		PRINT error_message()
	END CATCH
	
GO

CREATE OR ALTER PROCEDURE addTestViews 
@viewName VARCHAR(50),
@testName VARCHAR(50)
AS
	DECLARE @viewID INT, @testID INT
	SET @viewID = (SELECT ViewID FROM [Views] V WHERE V.Name = @viewName)
	SET @testID = (SELECT TestID FROM Tests T WHERE T.Name = @testName)
	BEGIN TRY
		INSERT TestViews(TestID, ViewID) VALUES(@testID, @viewID)
	END TRY
	BEGIN CATCH
		PRINT error_message()
	END CATCH
GO

--prepare to run the tests
CREATE PROCEDURE deleteTestRuns
AS
	DELETE FROM TestRuns
	DBCC CHECKIDENT ('TestRuns', RESEED, 0);
GO

CREATE OR ALTER PROCEDURE runTest @testName VARCHAR(50)
AS
	DECLARE @testID INT
	SET @testID = (SELECT TestID FROM Tests WHERE Name = @testName)
	--get all tables for test
	DECLARE tableCursor CURSOR SCROLL
	FOR SELECT Tables.TableID, Tables.Name, TestTables.NoOfRows 
		FROM TestTables INNER JOIN Tables ON TestTables.TableID = Tables.TableID
		WHERE TestTables.TestID = 1
		ORDER BY TestTables.Position
	--get all views for testing
	DECLARE viewCursor CURSOR SCROLL
	FOR SELECT Views.ViewID, Views.Name
	FROM TestViews INNER JOIN Views ON TestViews.ViewID = Views.ViewID
	WHERE TestViews.ViewID = @testID

	DECLARE 
		@table VARCHAR(50),
		@nRows INT,
		@pos INT,
		@tableID INT,

		@start_all DATETIME,
		@end_all DATETIME,
		@start_one DATETIME,
		@end_one DATETIME,

		@viewID INT,
		@view VARCHAR(50),
		@testRunningID INT,
		@command VARCHAR(100)

	SET NOCOUNT ON
	INSERT TestRuns(Description) 
	VALUES('Time results for: ' + @testName)
	SET @testRunningID = CONVERT(int, (SELECT LAST_VALUE FROM sys.identity_columns WHERE NAME = 'TestRunID'))
	SET @start_all = SYSDATETIME()
	--clear tables
	OPEN tableCursor
	FETCH FIRST FROM tableCursor
	INTO @tableID, @table, @nRows
	WHILE @@FETCH_STATUS = 0
	BEGIN
		EXEC ('clearTable ' + @table)
		FETCH NEXT FROM tableCursor
		INTO @tableID, @table, @nRows
	END
	CLOSE tableCursor

	OPEN tableCursor 
	FETCH LAST FROM tableCursor
	INTO @tableID, @table, @nRows
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @start_one = SYSDATETIME()
		WHILE @nRows > 0
		BEGIN
			EXEC ('insertRowsInTable ' + @table) 
			SET @nRows = @nRows - 1
		END
		SET @end_one = SYSDATETIME()
		print('inserted in ' + @table)
		INSERT TestRunTables(TestRunID, TableID, StartAt, EndAt)
		VALUES (@testRunningID, @tableID, @start_one, @end_one)

		FETCH PRIOR FROM tableCursor
		INTO @tableID, @table, @nRows
	END
	print('data inserted')

	OPEN viewCursor
	FETCH viewCursor
	INTO @viewID, @view
	
	WHILE @@FETCH_STATUS = 0
	BEGIN
		SET @start_one = SYSDATETIME()
		EXEC ('selectView ' + @view)
		SET @end_one = SYSDATETIME()
		INSERT TestRunViews(TestRunID, ViewID, StartAt, EndAt)
		VALUES(@testRunningID, @viewID, @start_one, @end_one)
		FETCH viewCursor
		INTO @viewID, @view
	END

	print('end of all tests')
	SET @end_all = SYSDATETIME()
	UPDATE TestRuns
	SET StartAt = @start_all, EndAt = @end_all
	WHERE TestRunID = @testRunningID

	CLOSE tableCursor
	CLOSE viewCursor
	DEALLOCATE viewCursor
	DEALLOCATE tableCursor
	SET NOCOUNT OFF
GO

EXEC addTestTables 'Country', 'test1', 1000, 1
EXEC addTestTables 'Team', 'test1', 1000, 2
EXEC addTestTables 'PLAYER', 'test1', 1000, 3

EXEC addTestViews 'ViewPlayers','test1'
EXEC addTestViews 'ViewPlayersAndCoachesAndSponsors', 'test1'
EXEC addTestViews 'ViewAveragePlayers', 'test1' 

EXEC deleteTestRuns

EXEC runTest 'test1'

SET NOCOUNT ON
SELECT * FROM PLAYER
SELECT * FROM Country
SELECT * FROM Team
SELECT * FROM TestRunTables
SELECT * FROM Tables
SELECT * FROM Views
SELECT * FROM TestTables
SELECT * FROM TestViews

SELECT * FROM TestRuns


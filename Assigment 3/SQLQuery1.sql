USE [Table_Tennis]

CREATE TABLE Contests(
	ConID INT PRIMARY KEY,
	Year INT,
	);


--a)
GO
CREATE OR ALTER PROCEDURE modify_column_type
AS
	ALTER TABLE PLAYER
	ALTER COLUMN EXPERIENCE smallint NOT NULL
GO

CREATE OR ALTER PROCEDURE reverse_modify_column_type
AS
	ALTER TABLE PLAYER
	ALTER COLUMN EXPERIENCE INT NOT NULL
GO

--b)
GO
CREATE OR ALTER PROCEDURE add_column
AS
	ALTER TABLE PLAYER
	ADD Titles INT
GO
CREATE OR ALTER PROC reverse_add_column
AS
	ALTER TABLE PLAYER
	DROP COLUMN Titles
GO


--c)
CREATE OR ALTER PROC add_constraint_for_default_value
AS
	ALTER TABLE PLAYER
	ADD CONSTRAINT DefaultExperience DEFAULT 1 FOR EXPERIENCE
GO
CREATE OR ALTER PROC reverse_add_constraint_for_default_value
AS
	ALTER TABLE PLAYER
	DROP DefaultExperience;
GO

--d)
CREATE OR ALTER PROC add_primary_key
AS
	ALTER TABLE Contests
	DROP CONSTRAINT PkContest
GO
CREATE OR ALTER PROC reverse_add_primary_key
AS
	ALTER TABLE Contests
	ADD CONSTRAINT PkContest PRIMARY KEY (ConID);
GO

--e)
CREATE OR ALTER PROC create_candidate_key
AS
	ALTER TABLE SponsorShip
	ADD CONSTRAINT Unique_Brand UNIQUE (Brand);
GO
CREATE OR ALTER PROC reverse_candidate_key
AS
	ALTER TABLE SponsorShip
	DROP CONSTRAINT Unique_Brand
GO

--f)
CREATE OR ALTER PROC add_foreign_key
AS
	ALTER TABLE Team
	DROP CONSTRAINT FK_country_team
GO
CREATE OR ALTER PROC reverse_add_foreign_key
AS
	ALTER TABLE Team
	ADD CONSTRAINT FK_country_team FOREIGN KEY (CId) REFERENCES Country(CId)
GO


--g)
CREATE OR ALTER PROC create_table
AS
BEGIN
	CREATE TABLE Tournament
	(id INT PRIMARY KEY,
	edition_number INT
	)
	INSERT Tournament (id, edition_number) VALUES (50, 2)
END

GO
CREATE OR ALTER PROC reverse_create_table
AS
BEGIN
	DROP TABLE IF EXISTS Tournament
END
GO

CREATE OR ALTER PROC no_procedure
AS
GO


--DROP PROCEDURE dbo.modify_column_type
--GO
--DROP PROCEDURE dbo.reverse_modify_column_type
--GO
--DROP PROCEDURE dbo.add_column;
--GO
--DROP PROCEDURE dbo.reverse_add_column
--GO
--DROP PROCEDURE dbo.add_constraint_for_default_value
--GO
--DROP PROCEDURE dbo.reverse_add_constraint_for_default_value
--GO
--DROP PROCEDURE dbo.add_primary_key
--GO
--DROP PROCEDURE dbo.reverse_add_primary_key
--GO
--DROP PROCEDURE dbo.create_candidate_key
--GO
--DROP PROCEDURE dbo.reverse_candidate_key
--GO
--DROP PROCEDURE dbo.add_foreign_key
--GO
--DROP PROCEDURE dbo.reverse_add_foreign_key
--GO
-- DROP PROCEDURE dbo.create_table
-- GO
--DROP PROCEDURE dbo.reverse_create_table
--GO



-----------------------------------------------------------------

-- create table of current version
CREATE TABLE current_version(
	VersionID INT PRIMARY KEY,
	)

INSERT current_version(VersionID) VALUES(0); -- default value for current version

--DROP TABLE current_version

-- Create table containing all versions
CREATE TABLE all_versions(
	VersionID INT PRIMARY KEY,
	ProcedureToUpgrade VARCHAR(50),
	ProcedureToDowngrade VARCHAR(50),
	)
	
GO

-- DROP TABLE all_versions

-- procedure to add versions
CREATE OR ALTER PROC add_versions
AS
BEGIN
	DELETE FROM all_versions
	INSERT all_versions VALUES
	(1, 'modify_column_type', 'no_procedure'),
	(2, 'add_column', 'reverse_modify_column_type'),
	(3, 'add_constraint_for_default_value', 'reverse_add_column'),
	(4, 'add_primary_key', 'reverse_add_constraint_for_default_value'),
	(5, 'create_candidate_key', 'reverse_add_primary_key'),
	(6, 'add_foreign_key', 'reverse_candidate_key'),
	(7, 'create_table', 'reverse_add_foreign_key'),
	(8, 'no_procedure', 'reverse_create_table');

END
GO

-- select * from Tournament

-- create procedure for version changeing
CREATE OR ALTER PROC change_version @new_version INT
AS
BEGIN
		DECLARE @current_version INT =	(SELECT VersionID FROM current_version);
		DECLARE @version_number INT = (SELECT COUNT(*) FROM all_versions);
		DECLARE @command_to_execute VARCHAR(50);

		PRINT('Current version: ' + CONVERT(VARCHAR(10), @current_version));

		IF @new_version > @version_number OR @new_version <= 0
			RAISERROR('The version you requested does not exist', 12, 1);

		IF @new_version = @current_version
			RAISERROR('The version you requested is the current version', 1, 1);
		
		IF @new_version	> @current_version
			WHILE @current_version != @new_version BEGIN
				SET @command_to_execute = (SELECT ProcedureToUpgrade 
										   FROM all_versions 
									       WHERE VersionID = @current_version);
				PRINT(@command_to_execute);
				EXECUTE @command_to_execute
				SET @current_version = @current_version + 1;
				PRINT('New version: ');
				PRINT(@current_version);
			END
		IF @new_version < @current_version
			WHILE @current_version != @new_version BEGIN
				SET @command_to_execute = (SELECT ProcedureToDowngrade 
												 FROM all_versions 
												 WHERE VersionID = @current_version)
				PRINT(@command_to_execute);
				EXECUTE @command_to_execute;
				SET @current_version = @current_version - 1;
				PRINT('New version ');
				PRINT(@current_version);
			END
		
		UPDATE current_version
		SET VersionID = @current_version

END
GO



EXEC add_versions

select * from all_versions

EXEC change_version 1

SELECT * FROM current_version

select * from Tournament

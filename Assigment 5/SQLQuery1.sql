USE[Table_Tennis]
GO

--CREATE TABLE TA(
--	aid INT PRIMARY KEY IDENTITY(1, 1),
--	a2 INT UNIQUE,
--	a3 INT
--	)


--CREATE TABLE TB(
--	bid INT PRIMARY KEY IDENTITY(1, 1),
--	b2 INT,
--	b3 INT
--	)

--CREATE TABLE TC(
--	cid INT PRIMARY KEY IDENTITY(1, 1),
--	aid INT REFERENCES TA(aid),
--	bid INT REFERENCES TB(bid)
--	)
 

GO

CREATE OR ALTER PROCEDURE insertRows @table VARCHAR(50)
AS
	DECLARE @seedValue INT;
	DECLARE @query VARCHAR(200);
	SET @seedValue = IDENT_CURRENT(@table) + 1
	SET @query = 'INSERT INTO ' + @table + ' VALUES(' + CONVERT(VARCHAR, @seedValue) + ',' +  CONVERT(VARCHAR, @seedValue) + ')'
	EXEC(@query)
	SET @seedValue = (SELECT SCOPE_IDENTITY() AS [SCOPE_IDENTITY])
GO
DBCC CHECKIDENT ('TA', RESEED, 0)
DBCC CHECKIDENT ('TB', RESEED, 0)
DBCC CHECKIDENT ('TC', RESEED, 0)
DELETE FROM TC
DELETE FROM TA
DELETE FROM TB
SELECT * FROM TA
SELECT * FROM TB
SELECT * FROM TC
DECLARE @rows INT
SET @rows = 1000
WHILE @rows > 0
BEGIN
	EXEC insertRows 'TA'	
	EXEC insertRows 'TB'
	EXEC insertRows 'TC'
	SET @rows = @rows - 1
END

-- A)
--clustered index scan;
SELECT aid FROM TA where a3 > 4
--clustered index seek;
SELECT aid FROM TA WHERE aid = 5
--nonclustered index scan;
SELECT a2 FROM TA
--nonclustered index seek;
SELECT a2 FROM TA WHERE a2 = 26
--key lookup
SELECT a3 FROM TA WHERE a2 = 26

--B)

SET STATISTICS IO ON
IF EXISTS (SELECT * FROM sys.indexes WHERE name = 'idx_b2')	DROP INDEX idx_b2 ON TB

SELECT b2 FROM TB WHERE b2 > 82 --> clustered index scan
-- logical reads = 5
CREATE NONCLUSTERED INDEX idx_b2
ON TB (b2)

SELECT b2 FROM TB WHERE b2 > 82 --> non clustered index seek
-- logical reads = 4
 
--C)

GO
CREATE OR ALTER VIEW viewCidForBidSmallerThen869
AS
	SELECT C.Cid
	FROM TC C
	INNER JOIN TB B ON C.bid = B.bid
	WHERE B.bid < 869
GO

SELECT * FROM viewCidForBidSmallerThen869 --> it uses a Hash Match which costs 75%

DROP INDEX idx_bid ON TC

CREATE NONCLUSTERED INDEX idx_bid --> it uses a Merge Join which costs 47%
ON TC(bid)

SELECT * FROM viewCidForBidSmallerThen869

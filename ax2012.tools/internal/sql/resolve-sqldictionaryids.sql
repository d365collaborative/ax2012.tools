/* Fix table and field IDs to match AX model (code)
 *   This script fixes both Table and Field IDs in SqlDictionary (data db) to match the AX code (Model db).
 *   Useful for after a database has been restored and the table or field IDs do not match.  Instead of letting
 *   the database synchronization process drop and recreate the table, just run this!
 *
 * Before Running-
 *   Stop the AOS
 *   Always take the appropriate SQL backups before running this script
 *   If running on AX2012 R2 or AX2012 R3 change the database name <<AX2012DB>> to your own DB names (Ctrl + H)
 *   If running on AX2012 RTM (R0) or AX2012 Feature Pack (R1) you will need to change the database name <<@DatabaseName_Model>> to your own DB names also (Ctrl + H)
 *
 * After Running-
 *   Add a reminder in your calendar to delete the table backups made: SQLDICTIONARY_BAK and SYSTEMSEQUENCES_BAK
 *   Start the AOS and try a dbsync within AX
 *
 * Notes
 *   To review what it will do, run the CTE separately before running the whole command.
 *   Objects that are new in AOT will get created in SQL dictionary when synchonisation happens
 *
 * History
 *   2019-10-14 Mötz Jensen	  (@splaxi)			Implement @Force for clean up. After execution reminder of backup tables with clean up scripts
 *   2019-03-27 Dag Calafell  (@dodiggitydag)	Fixed an issue with duplicate field-level records in SqlDictionary table (Steps 4 & 5)
 *   2018-05-18 Dag Calafell  (@dodiggitydag)	Now it fixes the case where field ID is the same but name is different
 *   2018-05-18 Dag Calafell  (@dodiggitydag)	Added step to remove duplicates in SqlDictionary
 *   2018-05-17 Dag Calafell  (@dodiggitydag)	Initial code
 *           from http://abraaxapta.blogspot.com/2011/06/accessing-dynamics-ax-containers-from.html
 *           from http://daxjohan.blogspot.com.au/2015/01/ax-2012-r2-fix-sqldictionary.html
 */

USE @DatabaseName


DECLARE @Force AS BIT

--If you want to delete previous bak tables for earlier runs, or the database might have been restored from another environment
SET @Force = @ForceValue

-- Backup the existing SQL dictionary as precaution
IF(@Force = 1)
BEGIN

	PRINT 'Initial cleanup'

	IF EXISTS (SELECT *
		FROM @DatabaseName.INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = N'dbo'  AND TABLE_NAME = N'SQLDICTIONARY_BAK')
	BEGIN
		PRINT 'SQLDICTIONARY_BAK was found - dropping it'
		DROP TABLE @DatabaseName.dbo.SQLDICTIONARY_BAK
	END
	
	IF EXISTS (SELECT *
		FROM @DatabaseName.INFORMATION_SCHEMA.TABLES
		WHERE TABLE_SCHEMA = N'dbo'  AND TABLE_NAME = N'SYSTEMSEQUENCES_BAK')
	BEGIN
		PRINT 'SYSTEMSEQUENCES_BAK was found - dropping it'
		DROP TABLE @DatabaseName.dbo.SYSTEMSEQUENCES_BAK
	END
END

PRINT 'Backing up SQLDICTIONARY & SYSTEMSEQUENCES'

SELECT *
INTO @DatabaseName.dbo.SQLDICTIONARY_BAK
FROM @DatabaseName.dbo.SQLDICTIONARY

SELECT *
INTO @DatabaseName.dbo.SYSTEMSEQUENCES_BAK
FROM @DatabaseName.dbo.SYSTEMSEQUENCES

----------------------------------------------------------------------------------------------
-- Step 1: Check and fix any duplicates in SqlDictionary.
--     Uses Name and SQLName to determine uniqueness
----------------------------------------------------------------------------------------------
PRINT 'Step 1';

SELECT
    *,
    ROW_NUMBER() OVER(PARTITION BY Name, SQLName ORDER BY RecID) as RN
INTO #RecordsWithDuplicateTableIds
FROM @DatabaseName.dbo.SQLDICTIONARY
WHERE SQLDICTIONARY.FIELDID = 0

-- Remove the non-duplicates from the list
DELETE #RecordsWithDuplicateTableIds
WHERE RN = 1

-- Delete the duplicate records for the tables, and the field records for those duplicated tables
DELETE @DatabaseName.dbo.SQLDICTIONARY
WHERE TableId IN (SELECT TableId FROM #RecordsWithDuplicateTableIds)

DROP TABLE #RecordsWithDuplicateTableIds


----------------------------------------------------------------------------------------------
-- Step 2 Find tables in SqlDictionary that have same name as in AOT but different ID and
--   update SystemSequences.TabID = TableID in Modelstore.  The SystemSequences table holds
--   the next available record ID block for each table.  The AOS actually consumes blocks of
--   RecId's, usually 256 at a time, and so the AOS must not be running.
----------------------------------------------------------------------------------------------
USE @ModelDatabaseName


PRINT 'Step 2';

WITH t AS (
    SELECT
        m.ElementHandle,
        m.NAME AS mName,
        m.AxId,
        md.LegacyId,
        s.TABLEID,
        s.NAME AS sName,
        s.SQLNAME
    FROM ModelElementData md, ModelElement m
    LEFT OUTER JOIN @DatabaseName.dbo.SQLDictionary s
        ON upper(m.NAME) collate Latin1_General_CI_AS = s.NAME
    WHERE m.ElementType = 44 -- UtilElementType::Table
        AND m.elementhandle = md.elementhandle
        AND s.ARRAY = 0
        AND s.FIELDID = 0
        AND s.TABLEID != m.AxId
)
UPDATE @DatabaseName.dbo.SYSTEMSEQUENCES
SET TABID = t.axid
FROM t
JOIN @DatabaseName.dbo.SYSTEMSEQUENCES x
    ON t.tableid = x.tabid


----------------------------------------------------------------------------------------------
--Step 3 Find tables in SqlDictionary having the same name as in AOT but different ID and
--   update the ID to match the ModelstoreID in SqlDictionary for Table and fields records.
----------------------------------------------------------------------------------------------
PRINT 'Step 3';

WITH t AS (
    SELECT
        m.ElementHandle,
        m.NAME AS mName,
        m.AxId,
        md.LegacyId,
        s.TABLEID,
        s.NAME AS sName,
        s.SQLNAME
    FROM modelelementdata md,ModelElement m
    LEFT OUTER JOIN @DatabaseName..SQLDictionary s
    ON upper(m.NAME) collate Latin1_General_CI_AS = s.NAME
    WHERE m.ElementType = 44 -- UtilElementType::Table
        AND m.elementhandle = md.elementhandle
        AND s.ARRAY = 0
        AND s.FIELDID = 0
        AND s.TABLEID != m.AxId
)
UPDATE @DatabaseName.dbo.SQLDICTIONARY
SET TABLEID = (t.axid * -1)  -- Update to the correct number, but as a negative, just in case the destimation number is currently being used
FROM t
JOIN @DatabaseName.dbo.SQLDICTIONARY s
ON t.tableid = s.tableid



--verify SQLDICTIONARY that have negative IDs for change to positive
WITH t AS  (
    SELECT
        m.ElementHandle,
        m.NAME AS mName,
        m.AxId,
        md.LegacyId,
        s.TABLEID,
        s.NAME AS sName,
        s.SQLNAME
    FROM modelelementdata md, ModelElement m
    LEFT OUTER JOIN @DatabaseName.dbo.SQLDictionary s
    ON (s.TABLEID * -1) = m.AxId
    WHERE m.ElementType = 44 -- UtilElementType::Table
        AND m.elementhandle = md.elementhandle
        AND s.ARRAY = 0
        AND s.FIELDID = 0
        AND upper(m.NAME) collate Latin1_General_CI_AS = s.NAME
)
UPDATE @DatabaseName.dbo.SQLDICTIONARY
SET TABLEID = (TABLEID * -1) -- Update to positive
WHERE @DatabaseName.dbo.SQLDICTIONARY.TABLEID < 0



----------------------------------------------------------------------------------------------
-- Step 4 Fix the field ids in SQLDictionary which do not match
----------------------------------------------------------------------------------------------
PRINT 'Step 4';

WITH t AS (
    SELECT (
            SELECT m1.NAME
            FROM ModelElement m1
            WHERE m1.ElementHandle = m.ParentHandle
        ) AS [Table Name],
        m.NAME AS [mName],
        m.AXid,
        s.RECID,
        M.ParentId,
        s.TableId,
        s.FieldID,
        S.NAME,
        s.SQLNAME
    FROM ModelElement m
    LEFT OUTER JOIN @DatabaseName.dbo.SQLDICTIONARY s
        ON m.ParentId = s.TABLEID
        AND s.NAME =  upper(m.NAME) collate Latin1_General_CI_AS
    WHERE m.ElementType = 42 -- UtilElementType::TableField
        AND (s.ARRAY = 1 OR s.ARRAY IS NULL)
        AND (s.FieldID > 0 OR s.FieldID IS NULL)
        AND s.FieldID != m.AxId
)
UPDATE @DatabaseName.dbo.SQLDICTIONARY
SET FIELDID = (t.axid * -1) -- Set to a negative number but correct ID
FROM t join @DatabaseName.dbo.SQLDICTIONARY s
ON upper(t.mName) collate Latin1_General_CI_AS = s.NAME
    AND s.FieldID <> 0
    AND s.TableId = t.ParentId


USE @DatabaseName


-- Reverse the negative to positive
UPDATE SQLDICTIONARY
SET FieldID = (FieldID * -1)
WHERE FieldID < 0
AND NOT EXISTS (
	SELECT *
	FROM SQLDICTIONARY d
	WHERE d.TableID = SQLDICTIONARY.TableID
	  AND d.FieldID = SQLDICTIONARY.FieldID * -1
)


DELETE FROM SQLDICTIONARY
WHERE FieldID < 0



----------------------------------------------------------------------------------------------
-- Step 5 Fix the field ids in SQLDictionary which do not match
-- There is a chance that the ID of a newly added field conflicts with an existing ID which is a field which is going away (not in the AX model)
-- This is not typical but has happened.
----------------------------------------------------------------------------------------------
PRINT 'Step 5';

USE @ModelDatabaseName


WITH t AS (
	SELECT *,
			(
				SELECT MAX(FieldId)
				FROM @DatabaseName.dbo.SQLDICTIONARY
				WHERE SQLDICTIONARY.TableId = TableId
			) + 1 + RN_by_Table as [Next FieldId Would Be]
	FROM (
		SELECT (
				SELECT m1.NAME
				FROM ModelElement m1
				WHERE m1.ElementHandle = m.ParentHandle
			) AS [Table Name],
			m.NAME AS [mName],
			m.AXid,
			s.RECID,
			M.ParentId,
			s.TableId,
			s.FIELDID,
			S.NAME,
			s.SQLNAME,
			ROW_NUMBER() OVER(PARTITION BY s.TableId ORDER BY RecID) as RN_by_Table
		FROM ModelElement m
		LEFT OUTER JOIN @DatabaseName.dbo.SQLDICTIONARY s
			ON m.ParentId = s.TABLEID
			AND s.FIELDID = m.AxId
		WHERE m.ElementType = 42 -- UtilElementType::TableField
			AND (s.ARRAY = 1 OR s.ARRAY IS NULL)
			AND (s.FIELDID > 0 OR s.FIELDID IS NULL)
			AND s.NAME !=  upper(m.NAME) collate Latin1_General_CI_AS
	) as SubQueryA
)
UPDATE @DatabaseName.dbo.SQLDICTIONARY
SET FieldID = [Next FieldId Would Be]
FROM t
JOIN @DatabaseName.dbo.SQLDICTIONARY s
ON t.tableid = s.tableid
    AND t.FieldID = s.FieldID


USE @DatabaseName


PRINT 'Clean Up Scripts & Reminders'

DECLARE @Msg AS NVARCHAR(400), @CleanUpSQL AS NVARCHAR(MAX)
SET @Msg = 'SQLDICTIONARY_BAK and SYSTEMSEQUENCES_BAK are still inside the database. Use below command to clean up or set the @Force variable for the next run.'
SET @CleanUpSQL = 'DROP TABLE SQLDICTIONARY_BAK; DROP TABLE SYSTEMSEQUENCES_BAK'

PRINT @MSG
PRINT @CleanUpSQL
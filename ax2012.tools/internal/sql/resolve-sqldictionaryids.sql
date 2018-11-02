USE @DatabaseName
   
   
   ----------------------------------------------------------------------------------------------
   -- Step 1: Check and fix any duplicates in SqlDictionary.
   ----------------------------------------------------------------------------------------------
   PRINT 'Step 1';
   
   SELECT
       *,
       ROW_NUMBER() OVER(PARTITION BY Name, SQLName ORDER BY RecID) as RN
   INTO #RecordsWithDuplicateTableIds
   FROM @DatabaseName.dbo.SQLDICTIONARY
   WHERE SQLDICTIONARY.FIELDID = 0
   
   -- Remove the non-duplicates from our list
   DELETE #RecordsWithDuplicateTableIds
   WHERE RN = 1
   
   -- Delete the duplicate records for the tables, and the field records for those duplicated tables
   DELETE @DatabaseName.dbo.SQLDICTIONARY
   WHERE TableId IN (SELECT TableId FROM #RecordsWithDuplicateTableIds)
   
   DROP TABLE #RecordsWithDuplicateTableIds
   
   
   USE @ModelDatabaseName
   
   
   ----------------------------------------------------------------------------------------------
   -- Step 2 Find tables in SqlDictionary that have same name as in AOT but different ID and
   --   update SystemSequences.TabID = TableID in Modelstore.  The SystemSequences table holds
   --   the next available record ID block for each table.  The AOS actually consumes blocks of
   --   RecId's, usually 256 at a time, and so the AOS must not be running.
   ----------------------------------------------------------------------------------------------
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
       LEFT OUTER JOIN @DatabaseName..SQLDictionary s
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
       LEFT OUTER JOIN @DatabaseName..SQLDictionary s
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
           s.FIELDID,
           S.NAME,
           s.SQLNAME
       FROM ModelElement m
       LEFT OUTER JOIN @DatabaseName..SQLDICTIONARY s
           ON m.ParentId = s.TABLEID
           AND s.NAME =  upper(m.NAME) collate Latin1_General_CI_AS
       WHERE m.ElementType = 42 -- UtilElementType::TableField
           AND (s.ARRAY = 1 OR s.ARRAY IS NULL)
           AND (s.FIELDID > 0 OR s.FIELDID IS NULL)
           AND s.FIELDID != m.AxId
   )
   UPDATE @DatabaseName.dbo.SQLDICTIONARY
   SET FIELDID = (t.axid * -1) -- Set to a negative number but correct ID
   FROM t join @DatabaseName.dbo.SQLDICTIONARY s
   ON upper(t.mName) collate Latin1_General_CI_AS = s.NAME
       AND s.FIELDID <> 0
       AND s.TABLEID = t.ParentId
   
   
   -- Reverse the negative to positive
   UPDATE @DatabaseName.dbo.SQLDICTIONARY
   SET FIELDID = (FIELDID * -1)
   WHERE FIELDID < 0
   
   
   ----------------------------------------------------------------------------------------------
   -- Step 5 Fix the field ids in SQLDictionary which do not match
   -- There is a chance that the ID of a newly added field conflicts with an existing ID which is a field which is going away (not in the AX model)
   -- This is not typical but has happened.
   ----------------------------------------------------------------------------------------------
   PRINT 'Step 5';
   
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
           s.FIELDID,
           S.NAME,
           s.SQLNAME,
           (
               SELECT MAX(FieldId)
               FROM @DatabaseName..SQLDICTIONARY
               WHERE SQLDICTIONARY.TableId = s.TableId
           ) + 1 as [Next FieldId Would Be]
       FROM ModelElement m
       LEFT OUTER JOIN @DatabaseName..SQLDICTIONARY s
           ON m.ParentId = s.TABLEID
           AND s.FIELDID = m.AxId
       WHERE m.ElementType = 42 -- UtilElementType::TableField
           AND (s.ARRAY = 1 OR s.ARRAY IS NULL)
           AND (s.FIELDID > 0 OR s.FIELDID IS NULL)
           AND s.NAME !=  upper(m.NAME) collate Latin1_General_CI_AS
   )
   UPDATE @DatabaseName.dbo.SQLDICTIONARY
   SET FieldID = [Next FieldId Would Be]
   FROM t
   JOIN @DatabaseName.dbo.SQLDICTIONARY s
   ON t.tableid = s.tableid
       AND t.FieldID = s.FieldID
   
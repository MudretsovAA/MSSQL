--https://www.mssqltips.com/sqlservertip/2537/sql-server-row-count-for-all-tables-in-a-database/
SELECT
      QUOTENAME(SCHEMA_NAME(sOBJ.schema_id)) + '.' + QUOTENAME(sOBJ.name) AS [TableName]
      , SUM(sPTN.Rows) AS [RowCount]
	  , Format(SUM(sPTN.Rows), 'N0') AS [RowCountSt]
FROM 
      sys.objects AS sOBJ
      INNER JOIN sys.partitions AS sPTN
            ON sOBJ.object_id = sPTN.object_id
WHERE
      sOBJ.type = 'U'
      AND sOBJ.is_ms_shipped = 0x0
      AND index_id < 2 -- 0:Heap, 1:Clustered
GROUP BY 
      sOBJ.schema_id
      , sOBJ.name
ORDER BY SUM(sPTN.Rows) DESC, [TableName]
GO


---------------------------------------------

--CREATE SCHEMA temp

CREATE TABLE #counts
(
    table_name varchar(255),
    row_count int
)

EXEC sp_MSForEachTable @command1='INSERT #counts (table_name, row_count) SELECT ''?'', COUNT(*) FROM ?'
SELECT table_name, row_count, FORMAT(row_count, 'N') row_count_n FROM #counts 
ORDER BY 
--table_name, 
row_count DESC
--DROP TABLE #counts
--Вот через sp_who2

IF OBJECT_ID('tempdb..#sp_who2') IS NOT NULL
DROP TABLE #sp_who2

CREATE TABLE #sp_who2 (SPID INT,[Status] VARCHAR(255),[Login]  VARCHAR(255),HostName  VARCHAR(255),BlkBy  VARCHAR(255),DBName  VARCHAR(255),Command VARCHAR(255),CPUTime INT,DiskIO INT,LastBatch VARCHAR(255)
	,ProgramName VARCHAR(255),SPID2 INT,REQUESTID INT) 
	INSERT INTO #sp_who2 EXEC sp_who2

	SELECT
	[SPID], [Status], [Login], [HostName], [BlkBy], [DBName], [Command], [CPUTime], [DiskIO], [LastBatch], [ProgramName], [SPID2], [REQUESTID]
	FROM #sp_who2
	-- Add any filtering of the results here :
	--WHERE --DBName <> 'master' 	and 
	--[Status] NOT IN ('sleeping')
	--[Status] IN ('RUNNABLE')
	--and (CPUTime <> 0 or DiskIO <> 0)
	-- Add any sorting of the results here :
	ORDER BY LastBatch desc, DBName ASC

--А вот без sp_who2
select 
	p.spid
	, p.login_time
	, p.last_batch
	, p.open_tran
	, d.name [DataBase]
	, p.status, p.hostname, p.loginame
	, p.cmd, sqltext.text
	, p.cpu, p.physical_io, p.memusage	
	, p.program_name
	from sys.sysprocesses p
	left join sys.databases d on d.database_id=p.dbid
	CROSS APPLY sys.dm_exec_sql_text(p.sql_handle) AS sqltext 
	--where p.status != 'sleeping'
	order by p.spid DESC, p.last_batch, d.name, p.loginame
/*Справочник SSIS пакетов*/
SELECT TOP (1000) [project_id]
      ,[folder_id]
      ,[name]
      ,[description]
      ,[project_format_version]
      ,[deployed_by_sid]
      ,[deployed_by_name]
      ,[last_deployed_time]
      ,[created_time]
      ,[object_version_lsn]
      ,[validation_status]
      ,[last_validation_time]
  FROM [SSISDB].[internal].[projects]

/*Статистика выполнения*/
SELECT TOP (1000) [statistics_id]
      ,[execution_id]
      ,[executable_id]
      ,[execution_path]
      ,[start_time]
      ,[end_time]
      ,[execution_hierarchy]
      ,[execution_duration]
      ,[execution_result]
      ,[execution_value]
FROM [SSISDB].[internal].[executable_statistics]

/*Анализ длительности выполения SSIS пакета*/
SELECT TOP (1000) [statistics_id]
      ,[execution_id]
      ,[executable_id]
      ,[execution_path]
      ,[start_time]
      ,[end_time]
      
      ,[execution_duration] [execution_duration_id]
	  ,stuff(stuff(right('00000' + cast([execution_duration] as varchar),6),3,0,':'),6,0,':') [run_duration]
      ,[execution_result]      
FROM [SSISDB].[internal].[executable_statistics]
ORDER BY [statistics_id] DESC

--
--DECLARE @DATE DATE = GETDATE() - 7

SELECT TOP 100
 [executions].[folder_name]
      , [executions].[project_name]
      , [executions].[package_name]
      , [executable_statistics].[execution_path]
	  ,[executions].[start_time]
      , DATEDIFF(minute, [executable_statistics].[start_time], [executable_statistics].[end_time]) AS 'execution_time[min]'
FROM [SSISDB].[catalog].[executions]
INNER JOIN [SSISDB].[catalog].[executable_statistics]
    ON [executions].[execution_id] = [executable_statistics].[execution_id]
ORDER BY [executable_statistics].[start_time] DESC, [executable_statistics].[execution_path]

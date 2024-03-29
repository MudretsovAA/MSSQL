/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ScheduleID]
      ,[ReportID]
      ,[SubscriptionID]
      ,[ReportAction]
  FROM [ReportServer].[dbo].[ReportSchedule]
WHERE [ReportID] = 'E56F4309-3A8C-4BD2-9366-526F63124DBA'

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [ScheduleID]
      ,[Name]
      ,[StartDate]
      ,[Flags]
      ,[NextRunTime]
      ,[LastRunTime]
      ,[EndDate]
      ,[RecurrenceType]
      ,[MinutesInterval]
      ,[DaysInterval]
      ,[WeeksInterval]
      ,[DaysOfWeek]
      ,[DaysOfMonth]
      ,[Month]
      ,[MonthlyWeek]
      ,[State]
      ,[LastRunStatus]
      ,[ScheduledRunTimeout]
      ,[CreatedById]
      ,[EventType]
      ,[EventData]
      ,[Type]
      ,[ConsistancyCheck]
      ,[Path]
  FROM [ReportServer].[dbo].[Schedule]
WHERE [ScheduleID] = 'BC211FE7-DCDF-4E69-8BA8-974E581F50D3'


--
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [SubscriptionID]
      ,[OwnerID]
      ,[Report_OID]
      ,[Locale]
      ,[InactiveFlags]
      ,[ExtensionSettings]
      ,[ModifiedByID]
      ,[ModifiedDate]
      ,[Description]
      ,[LastStatus]
      ,[EventType]
      ,[MatchData]
      ,[LastRunTime]
      ,[Parameters]
      ,[DataSettings]
      ,[DeliveryExtension]
      ,[Version]
      ,[ReportZone]
  FROM [ReportServer].[dbo].[Subscriptions]

--
/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [SnapshotDataID]
      ,[CreatedDate]
      ,[ParamsHash]
      ,[QueryParams]
      ,[EffectiveParams]
      ,[Description]
      ,[DependsOnUser]
      ,[PermanentRefcount]
      ,[TransientRefcount]
      ,[ExpirationDate]
      ,[PageCount]
      ,[HasDocMap]
      ,[PaginationMode]
      ,[ProcessingFlags]
  FROM [ReportServer].[dbo].[SnapshotData]
ORDER BY [CreatedDate] DESc

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [job_id]
      ,[originating_server_id]
      ,[name]
      ,[enabled]
      ,[description]
      ,[start_step_id]
      ,[category_id]
      ,[owner_sid]
      ,[notify_level_eventlog]
      ,[notify_level_email]
      ,[notify_level_netsend]
      ,[notify_level_page]
      ,[notify_email_operator_id]
      ,[notify_netsend_operator_id]
      ,[notify_page_operator_id]
      ,[delete_level]
      ,[date_created]
      ,[date_modified]
      ,[version_number]
  FROM [msdb].[dbo].[sysjobs]
WHERE [category_id] = 100

/****** Script for SelectTopNRows command from SSMS  ******/
SELECT TOP (1000) [job_id]
      ,[step_id]
      ,[step_name]
      ,[subsystem]
      ,[command]
      ,[flags]
      ,[additional_parameters]
      ,[cmdexec_success_code]
      ,[on_success_action]
      ,[on_success_step_id]
      ,[on_fail_action]
      ,[on_fail_step_id]
      ,[server]
      ,[database_name]
      ,[database_user_name]
      ,[retry_attempts]
      ,[retry_interval]
      ,[os_run_priority]
      ,[output_file_name]
      ,[last_run_outcome]
      ,[last_run_duration]
      ,[last_run_retries]
      ,[last_run_date]
      ,[last_run_time]
      ,[proxy_id]
      ,[step_uid]
  FROM [msdb].[dbo].[sysjobsteps]
WHERE job_id = 'E0A9514D-1ED3-4AA6-BA2D-5A36C63E3842'

/*
\Microsoft SQL Server\MSRS13.MSSQLSERVER\Reporting Services\LogFiles
*/
SELECT TOP (1000) [SubscriptionID],
ct.[Path]
	  ,[LastRunTime]
--,ct.[Name]      --,[OwnerID]
	  
	    ,sb.[Description]
      ,[LastStatus]
	  ,us.UserName
	  ,[EventType]
	  ,sb.[ModifiedDate]    

      ,[Report_OID]	  
      ,[Locale]
      ,[InactiveFlags]
      ,[ExtensionSettings]
      ,sb.[ModifiedByID]      
      ,[MatchData]
      ,[Parameters]
      ,[DataSettings]
      ,[DeliveryExtension]
      ,[Version]
      ,[ReportZone]
  FROM [ReportServer].[dbo].[Subscriptions] sb
LEFT JOIN [ReportServer].[dbo].[Users] us ON sb.OwnerID = us.UserID
LEFT JOIN [ReportServer].[dbo].[Catalog] ct ON sb.[Report_OID] = ct.ItemID
--WHERE [SubscriptionID] = '07F7C5A8-7721-44C9-969C-5E9676F67B44'
ORDER BY [LastRunTime] DESC

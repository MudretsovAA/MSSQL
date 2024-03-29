/*Справочник джобов*/
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
ORDER BY 
[name]
--[date_created] desc
--[date_modified] desc

/*Шаги джоба*/
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
WHERE [job_id] = '5521C610-01DC-4182-B5CF-9C32E2C8CC81'


/*Активность джобов*/
SELECT TOP (1000) [session_id]
      ,[job_id]
      ,[run_requested_date]
      ,[run_requested_source]
      ,[queued_date]
      ,[start_execution_date]
      ,[last_executed_step_id]
      ,[last_executed_step_date]
      ,[stop_execution_date]
      ,[job_history_id]
      ,[next_scheduled_run_date]
FROM [msdb].[dbo].[sysjobactivity]
WHERE [job_id] = '5521C610-01DC-4182-B5CF-9C32E2C8CC81'
ORDER BY session_id DESC

/*История запуска шагов джобов*/
SELECT TOP (1000) [instance_id]
      ,[job_id]
      ,[step_id]
      ,[step_name]
      ,[sql_message_id]
      ,[sql_severity]
      ,[message]
      ,[run_status]
      ,[run_date]
      ,[run_time]
      ,[run_duration]
      ,[operator_id_emailed]
      ,[operator_id_netsent]
      ,[operator_id_paged]
      ,[retries_attempted]
      ,[server]
FROM [msdb].[dbo].[sysjobhistory]
WHERE [job_id] = '5521C610-01DC-4182-B5CF-9C32E2C8CC81'
ORDER BY instance_id DESC

/*Анализ длительности выполения шага джоба*/
SELECT TOP (1000) [instance_id]      
      ,[run_status]
      ,[run_date]
	  ,[run_time] [run_time_id] 
	  ,[msdb].dbo.agent_datetime(run_date,run_time) [run_time]
      ,[run_duration] [run_duration_id]
	  ,stuff(stuff(right('00000' + cast(run_duration as varchar),6),3,0,':'),6,0,':') [run_duration]	  
	  ,IIF([run_duration] > AVG([run_duration]) OVER()
	  AND CAST(CAST([run_duration] AS DECIMAL(9, 2)) /AVG([run_duration]) OVER() AS DECIMAL(9, 2))-1 >0.05
	  , 1, 0) alert	  
	  ,AVG([run_duration]) OVER() [run_duration_avg_id]	  
	  ,stuff(stuff(right('00000' + cast(AVG([run_duration]) OVER() as varchar),6),3,0,':'),6,0,':') [run_duration_avg]	  
	  , CAST(CAST([run_duration] AS DECIMAL(9, 2)) /AVG([run_duration]) OVER() AS DECIMAL(9, 2))-1 perc
	  ,[server]
	  ,[job_id]
	  ,[step_id]
      ,[step_name]            
	  ,[message]
FROM [msdb].[dbo].[sysjobhistory]
WHERE [job_id] = '5521C610-01DC-4182-B5CF-9C32E2C8CC81' AND [instance_id] NOT IN (27506)
AND [run_status] != 0
AND [step_id] IN (2)
ORDER BY instance_id DESC

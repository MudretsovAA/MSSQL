DECLARE @TableSSISErrorHTML  NVARCHAR(MAX), @SubjectSSISError NVARCHAR(250)
	
	SET @SubjectSSISError = @@SERVERNAME +  N' Сообщение по ошибкам SSIS проектов';
  
	SET @TableSSISErrorHTML =  
	    N'<H1>Ошибки по SSIS проектам</H1>' +
	    N'<table border="1" bgcolor=#B5F7E7 align=left>' +
	    N'<tr><th>package_path_full</th>' +
		N'<th>message</th>' +
		N'<th>execution_path</th>' +
		N'<th>message_time</th>' +
		N'<th>object_name</th></tr>' +
	    CAST ( (SELECT TOP 100
	td = em.[package_path_full], ''
	, td = om.[message], ''	
	, td = em.[execution_path], ''	
	, td = FORMAT(om.message_time, 'dd.MM.yyyy HH:mm:ss'), ''	
	, td = op.[object_name], ''	
	FROM [SSISDB].[internal].[operation_messages] om
	INNER JOIN [SSISDB].[internal].[event_messages] em ON om.operation_message_id = em.event_message_id
	INNER JOIN [SSISDB].[internal].[operations] op ON op.operation_id = om.operation_id
	WHERE ([message_type] = 120 OR em.event_name = 'OnError'
	)
	AND op.created_time >= DATEADD(day, -10, getdate())
	ORDER BY [message_time] DESC
	FOR XML PATH('tr'), TYPE   
	    ) AS NVARCHAR(MAX) ) +  
	    N'</table>' ;  		
	EXEC msdb.dbo.sp_send_dbmail 
			@profile_name = @@SERVERNAME,
			@recipients = 'asdf@mail.ru',
			@subject = @SubjectSSISError,
			@body = @TableSSISErrorHTML,
			@body_format = 'HTML' ;  
	
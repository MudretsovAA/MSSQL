/*
SET STATISTICS TIME ON
SET STATISTICS IO ON
GO
SET SHOWPLAN_ALL ON
GO
SET SHOWPLAN_TEXT ON;  
GO
SET STATISTICS XML ON;  
GO  
*/
SELECT 
		par.[Path] [Папка отчета]      ,c.[Path] [Путь к отчету]      ,c.[Name] [Наименование отчета], ex.[UserName] [Пользователь]
		,ex.[TimeStart] [Время запуска]     ,ex.[TimeEnd] [Время получения]     
, ex.Status [Статус]
, DATEDIFF(second, ex.[TimeStart], ex.[TimeEnd]) [Длительность (сек)] 		
		,ex.[RowCount] [Кол-во строк]		,ex.[Format] [Формат]     ,ex.[Parameters] [Параметры]     		,c.[CreationDate] [Дата создания]           ,c.[ModifiedDate] [Дата редактирования]
		FROM ReportServer.dbo.ExecutionLogStorage ex
		inner join ReportServer.dbo.[Catalog] c on ex.ReportID = c.ItemID
		inner join ReportServer.[dbo].[Catalog] par on c.ParentID = par.ItemID  
		where ex.[TimeStart] >= GETDATE() - 62
ORDER BY ex.[TimeStart] DESC

GO

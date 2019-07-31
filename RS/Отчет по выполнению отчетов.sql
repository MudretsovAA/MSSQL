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
		par.[Path] [����� ������]      ,c.[Path] [���� � ������]      ,c.[Name] [������������ ������], ex.[UserName] [������������]
		,ex.[TimeStart] [����� �������]     ,ex.[TimeEnd] [����� ���������]     
, ex.Status [������]
, DATEDIFF(second, ex.[TimeStart], ex.[TimeEnd]) [������������ (���)] 		
		,ex.[RowCount] [���-�� �����]		,ex.[Format] [������]     ,ex.[Parameters] [���������]     		,c.[CreationDate] [���� ��������]           ,c.[ModifiedDate] [���� ��������������]
		FROM ReportServer.dbo.ExecutionLogStorage ex
		inner join ReportServer.dbo.[Catalog] c on ex.ReportID = c.ItemID
		inner join ReportServer.[dbo].[Catalog] par on c.ParentID = par.ItemID  
		where ex.[TimeStart] >= GETDATE() - 62
ORDER BY ex.[TimeStart] DESC

GO

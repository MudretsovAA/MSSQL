USE [ReportServer]
GO
SELECT TOP (1000) 
ct.[Path]
,ct.[CreationDate]
,ct.[ModifiedDate]
,ct.[Type]
,us_c.UserName [CreatedBy]
,us_m.UserName [ModifiedBy]
FROM [dbo].[Catalog] ct
LEFT JOIN [dbo].[Users] us_c ON ct.CreatedByID = us_c.UserID
LEFT JOIN [dbo].[Users] us_m ON ct.ModifiedByID = us_m.UserID
ORDER BY ct.[ModifiedDate] DESC, ct.[CreationDate] DESC
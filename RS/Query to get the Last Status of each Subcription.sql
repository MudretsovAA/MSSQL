--Query to get the Last Status of each Subcription and its OwenerID.
SELECT s.[SubscriptionID] -- Subscription ID
,s.[OwnerID] -- Report Owner
--,s.[Report_OID] -- Report ID
, c.Path -- Report Path
--,rs.ScheduleID as SQLJobName -- Name of Job on SQL Server
,s.[LastStatus] -- Status of last subscription execution.
,s.[Description] -- Description of the report subscription
,s.[EventType] -- Subscription type
,s.[LastRunTime] -- Last time subscription executed
--,s.[Parameters] -- Parameters used for subscription
,s.[DeliveryExtension] -- How to deliver the subscription
FROM [ReportServer].[dbo].[Subscriptions] as s left join dbo.Catalog as c
on c.ItemID = s.Report_OID left join dbo.ReportSchedule as rs
on rs.ReportID = s.Report_OID
order by s.LastStatus
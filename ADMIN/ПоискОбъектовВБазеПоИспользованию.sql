select schema_name(o.schema_id) as Схема, object_name(m.object_id) as Объект
from sys.sql_modules m
     inner join sys.objects o on o.object_id = m.object_id
where m.definition like '%_Reference17517%' 
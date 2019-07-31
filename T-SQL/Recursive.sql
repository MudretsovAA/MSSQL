
--Обход дерева
WITH 
dep as
(
select 1 id, NULL id_p, 100 sm
union 
select 2 id, NULL id_p, NULL sm
union
select 3 id, 2 id_p, 120 sm
union 
select 4 id, 2 id_p, 150 sm
union 
select 5 id, NULL id_p, NULL sm
union 
select 6 id, 3 id_p, 50 sm
)
, p as
(select dep.id, dep.id_p, dep.sm--, 0 pr_s
from dep where dep.id_p is null
union all
select dep.id, dep.id_p, dep.sm--, p.pr_s + dep.sm
from dep 
inner join p ON dep.id_p = p.id
)
select *--ps.id_p id, ps.sm, ps._id 
from p
OPTION( MAXRECURSION 100)


--Суммирование по дереву
WITH 
dep as
(
select 1 id, NULL id_p, 100 sm
union 
select 2 id, NULL id_p, NULL sm
union
select 3 id, 2 id_p, 120 sm
union 
select 4 id, 2 id_p, 150 sm
union 
select 5 id, NULL id_p, NULL sm
union 
select 6 id, 3 id_p, 50 sm
)
, tr as
(select dep.id, dep.id id_p, dep.sm--, 0 pr_s
from dep where dep.id_p is null
union all
select dep.id, tr.id_p, dep.sm--, p.pr_s + dep.sm
from dep 
inner join tr ON dep.id_p = tr.id
)
select 
tr.id, tr.id_p, tr.sm, s.SumIncludingChildren
from tr
	inner join (
				select tr.id_p
				, sum(tr.sm) as SumIncludingChildren
				from tr
				group by tr.id_p
				) as s
				on tr.id = s.id_p
OPTION( MAXRECURSION 100)
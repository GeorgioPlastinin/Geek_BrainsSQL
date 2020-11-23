select count(o.id), u.id from users u 
join orders o on u.id = o.user_id
group by u.id having count(o.id) > 0


#########
select p.name, cs.name from products p
left join catalogs cs on p.catalog_id = cs.id

############
select 
case
when f.froms = c2.label then c2.namess 
end as 'froms',
case
when f.tos = c.label then c.namess
end as 'tos'
from flights f
join cities c on f.tos = c.label
join cities c2 on f.froms = c2.label

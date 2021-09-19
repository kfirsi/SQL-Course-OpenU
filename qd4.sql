with temp_table(sid) as
	(select sid
	from product
	group by sid
	having count(sid)=1)

select p.pname, s.sname
from product as p, supplier as s, temp_table as t
where s.sid = p.sid and s.sid = t.sid;
select r.bid,r.rdate,r.rtime
from receipt as r, purchase as pur, product as prod, supplier as s
where r.total>50 and pur.code not in (select code from product where pname = 'Cucumbers')
      and r.bid = pur.bid and pur.code = prod.code and prod.sid = s.sid
group by r.bid,r.rdate,r.rtime
having  count(distinct s.sid) <= all
	(select count (distinct s.sid)
	from receipt as r, purchase as pur, product as prod, supplier as s
	where r.total>50 and pur.code not in (select code from product where pname = 'Cucumbers')
	and r.bid = pur.bid and pur.code = prod.code and prod.sid = s.sid
	group by r.rdate,r.rtime);

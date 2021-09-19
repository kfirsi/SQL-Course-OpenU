select r.bid,r.rdate,r.rtime
from receipt as r
where  (select count (*)
	from purchase as p
	where date_part('year',current_date)=date_part('year',r.rdate)
	and date_part('month',current_date)=date_part('month',r.rdate)
	and p.rtime=r.rtime
	and p.rdate=r.rdate
	and p.bid=r.bid
	) between 1 and 2;
 

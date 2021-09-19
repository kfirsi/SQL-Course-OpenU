with temp_table(temp_bid,temp_total) as
	(select bid, sum(total)
		from receipt
		GROUP BY bid)
	
select distinct b.bid,bname
from branch as b, receipt as r,temp_table as t
where b.bid = r.bid and b.bid = t.temp_bid and
(select max(temp_total)
from temp_table) = t.temp_total

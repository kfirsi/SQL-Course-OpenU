select *
from branch
where exists
(select bid
from stock
group by bid
having (select count(code) from stock where units>0) = (select count(code) from product))
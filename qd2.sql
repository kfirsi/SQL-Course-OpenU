select pname, sname
from supplier as s, product as p
where p.descr='Vegetable' and p.uprice>15 and p.utype = 'Kg' and p.sid = s.sid;

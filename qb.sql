create or replace function trigf1() returns trigger as
$$
declare
cur_num_of_units int;
cur_product_price float;

begin
	select units
	from Stock
	into cur_num_of_units 
	where stock.code=new.code and stock.bid=new.bid;

	select uprice
	from Product
	into cur_product_price
	where Product.code=new.code;

	if(new.units <= cur_num_of_units)
	then begin
		update Stock
			set units = cur_num_of_units - new.units
			where stock.code=new.code and stock.bid=new.bid;
		update Receipt
			set total = total + (new.units * cur_product_price)
			where Receipt.bid=new.bid and Receipt.rdate=new.rdate and Receipt.rtime=new.rtime;
		return new;
		end;
	else
		raise notice 'insufficient amount of units in stock';
		return null;
	end if;
end;
$$
language plpgsql;




create trigger T1
    before insert or update on Purchase
    for each row
execute procedure trigf1();

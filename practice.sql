select avg(price) as marketprice
from itemprice
where item_name = "가격"

select item_id, item_name, price, condition, item_description,
 seller_id, post_date, transaction_state 
from item 
where seller_id in (select user_id 
                    from user 
                    where user.location_id in (select location.location_id 
                                                from location
                                                where district="만안구"))
                    and price <80000 and price >=40000

select post_id, title, user_id, date, view_count
from freeboard
where freeboard.user_id in (select user.user_id
                            from user
                            where user.location_id = (select location_id
                                                        from location
                                                        where eup_dong="석수2동"))

select a.item_name, a.price, a.seller_id
from item as a
where a.item_id in (select b.item_id
                        from item as b
                        where b.seller_id in (select user_id
                                                from user
                                                where location_id=(select location_id
                                                                    from location
                                                                    where city="안양시"
                                                                        district="만안구"
                                                                        eup_dong="석수2동")))\

select transaction_state, count(item_id) as num
from dealhistory
where user_id="userexample"
group by transaction_state
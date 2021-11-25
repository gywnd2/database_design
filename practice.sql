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
from item as a, likeditem as liked
where liked.user_id="user8" and
        a.item_id = liked.item_id and
        a.item_id in (select b.item_id
                        from item as b
                        where b.seller_id in (select user.user_id
                                                from user
                                                where location_id=(select location_id
                                                                    from location
                                                                    where city="안양시" and
                                                                        district="만안구" and
                                                                        eup_dong="석수2동")))

select u.nickname as username, count(h.item_id) as num
from dealhistory as h, user as u
where h.user_id=u.user_id and u.location_id=(select location_id
                                            from location
                                            where city="안양시" and
                                                district="만안구" and
                                                eup_dong="석수2동")
                        and h.transaction_state="거래 완료"
group by username
order by username DESC

select user_id
from history
where seller_id="userexample"
group by user_id
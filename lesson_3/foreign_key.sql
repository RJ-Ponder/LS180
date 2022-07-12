-- 1
-- import store.sql

-- 2
alter table orders add foreign key (product_id) references products (id);

-- 3
insert into products (name) values
  ('small bolt'),
  ('large bolt');
  
insert into orders (product_id, quantity) values
  (1, 10),
  (1, 25),
  (2, 15);
  
-- 4
select orders.quantity, products.name from orders join products on orders.product_id = products.id;

-- 5
insert into orders (quantity) values
  (40);
  
-- 6
alter table orders alter column product_id set not null;
-- Error: Column "product_id contains null values"

-- 7
delete from orders where product_id is null;
alter table orders alter column product_id set not null;

-- 8
create table reviews (
  id serial primary key,
  review text not null,
  product_id integer references products (id)
);

-- 9
insert into reviews (product_id, review) values
  (1, 'a little small'),
  (1, 'very round!'),
  (2, 'could have been smaller');

-- 10
-- foreign key constraint does NOT prevent NULL values
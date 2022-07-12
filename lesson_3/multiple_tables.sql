-- 1
-- Import file theater.sql
-- In psql: \i theater.sql
-- In terminal: psql -d theater < theater.sql

-- 2
SELECT count(id) FROM tickets;
-- or
SELECT count(*) FROM tickets;

-- 3
SELECT count(DISTINCT customer_id) FROM tickets;

-- 4
SELECT count(customers.id) FROM customers; -- 10,000
SELECT count(DISTINCT tickets.customer_id) FROM tickets; -- 1,652

   SELECT round((count(DISTINCT tickets.customer_id) / count(DISTINCT customers.id)::decimal) * 100, 2)
       AS percent
     FROM customers
LEFT JOIN tickets
       ON customers.id = tickets.customer_id;

-- 5
SELECT events.name, count(tickets.id)
AS popularity
FROM events
JOIN tickets -- Use left outer join to make sure all events are listed, even if no tickets sold
ON events.id = tickets.event_id
GROUP BY events.name
ORDER BY popularity DESC;

-- 6
select customers.id, customers.email, count(distinct events.id) from customers
  join tickets on customers.id = tickets.customer_id
  join events on events.id = tickets.event_id
  group by customers.id
  having count(distinct events.id) = 3;

select customers.id, customers.email, count(distinct tickets.event_id) from customers
  join tickets on customers.id = tickets.customer_id
  group by customers.id
  having count(distinct tickets.event_id) = 3;
  
-- 7
customer -> tickets (event and seat) -> event (start time) -> seats (row, seat) -> section name

SELECT events.name AS event, events.starts_at, sections.name AS section, seats.row, seats.number AS seat
  FROM customers JOIN tickets ON customers.id = tickets.customer_id
  JOIN events ON tickets.event_id = events.id
  JOIN seats ON tickets.seat_id = seats.id
  JOIN sections ON seats.section_id = sections.id
  WHERE customers.email = 'gennaro.rath@mcdermott.co';
CREATE DATABASE football_ticket_booking_system_db;


DROP TABLE IF EXISTS Bookings;


DROP TABLE IF EXISTS Matches;


DROP TABLE IF EXISTS Users;


-- Create user table
CREATE TABLE Users (
  user_id SERIAL PRIMARY KEY,
  full_name text NOT NULL,
  email text NOT NULL UNIQUE,
  role text CHECK (role IN ('Foot ball Fan', 'Ticket Manager')),
  phone_number varchar(15)
);


-- Insert user table data
INSERT INTO
  Users (user_id, full_name, email, role, phone_number)
VALUES
  (
    1,
    'Tanvir Rahman',
    'tanvir@mail.com',
    'Foot Ball Fan',
    '+8801711111111'
  ),
  (
    2,
    'Asif Haque',
    'asif@mail.com',
    'Foot Ball Fan',
    '+8801722222222'
  ),
  (
    3,
    'Sajjad Rahman',
    'sajjad@mail.com',
    'Ticket Manager',
    '+8801733333333'
  ),
  (
    4,
    'Jannat Ara',
    'jannat@mail.com',
    'Foot Ball Fan',
    NULL
  );


SELECT
  *
FROM
  users;


-- Create matches table
CREATE TABLE Matches (
  match_id SERIAL PRIMARY KEY,
  fixture text NOT NULL,
  tournament_category text NOT NULL,
  base_ticket_price numeric NOT NULL CHECK (base_ticket_price >= 0),
  match_status text NOT NULL CHECK (
    match_status IN ('Available', 'Selling Fast', 'Sold Out')
  )
);


-- Insert matches table data
INSERT INTO
  Matches (
    match_id,
    fixture,
    tournament_category,
    base_ticket_price,
    match_status
  )
VALUES
  (
    101,
    'Real Madrid vs Barcelona',
    'Champions League',
    150.00,
    'Available'
  ),
  (
    102,
    'Man City vs Liverpool',
    'Premier League',
    120.00,
    'Selling Fast'
  ),
  (
    103,
    'Bayern Munich vs PSG',
    'Champions League',
    130.00,
    'Available'
  ),
  (
    104,
    'AC Milan vs Inter Milan',
    'Serie A',
    90.00,
    'Sold Out'
  ),
  (
    105,
    'Juventus vs Roma',
    'Serie A',
    80.00,
    'Available'
  );


CREATE TABLE Bookings (
  booking_id serial PRIMARY KEY,
  user_id int REFERENCES Users (user_id),
  match_id int REFERENCES Matches (match_id),
  seat_number text,
  payment_status text CHECK (payment_status IN ('Confirmed', 'Pending')),
  total_cost numeric NOT NULL CHECK (total_cost >= 0)
);


DROP TABLE Bookings;


-- Insert Bookings table data
INSERT INTO
  Bookings (
    booking_id,
    user_id,
    match_id,
    seat_number,
    payment_status,
    total_cost
  )
VALUES
  (501, 1, 101, 'A-12', 'Confirmed', 150.00),
  (502, 1, 102, 'B-04', 'Confirmed', 120.00),
  (503, 2, 101, 'A-13', 'Confirmed', 150.00),
  (504, 2, 101, NULL, NULL, 150.00),
  (505, 3, 102, 'C-20', 'Pending', 120.00);


-- Query 1: Retrieve all upcoming football matches belonging to the 'Champions League' where the match status is 'Available'.
SELECT
  match_id,
  fixture,
  base_ticket_price
FROM
  Matches
WHERE
  tournament_category = 'Champions League'
  AND match_status = 'Available';


-- Query 2: Search for all users whose full names start with 'Tanvir' or contain the phrase 'Haque' (case-insensitive).
SELECT
  user_id,
  full_name,
  email
FROM
  Users
WHERE
  full_name ILIKE 'Tanvir%'
  OR full_name ILIKE '%Haque%';


-- Query 3: Retrieve all booking records where the payment status is missing (NULL), replacing the empty result with 'Action Required'.
SELECT
  booking_id,
  user_id,
  match_id,
  coalesce(payment_status, 'Action Required') AS systemic_status
FROM
  bookings
WHERE
  payment_status IS NULL;


-- Query 4: Retrieve match booking details along with the User's full name and the scheduled Match fixture teams.
SELECT
  b.booking_id,
  u.full_name,
  m.fixture,
  b.total_cost
FROM
  bookings b
  INNER JOIN users u ON b.user_id = u.user_id
  INNER JOIN matches m ON b.match_id = m.match_id;


-- Query 5: Display a comprehensive list of all users and their booking IDs, ensuring that fans who have never bought a ticket are still listed.
SELECT
  u.user_id,
  u.full_name,
  b.booking_id
FROM
  users u
  LEFT JOIN bookings b ON u.user_id = b.user_id;


-- Query 6: Find all ticket bookings where the total cost is strictly higher than the average cost of all ticket bookings.
SELECT
  booking_id,
  match_id,
  total_cost
FROM
  bookings
WHERE
  total_cost > (
    SELECT
      avg(total_cost)
    FROM
      bookings
  );


-- Query 7: Retrieve the top 2 most expensive matches sorted by base ticket price, skipping the absolute highest premium match.
SELECT
  match_id,
  fixture,
  base_ticket_price
FROM
  matches
ORDER BY
  base_ticket_price DESC
LIMIT
  2
OFFSET
  1;
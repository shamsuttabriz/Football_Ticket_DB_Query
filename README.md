# Football Ticket Booking Database

This project contains an SQL script for a football ticket booking system database. The database is designed to manage users, matches, and ticket bookings while supporting queries for match availability, user lookup, payment tracking, and reporting.

## Project Idea

Create a football ticket booking database that includes:

- `Users`: fan and ticket manager accounts
- `Matches`: football fixtures, tournament categories, ticket prices, and availability status
- `Bookings`: ticket reservations including payment status and seat numbers

## Key Features

- user registration and role management
- match listing with status values like `Available`, `Selling Fast`, and `Sold Out`
- bookings with seat assignment and payment tracking
- queries to retrieve available matches, search users, find unpaid bookings, and aggregate booking details

## Files

- `query.sql` - SQL file with database creation, sample data inserts, and example queries

## Example SQL Usage

```sql
-- Create the database
CREATE DATABASE football_ticket_booking_system_db;

-- Create tables and insert data
-- (See query.sql for full script)

-- Find available Champions League matches
SELECT
  match_id,
  fixture,
  base_ticket_price
FROM
  Matches
WHERE
  tournament_category = 'Champions League'
  AND match_status = 'Available';

-- Search users by name
SELECT
  user_id,
  full_name,
  email
FROM
  Users
WHERE
  full_name ILIKE 'Tanvir%'
  OR full_name ILIKE '%Haque%';
```

## How to Use

1. Open `query.sql` in your SQL editor.
2. Run the script to create the database schema and populate sample data.
3. Execute the sample queries to explore bookings, matches, and users.

## Notes

- This is a relational model built for PostgreSQL syntax with `SERIAL`, `CHECK`, and `ILIKE`.
- You can extend the project by adding tables for stadiums, ticket categories, payment methods, or user authentication.

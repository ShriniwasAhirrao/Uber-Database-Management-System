# Uber Database Management System

## Project Introduction

### Title
Design and Implementation of a Database Management System for a Ride-Sharing Application (inspired by Uber)

### Problem
Develop a scalable and efficient database system to manage core functionalities of a ride-sharing application, considering real-world challenges like data growth, concurrency, and performance.

### Objectives
- Design a conceptual and logical database model using an Entity-Relationship (E-R) diagram.
- Implement the database schema in Microsoft SQL Server, ensuring data integrity and efficient operations.
- Develop sample queries using Structured Query Language (SQL) to demonstrate data retrieval, manipulation, and analysis.
- Discuss potential challenges and optimization techniques for scalability and performance.

## Project Structure

The project contains the following files:

- **README.md**: This file. Provides an overview of the project and instructions.
- **Uber_DBMS.sql**: Contains all SQL commands for creating tables, inserting data, and running sample queries.

### Database Schema

1. **User** (user_id, name, email, phone, password, rating, account_type)
    - Stores information about both riders and drivers.
    - `account_type` (rider, driver, admin) differentiates user roles.

2. **Vehicle** (vehicle_id, make, model, year, license_plate, color, driver_id)
    - Captures details about vehicles used for Uber rides.
    - Links to `Driver` through `driver_id`.

3. **Location** (location_id, address, latitude, longitude, city, state, country)
    - Represents pickup and drop-off locations for rides.

4. **RideRequest** (request_id, rider_id, pickup_location_id, dropoff_location_id, ride_type_id, created_at)
    - Stores details about ride requests initiated by riders.
    - Links to `User` through `rider_id`, `Location` through `pickup_location_id` and `dropoff_location_id`, and `RideType` through `ride_type_id`.

5. **Ride** (ride_id, request_id, driver_id, vehicle_id, start_time, end_time, fare, rating, status)
    - Represents individual Uber rides.
    - Links to `RideRequest`, `User` through `driver_id`, `Vehicle`, and optionally references itself (`request_id`) to indicate cancellation or ride completion.

6. **RideType** (ride_type_id, name, base_price, price_per_mile, price_per_minute, description)
    - Defines different ride categories (e.g., UberX, UberXL, UberBlack) with associated pricing.

7. **Payment** (payment_id, ride_id, payment_method, amount, transaction_id)
    - Tracks payment details for each ride.
    - Links to `Ride`.

8. **Promotion** (promotion_id, code, discount_type, discount_value, start_date, end_date)
    - Manages promotional offers for riders (e.g., discount codes).

#### Additional Entities:

9. **Feedback** (feedback_id, user_id, ride_id, rating, comment)
    - Captures user feedback on rides (optional).
    - Links to `User` and `Ride`.

10. **Document** (document_id, user_id, document_type, file_path)
    - Stores user-uploaded documents (e.g., driver's license, vehicle registration) (optional).
    - Links to `User`.

11. **Earnings** (earning_id, driver_id, ride_id, amount, payout_date)
    - Tracks driver earnings from completed rides (optional).
    - Links to `User` through `driver_id` and `Ride`.

12. **SupportTicket** (ticket_id, user_id, subject, message, status)
    - Manages user support tickets (optional).
    - Links to `User`.

13. **Notification** (notification_id, user_id, message, type, sent_at)
    - Tracks system-generated notifications for users (optional).
    - Links to `User`.

14. **Admin** (admin_id, username, password) (optional)
    - Manages administrator accounts for system access (optional).

### Relationships:

- One `User` can have many `RideRequest`s and `Ride`s (as rider).
- One `User` (driver) can have many `Vehicle`s and `Ride`s (as driver).
- One `Location` can be a pickup or drop-off location for many `RideRequest`s and `Ride`s.
- One `RideRequest` is linked to one `Ride` (one-to-one).
- One `Ride` is linked to one `RideRequest` (optional, for cancellation tracking) and can have one `Driver` and one `Vehicle`.
- One `RideType` can be associated with many `RideRequest`s and `Ride`s.
- One `Ride` can have one `Payment`.
- One `User` can have many `Feedback`s (optional).
- One `User` can have many `Document`s (optional).
- One `Driver` can have many `Earning`s (optional).



![Entity-Relationship Diagram](Database.png)


## Setup Instructions

### Prerequisites
- Microsoft SQL Server
- SQL Server Management Studio (SSMS)

### Steps to Setup
1. **Clone the Repository**
   ```sh
   git clone[ https://github.com/ShriniwasAhirrao/Uber-Database-Management-System.git
   cd Uber_DBMS
   
2. **Open SQL Server Management Studio (SSMS)**
   - Connect to your SQL Server instance.

3. **Create Database and Tables**
   - Open the `Uber_DBMS.sql` file in SSMS.
   - Execute the script to create the database, tables, and insert sample data.

### Sample Queries
The `Uber_DBMS.sql` file contains sample queries to demonstrate data retrieval, manipulation, and analysis. Some of the queries include:
- Retrieving user information.
- Finding vehicles with specific license plates.
- Listing ride requests along with pickup and dropoff locations.
- Calculating total earnings for each driver.

### Potential Challenges and Optimization Techniques

#### Challenges
- Handling large volumes of data efficiently.
- Ensuring data integrity and consistency with concurrent access.
- Optimizing performance for complex queries.

#### Optimization Techniques
- Indexing frequently queried columns.
- Partitioning large tables.
- Using efficient join operations and query plans.
- Implementing caching strategies where appropriate.


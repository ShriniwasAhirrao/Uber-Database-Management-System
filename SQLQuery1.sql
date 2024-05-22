create database Uber_DBMS;

-- Create User table
CREATE TABLE [User] (
    user_id INT PRIMARY KEY,
    name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(20),
    [password] VARCHAR(100), -- password is a reserved keyword, so it's enclosed in square brackets
    rating FLOAT,
    account_type VARCHAR(10) CHECK (account_type IN ('rider', 'driver', 'admin'))
);


INSERT INTO [User] (user_id, name, email, phone, [password], rating, account_type)
VALUES
(1, 'John Doe', 'john@example.com', '1234567890', 'password123', 4.5, 'rider'),
(2, 'Jane Smith', 'jane@example.com', '9876543210', 'password456', 4.8, 'driver'),
(3, 'Admin User', 'admin@example.com', '5556667777', 'adminpass', NULL, 'admin'),
(4, 'Alice Johnson', 'alice@example.com', '1112223333', 'password789', 4.3, 'rider'),
(5, 'Bob Brown', 'bob@example.com', '4445556666', 'passwordabc', 4.7, 'driver'),
(6, 'Eva Davis', 'eva@example.com', '7778889999', 'passwordefg', 4.2, 'rider'),
(7, 'David Lee', 'david@example.com', '6667778888', 'passwordxyz', 4.9, 'driver');


SELECT * FROM [User] ;

-- Create Vehicle table
CREATE TABLE Vehicle (
    vehicle_id INT PRIMARY KEY,
    make VARCHAR(50),
    model VARCHAR(50),
    year INT,
    license_plate VARCHAR(20),
    color VARCHAR(20),
    driver_id INT,
    FOREIGN KEY (driver_id) REFERENCES [User](user_id)
);

INSERT INTO Vehicle (vehicle_id, make, model, year, license_plate, color, driver_id)
VALUES
(1, 'Toyota', 'Camry', 2018, 'ABC123', 'Black', 2),
(2, 'Honda', 'Accord', 2019, 'XYZ456', 'White', 5),
(3, 'Ford', 'Fusion', 2017, 'DEF789', 'Silver', 7),
(4, 'Chevrolet', 'Malibu', 2020, 'GHI123', 'Red', 2),
(5, 'Nissan', 'Altima', 2016, 'JKL456', 'Blue', 5),
(6, 'Toyota', 'Corolla', 2015, 'MNO789', 'Gray', 7),
(7, 'Honda', 'Civic', 2019, 'PQR123', 'Green', 5);


SELECT * FROM Vehicle ;

-- Create Location table
CREATE TABLE Location (
    location_id INT PRIMARY KEY,
    address VARCHAR(255),
    latitude FLOAT,
    longitude FLOAT,
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);


INSERT INTO Location (location_id, address, latitude, longitude, city, state, country)
VALUES
(1, '123 Main St', 40.7128, -74.0060, 'New York City', 'NY', 'USA'),
(2, '456 Elm St', 34.0522, -118.2437, 'Los Angeles', 'CA', 'USA'),
(3, '789 Oak St', 41.8781, -87.6298, 'Chicago', 'IL', 'USA'),
(4, '321 Pine St', 29.7604, -95.3698, 'Houston', 'TX', 'USA'),
(5, '987 Maple St', 33.4484, -112.0740, 'Phoenix', 'AZ', 'USA'),
(6, '654 Cedar St', 39.9526, -75.1652, 'Philadelphia', 'PA', 'USA'),
(7, '210 Walnut St', 37.7749, -122.4194, 'San Francisco', 'CA', 'USA');

SELECT * FROM Location ;

-- Create RideRequest table
CREATE TABLE RideRequest (
    request_id INT PRIMARY KEY,
    rider_id INT,
    pickup_location_id INT,
    dropoff_location_id INT,
    ride_type_id INT,
    created_at DATETIME DEFAULT GETDATE(), -- Use DATETIME and GETDATE() for default value
    FOREIGN KEY (rider_id) REFERENCES [User](user_id),
    FOREIGN KEY (pickup_location_id) REFERENCES Location(location_id),
    FOREIGN KEY (dropoff_location_id) REFERENCES Location(location_id)
);

INSERT INTO RideRequest (request_id, rider_id, pickup_location_id, dropoff_location_id, ride_type_id)
VALUES
(1, 1, 1, 2, 1),
(2, 4, 3, 5, 2),
(3, 6, 7, 4, 1),
(4, 2, 2, 6, 3),
(5, 7, 5, 1, 2),
(6, 3, 4, 3, 1),
(7, 5, 6, 7, 3);


SELECT * FROM RideRequest ;

-- Create Ride table
CREATE TABLE Ride (
    ride_id INT PRIMARY KEY,
    request_id INT,
    driver_id INT,
    vehicle_id INT,
    start_time DATETIME,
    end_time DATETIME,
    fare DECIMAL(10, 2),
    rating FLOAT,
    status VARCHAR(20), -- Use VARCHAR for status
    CONSTRAINT chk_status CHECK (status IN ('completed', 'cancelled', 'ongoing')), -- Add CHECK constraint
    FOREIGN KEY (request_id) REFERENCES RideRequest(request_id),
    FOREIGN KEY (driver_id) REFERENCES [User](user_id),
    FOREIGN KEY (vehicle_id) REFERENCES Vehicle(vehicle_id)
);


INSERT INTO Ride (ride_id, request_id, driver_id, vehicle_id, start_time, end_time, fare, rating, status)
VALUES
(1, 1, 2, 1, '2024-03-18 08:00:00', '2024-03-18 08:30:00', 25.00, 4.5, 'completed'),
(2, 2, 5, 2, '2024-03-18 09:00:00', '2024-03-18 09:45:00', 35.00, 4.8, 'completed'),
(3, 3, 7, 3, '2024-03-18 10:00:00', '2024-03-18 10:20:00', 15.00, 4.2, 'completed'),
(4, 4, 2, 1, '2024-03-18 11:00:00', NULL, 20.00, NULL, 'ongoing'),
(5, 5, 7, 2, '2024-03-18 12:00:00', '2024-03-18 12:25:00', 30.00, 4.7, 'completed'),
(6, 6, 3, 3, '2024-03-18 13:00:00', NULL, 18.00, NULL, 'ongoing'),
(7, 7, 5, 1, '2024-03-18 14:00:00', '2024-03-18 14:10:00', 22.00, 4.9, 'completed');


SELECT * FROM Ride ;


-- Create RideType table
CREATE TABLE RideType (
    ride_type_id INT PRIMARY KEY,
    name VARCHAR(50),
    base_price DECIMAL(10, 2),
    price_per_mile DECIMAL(10, 2),
    price_per_minute DECIMAL(10, 2),
    description TEXT
);



INSERT INTO RideType (ride_type_id, name, base_price, price_per_mile, price_per_minute, description)
VALUES
(1, 'UberX', 20.00, 1.50, 0.20, 'Standard ridesharing service'),
(2, 'UberXL', 30.00, 2.00, 0.25, 'Ridesharing service with larger vehicles'),
(3, 'UberBlack', 50.00, 3.00, 0.30, 'Premium ridesharing service with luxury vehicles'),
(4, 'UberPool', 15.00, 1.00, 0.15, 'Shared rides with other passengers'),
(5, 'UberSelect', 40.00, 2.50, 0.35, 'Ridesharing service with premium vehicles'),
(6, 'UberSUV', 60.00, 3.50, 0.40, 'Ridesharing service with SUV vehicles'),
(7, 'UberEats', 10.00, NULL, NULL, 'Food delivery service');


SELECT * FROM RideType ;




-- Create Payment table
CREATE TABLE Payment (
    payment_id INT PRIMARY KEY,
    ride_id INT,
    payment_method VARCHAR(50),
    amount DECIMAL(10, 2),
    transaction_id VARCHAR(100),
    FOREIGN KEY (ride_id) REFERENCES Ride(ride_id)
);

INSERT INTO Payment (payment_id, ride_id, payment_method, amount, transaction_id)
VALUES
(1, 1, 'Credit Card', 25.00, 'ABC123XYZ'),
(2, 2, 'PayPal', 35.00, 'DEF456UVW'),
(3, 3, 'Cash', 15.00, 'GHI789RST'),
(4, 4, 'Credit Card', 20.00, 'JKL012LMN'),
(5, 5, 'Credit Card', 30.00, 'OPQ345STU'),
(6, 6, 'Cash', 18.00, 'VWX678YZA'),
(7, 7, 'PayPal', 22.00, 'BCD901EFG');


SELECT * FROM Payment ;


-- Create Promotion table
CREATE TABLE Promotion (
    promotion_id INT PRIMARY KEY,
    code VARCHAR(50),
    discount_type VARCHAR(20), -- Change to VARCHAR
    discount_value DECIMAL(10, 2),
    start_date DATE,
    end_date DATE,
    CONSTRAINT chk_discount_type CHECK (discount_type IN ('percentage', 'fixed')) -- Add CHECK constraint
);

INSERT INTO Promotion (promotion_id, code, discount_type, discount_value, start_date, end_date)
VALUES
(1, 'FIRSTRIDE', 'percentage', 10.00, '2024-01-01', '2024-03-31'),
(2, 'WEEKEND20', 'fixed', 5.00, '2024-03-01', '2024-03-31'),
(3, 'SAVEBIG', 'percentage', 15.00, '2024-03-15', '2024-04-15'),
(4, 'SPRINGSALE', 'percentage', 20.00, '2024-03-20', '2024-04-20'),
(5, 'WELCOMEBACK', 'fixed', 10.00, '2024-02-01', '2024-03-31'),
(6, 'SUMMERDEAL', 'fixed', 8.00, '2024-06-01', '2024-08-31'),
(7, 'HOLIDAYSALE', 'percentage', 25.00, '2024-11-01', '2024-12-31');


SELECT * FROM  Promotion ;


-- Create Feedback table
CREATE TABLE Feedback (
    feedback_id INT PRIMARY KEY,
    user_id INT,
    ride_id INT,
    rating FLOAT,
    comment TEXT,
    FOREIGN KEY (user_id) REFERENCES [User](user_id), -- Enclose "User" in square brackets
    FOREIGN KEY (ride_id) REFERENCES Ride(ride_id)
);

INSERT INTO Feedback (feedback_id, user_id, ride_id, rating, comment)
VALUES
(1, 1, 1, 4.5, 'Great ride!'),
(2, 2, 2, 4.8, 'The driver was very polite and professional.'),
(3, 3, 3, 4.2, 'The ride was smooth but took longer than expected.'),
(4, 4, 4, 4.0, 'Average experience.'),
(5, 5, 5, 4.7, 'Excellent service.'),
(6, 6, 6, 3.5, 'The driver was late.'),
(7, 7, 7, 4.9, 'Best ride ever! The driver was friendly and helpful.');


SELECT * FROM Feedback ;

-- Create Document table
CREATE TABLE Document (
    document_id INT PRIMARY KEY,
    user_id INT,
    document_type VARCHAR(50),
    file_path VARCHAR(255),
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);

INSERT INTO Document (document_id, user_id, document_type, file_path)
VALUES
(1, 1, 'Driver License', '/documents/driver_license_john_doe.pdf'),
(2, 2, 'Driver License', '/documents/driver_license_jane_smith.pdf'),
(3, 3, 'Driver License', '/documents/driver_license_admin_user.pdf'),
(4, 4, 'ID Card', '/documents/id_card_alice_johnson.pdf'),
(5, 5, 'ID Card', '/documents/id_card_bob_brown.pdf'),
(6, 6, 'ID Card', '/documents/id_card_eva_davis.pdf'),
(7, 7, 'ID Card', '/documents/id_card_david_lee.pdf');

SELECT * FROM Document ;

-- Create Earnings table
CREATE TABLE Earnings (
    earning_id INT PRIMARY KEY,
    driver_id INT,
    ride_id INT,
    amount DECIMAL(10, 2),
    payout_date DATE,
    FOREIGN KEY (driver_id) REFERENCES [User](user_id),
    FOREIGN KEY (ride_id) REFERENCES Ride(ride_id)
);


INSERT INTO Earnings (earning_id, driver_id, ride_id, amount, payout_date)
VALUES
(1, 2, 1, 20.00, '2024-03-18'),
(2, 5, 2, 30.00, '2024-03-18'),
(3, 7, 3, 15.00, '2024-03-18'),
(4, 2, 4, 20.00, '2024-03-19'),
(5, 7, 5, 30.00, '2024-03-19'),
(6, 3, 6, 18.00, '2024-03-19'),
(7, 5, 7, 22.00, '2024-03-19');


SELECT * FROM Earnings ;


-- Create SupportTicket table
CREATE TABLE SupportTicket (
    ticket_id INT PRIMARY KEY,
    user_id INT,
    subject VARCHAR(255),
    message TEXT,
    status VARCHAR(10) CHECK (status IN ('open', 'closed')), -- Use VARCHAR with CHECK constraint
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);


INSERT INTO SupportTicket (ticket_id, user_id, subject, message, status)
VALUES
(1, 1, 'Payment Issue', 'I was overcharged for my ride.', 'open'),
(2, 2, 'Driver Behavior', 'The driver was rude during the ride.', 'open'),
(3, 3, 'App Error', 'I encountered an error while booking a ride.', 'closed'),
(4, 4, 'Lost Item', 'I left my bag in the vehicle.', 'open'),
(5, 5, 'Service Feedback', 'Overall good experience.', 'closed'),
(6, 6, 'Payment Dispute', 'I did not receive a refund for a cancelled ride.', 'open'),
(7, 7, 'Account Access', 'I cannot log in to my account.', 'closed');


SELECT * FROM SupportTicket ;

-- Create Notification table
CREATE TABLE Notification (
    notification_id INT PRIMARY KEY,
    user_id INT,
    message TEXT,
    type VARCHAR(50),
    sent_at DATETIME DEFAULT GETDATE(), -- Use DATETIME with GETDATE() for default value
    FOREIGN KEY (user_id) REFERENCES [User](user_id)
);


INSERT INTO Notification (notification_id, user_id, message, type)
VALUES
(1, 1, 'Your ride has been confirmed.', 'ride_confirmation'),
(2, 2, 'Your payment has been processed successfully.', 'payment_confirmation'),
(3, 3, 'New promotions are available. Check them out!', 'promotion_update'),
(4, 4, 'Your support ticket has been resolved.', 'ticket_resolution'),
(5, 5, 'New feature updates are available. Explore now!', 'feature_update'),
(6, 6, 'Your ride has been completed. Please rate your driver.', 'ride_completion'),
(7, 7, 'Your account password has been reset.', 'password_reset');



SELECT * FROM Notification ;


-- Create Admin table
CREATE TABLE Admin (
    admin_id INT PRIMARY KEY,
    username VARCHAR(50),
    password VARCHAR(100)
);


INSERT INTO Admin (admin_id, username, password)
VALUES
(1, 'admin1', 'admin123'),
(2, 'admin2', 'admin456'),
(3, 'admin3', 'admin789'),
(4, 'admin4', 'adminABC'),
(5, 'admin5', 'adminDEF'),
(6, 'admin6', 'adminGHI'),
(7, 'admin7', 'adminJKL');

SELECT * FROM Admin ;


-- 3. List all ride requests along with their pickup and dropoff locations.
SELECT rr.request_id, rr.rider_id, rr.pickup_location_id, rr.dropoff_location_id, 
       pl.address AS pickup_location, dl.address AS dropoff_location
FROM RideRequest rr
JOIN Location pl ON rr.pickup_location_id = pl.location_id
JOIN Location dl ON rr.dropoff_location_id = dl.location_id;

-- 4. Get the total number of rides completed by each driver.
SELECT r.driver_id, COUNT(*) AS total_rides_completed
FROM Ride r
WHERE r.status = 'completed'
GROUP BY r.driver_id;

-- 5. Find the average fare of all completed rides.
SELECT AVG(r.fare) AS average_fare
FROM Ride r
WHERE r.status = 'completed';



-- 7. Calculate the total earnings of each driver.
SELECT e.driver_id, SUM(e.amount) AS total_earnings
FROM Earnings e
GROUP BY e.driver_id;

-- 8. Identify the users who have submitted feedback for a particular ride.
SELECT f.user_id, f.ride_id
FROM Feedback f;

-- 9. List all support tickets with the status "open".
SELECT * FROM SupportTicket WHERE status = 'open';



-- 11. Retrieve the details of rides where the fare exceeds $50.
SELECT * FROM Ride WHERE fare > 50.00;

-- 12. List the documents uploaded by a specific user.
SELECT * FROM Document WHERE user_id = 1; -- Change user_id accordingly



-- 14. Find the rides completed within a specific date range.
SELECT * FROM Ride WHERE status = 'completed' AND start_time BETWEEN '2024-03-01' AND '2024-03-31'; -- Adjust date range accordingly

-- 15. Identify the users with the highest ratings.
SELECT user_id, MAX(rating) AS highest_rating
FROM [User];

-- 16. List the rides along with their corresponding payment details.
SELECT r.*, p.*
FROM Ride r
JOIN Payment p ON r.ride_id = p.ride_id;

-- 17. Find the rides that had a rating below 3.
SELECT * FROM Ride WHERE rating < 3.0;

-- 19. Calculate the total amount earned through promotions.
SELECT SUM(discount_value) AS total_amount_earned FROM Promotion;

-- 20. Identify the users who have not provided any feedback.
SELECT u.* 
FROM [User] u
LEFT JOIN Feedback f ON u.user_id = f.user_id
WHERE f.feedback_id IS NULL;

-- 21. List the rides sorted by their start time.
SELECT * FROM Ride ORDER BY start_time;

-- 22. Find the total number of support tickets submitted by each user.
SELECT user_id, COUNT(*) AS total_tickets_submitted
FROM SupportTicket
GROUP BY user_id;

-- 24. Identify the users who have not completed any rides yet.
SELECT u.*
FROM [User] u
LEFT JOIN Ride r ON u.user_id = r.driver_id
WHERE r.driver_id IS NULL;


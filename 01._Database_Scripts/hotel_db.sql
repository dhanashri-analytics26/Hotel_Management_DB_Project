-- HOTEL MANAGEMENT DATABASE PROJECT
-- Purpose: Manage hotels and customer reviews
-- Author: Dhanashri Borse

CREATE DATABASE hoteldb;
USE hoteldb;

-- TABLE 1: Hotels
-- Stores basic hotel information
CREATE TABLE Hotels (
    HotelID INT PRIMARY KEY AUTO_INCREMENT,
    HotelName VARCHAR(100) NOT NULL,
    Location VARCHAR(50),
    Rating DECIMAL(2,1),
    TotalRooms INT
);
DESCRIBE Hotels;

-- TABLE 2: HotelReviews
-- Stores customer reviews for hotels
CREATE TABLE HotelReviews (
    ReviewID INT PRIMARY KEY AUTO_INCREMENT,
    HotelID INT,
    CustomerName VARCHAR(50),
    ReviewText VARCHAR(255),
    Rating INT,
    FOREIGN KEY (HotelID) REFERENCES Hotels(HotelID)
);
DESCRIBE HotelReviews;
SHOW TABLES;

-- INSERT SAMPLE DATA INTO Hotels TABLE
INSERT INTO Hotels (HotelName, Location, Rating, TotalRooms)
VALUES 
('Grand Palace', 'Pune', 4.5, 120),
('Sea View Resort', 'Goa', 4.2, 80),
('City Inn', 'Mumbai', 3.9, 60);
SELECT * FROM Hotels;

-- INSERT SAMPLE DATA INTO HotelReviews TABLE
INSERT INTO HotelReviews (HotelID, CustomerName, ReviewText, Rating)
VALUES
(1, 'Rahul', 'Very clean and excellent service', 5),
(1, 'Anita', 'Good location and staff', 4),
(2, 'Amit', 'Beautiful view and calm place', 5),
(3, 'Neha', 'Average stay but decent for price', 3);
SELECT * FROM HotelReviews;

-- JOIN QUERY
-- Purpose: Display hotel details along with
-- customer reviews (business reporting)
SELECT 
    h.HotelName,
    h.Location,
    r.CustomerName,
    r.Rating,
    r.ReviewText
FROM Hotels h
JOIN HotelReviews r
ON h.HotelID = r.HotelID;

-- UPDATE OPERATION
-- Scenario: Hotel rating updated after new reviews
UPDATE Hotels
SET Rating = 4.6
WHERE HotelID = 1;

-- Verify updated hotel rating
SELECT HotelID, HotelName, Rating
FROM Hotels
WHERE HotelID = 1;

-- DELETE OPERATION
-- Scenario: Remove an invalid or duplicate review
DELETE FROM HotelReviews
WHERE ReviewID = 4;

-- Verify remaining reviews
SELECT * FROM HotelReviews;

-- STORED PROCEDURE
-- Purpose: Fetch all reviews for a specific hotel
-- Improves reusability and performance
DELIMITER //

CREATE PROCEDURE GetHotelReviews(IN p_HotelID INT)
BEGIN
    SELECT 
        h.HotelName,
        h.Location,
        r.CustomerName,
        r.Rating,
        r.ReviewText
    FROM Hotels h
    JOIN HotelReviews r
    ON h.HotelID = r.HotelID
    WHERE h.HotelID = p_HotelID;
END //

DELIMITER ;

-- Call stored procedure for an existing hotel
CALL GetHotelReviews(1);

-- Call stored procedure for a non-existing hotel
-- (Returns no data, handled safely)
CALL GetHotelReviews(99);


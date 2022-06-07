-- Part 2.4 update.sql
--
-- Submitted by: <Crystal Chan>, <19001568>
-- 

-- DO NOT use these SQL commands in your submission(they will cause an 
--  error on the NMS database server):
-- CREATE SCHEMA 
-- USE 

-- DDL:
-- Changing Participant to hourly payment
ALTER TABLE Participant ADD HourlySalary FLOAT(7,2);
UPDATE Participant SET HourlySalary = DailySalary/4;
ALTER TABLE Participant DROP DailySalary;

-- Changing Coach to hourly payment.
ALTER TABLE Coach ADD HourlySalary FLOAT(7,2);
UPDATE Coach SET HourlySalary = DailySalary/4;
ALTER TABLE Coach DROP DailySalary; 

-- Adding new attendance fields.
ALTER TABLE ContenderInShow ADD Arrival TIME, ADD Departure TIME;
ALTER TABLE CoachInShow ADD Arrival TIME, ADD Departure TIME;

-- Updating arrival and departure times.
UPDATE ContenderInShow
INNER JOIN TVShow ON TVShow.idShow = ContenderInShow.Episode
SET ContenderInShow.Arrival = SUBTIME(TVShow.StartTime, '01:00:00');

UPDATE ContenderInShow 
INNER JOIN TVShow ON TVShow.idShow = ContenderInShow.Episode
SET ContenderInShow.Departure = ADDTIME(TVShow.EndTime, '01:00:00');

UPDATE CoachInShow
INNER JOIN TVShow ON TVShow.idShow = CoachInShow.Episode
SET CoachInShow.Arrival = SUBTIME(TVShow.StartTime, '01:00:00');

UPDATE CoachInShow
INNER JOIN TVShow ON TVShow.idShow = CoachInShow.Episode
SET CoachInShow.Departure = ADDTIME(TVShow.EndTime, '01:00:00');










-- Part 2.3 select.sql
--
-- Submitted by: <Crystal Chan>, <19001568>
-- 

-- DO NOT use these SQL commands in your submission(they will cause an 
--  error on the NMS database server):
-- CREATE SCHEMA 
-- USE 

--DDL:
-- 1. Average Female Salary

SELECT ROUND(AVG(DailySalary))
FROM Participant
WHERE Gender = 'F';

-- 2. Coaching Report

SELECT Coach.Name, Coach.Surname, Coach.idCoach, COUNT(Coach) AS Coaching
FROM Coach LEFT JOIN Contender ON Coach.idCoach = Contender.Coach
GROUP BY idCoach;

-- 3. Coach Monthly Attendance Report

SELECT Coach.Name, Coach.Surname, Coach.idCoach, 
	SUM(DATE(Date) BETWEEN '2019-03-01' AND '2019-03-31') AS MarchShows, 
	SUM(DATE(Date) BETWEEN '2019-04-01' AND '2019-04-30') AS AprilShows
FROM Coach LEFT JOIN CoachInShow ON idCoach = Coach 
	JOIN TVShow ON CoachInShow.Episode = TVShow.idShow
GROUP BY Coach;

-- 4. Most Expensive Contender

SELECT Contender.StageName, SUM(DailySalary) as TotalSalary
FROM Participant JOIN Contender ON Participant.Contender = Contender.idContender
GROUP BY Contender.StageName
ORDER BY TotalSalary DESC
LIMIT 1;

-- 5. March Payment Report

-- Coach report for March
SELECT CONCAT(Coach.Name, ' ', Coach.Surname) AS CoachName, CONCAT(Coach.DailySalary) AS CoachSalary,
	SUM(DATE(Date) BETWEEN '2019-03-01' AND '2019-03-31') AS MarchShows, 
	SUM(DATE(Date) BETWEEN '2019-03-01' AND '2019-03-31')*DailySalary AS MarchSalary
FROM Coach LEFT JOIN CoachInShow ON Coach.idCoach = CoachInShow.Coach JOIN TVShow ON TVShow.idShow = CoachInShow.Episode
GROUP BY idCoach;

SELECT CONCAT(Participant.Name, ' ', Participant.Surname) AS ParticipantName, CONCAT(Participant.DailySalary) AS ParticipantSalary,
	SUM(DATE(Date) BETWEEN '2019-03-01' AND '2019-03-31') AS MarchShows,
	SUM(DATE(Date) BETWEEN '2019-03-01' AND '2019-03-31')*DailySalary AS MarchSalary
FROM Participant JOIN ContenderInShow ON Participant.Contender = ContenderInShow.Contender JOIN TVShow ON TVShow.idShow = ContenderInShow.Episode
GROUP BY Name;

-- 6. Well Formed Groups!

-- Inserting invalid Group contender with zero participants.
INSERT INTO Contender VALUES ('Test 2.2.6', 'Group', '12345', '11222017910');

-- Running query with the false test tuple inserted, expecting to return False, 0
SELECT Contender.StageName, Contender.idContender,
	IF(COUNT(idParticipant) > 1, true, false) AS isGroupContender
FROM Participant RIGHT JOIN Contender ON Participant.Contender = Contender.idContender
WHERE Contender.Type = 'Group'
GROUP BY Contender;



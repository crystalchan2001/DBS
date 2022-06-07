-- Part 2.5 delete.sql
--
-- Submitted by: <Crystal Chan>, <19001568>
-- 

-- DO NOT use these SQL commands in your submission(they will cause an 
--  error on the NMS database server):
-- CREATE SCHEMA 
-- USE 

-- DDL:

-- Deleting all J Hus' attendance records
DELETE ContenderInShow
FROM ContenderInShow INNER JOIN Contender
WHERE Contender.StageName = 'J Hus' AND Contender.idContender = ContenderInShow.Contender;

-- Deleting all Momodou Jallow's (J Hus') personal information
DELETE Participant
FROM Participant INNER JOIN Contender
WHERE Contender.StageName = 'J Hus' AND Contender.idContender = Participant.Contender;

-- Deleting J Hus' contender records
DELETE Contender
FROM Contender
WHERE StageName = 'J Hus';


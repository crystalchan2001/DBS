-- Part 2.1 schema.sql
--
-- Submitted by: <Crystal Chan>, <19001568>
-- 
 
-- DO NOT use these SQL commands in your submission(they will cause an 
-- error on the NMS database server):
-- CREATE SCHEMA 
-- USE 

-- DDL:
-- All ON UPDATEs are remedied by a CASCADE action.
CREATE TABLE Coach(
	Name VARCHAR(20) NOT NULL,
	Surname VARCHAR(30),
	DOB DATE,
	idCoach VARCHAR(11) NOT NULL,
	Phone VARCHAR(12),
	DailySalary FLOAT(7,2) UNSIGNED,
	Gender CHAR(1),

	PRIMARY KEY (idCoach)
);

-- Would have preferred ON DELETE SET DEFAULT for FK DELETE action.
-- When a Coach is deleted off the database(dbs) (leaves), the Contenders coached
-- by the Coach are given the DEFAULT coach as a replacement.

CREATE TABLE Contender(
	StageName VARCHAR(30) UNIQUE NOT NULL,
	Type VARCHAR(5),
	idContender VARCHAR(11) NOT NULL,
	Coach VARCHAR(11) NOT NULL,

	PRIMARY KEY(idContender),

	FOREIGN KEY(Coach) REFERENCES Coach(idCoach)
	ON DELETE RESTRICT ON UPDATE CASCADE	
);

-- ON DELETE RESTRICT: on deletion of a Contender from the dbs, avoid 
-- leaving Participant(s) not belonging to any Contender.

CREATE TABLE Participant(
	Name VARCHAR(20),
	Surname VARCHAR(30),
	DOB DATE,
	idParticipant VARCHAR(11) NOT NULL,
	Phone VARCHAR(12),
	DailySalary FLOAT(7,2) UNSIGNED,
	Gender CHAR(1),
	Contender VARCHAR(11) NOT NULL, 

	PRIMARY KEY (idParticipant),

	FOREIGN KEY (Contender) REFERENCES Contender(idContender)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

-- All attributes are non null to ensure full details of each show are recorded.
-- The default value of the Location has been set to TV Studio and it is 
-- updated if the show didn't take place there.

CREATE TABLE TVShow(
	Location VARCHAR(20) NOT NULL DEFAULT 'TV Studio',
	Date DATE NOT NULL,
	idShow VARCHAR(11) NOT NULL,
	StartTime TIME NOT NULL,
	EndTime TIME NOT NULL,
	
	PRIMARY KEY(idShow)
);

-- FK Coach ON DELETE CASCADE: if a coach is deleted from the dbs (leaves),
-- all attendance records are deleted with their personal information.
-- FK Episode ON DELETE RESTRICT: if a show is deleted for some reason, the 
-- coaches' attendances still exist.

CREATE TABLE CoachInShow(
	Coach VARCHAR(11) NOT NULL,
	Episode VARCHAR(11) NOT NULL,

	PRIMARY KEY(Coach, Episode),
	
	FOREIGN KEY(Coach) REFERENCES Coach(idCoach)
	ON DELETE RESTRICT ON UPDATE CASCADE,

	FOREIGN KEY(Episode) REFERENCES TVShow(idShow)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

-- FK Contender ON DELETE CASCADE: if a Contender is deleted from the dbs
-- (leaves), all their attendance records are deleted too.
-- FK Episode ON DELETE RESTRICT: if a show is deleted for some reason, the
-- Contenders' show attendances remain.

CREATE TABLE ContenderInShow(
	Contender VARCHAR(11) NOT NULL,
	Episode VARCHAR(11) NOT NULL,

	PRIMARY KEY(Contender, Episode),

	FOREIGN KEY(Contender) REFERENCES Contender(idContender)
	ON DELETE RESTRICT ON UPDATE CASCADE,

	FOREIGN KEY(Episode) REFERENCES TVShow(idShow)
	ON DELETE RESTRICT ON UPDATE CASCADE
);

-- I did not implement semantic intergrity constraint that each Contender must have
-- at least one participant. I would have checked for violations using CHECK. 



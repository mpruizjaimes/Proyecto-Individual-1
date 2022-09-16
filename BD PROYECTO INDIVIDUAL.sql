---IMPORTAR CSV---
CREATE DATABASE Proyecto;
USE  Proyecto;
drop table DF1 ;
CREATE TABLE DF1(
raceld int,
driverld int,
lap int,
position int,
time VARCHAR(50),
miliseconds VARCHAR(250));


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\PI\\lap_times_split_1.csv'
INTO TABLE DF1
FIELDS TERMINATED BY ',' 
LINES TERMINATED BY '\r\n' IGNORE 1 LINES;

SHOW VARIABLES LIKE "secure_file_priv";

SELECT *
FROM DF1;

USE  Proyecto;
drop table RACES ;
CREATE TABLE RACES(
ROW1 INT,
raceld int,
year year(4),
round int,
circuitId int,
name VARCHAR(50),
date date,
time VARCHAR(50),
URL VARCHAR(150));


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\PI\\races.csv'
INTO TABLE RACES
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n' IGNORE 1 LINES;

Select *
from races;

select COUNT(*)
from races;

USE  Proyecto;
drop table RESULTS ;
CREATE TABLE RESULTS(
ROW1 INT,
resultId int,
raceId int,
driverId int,
constructorId int,
number int,
grid int,
position int,
positionText VARCHAR(50),
positionOrder int,
points FLOAT,
laps int,
time VARCHAR(50),
milliseconds int,
fastestLap int,
ranking int,
fastestLapTime VARCHAR(50),
fastestLapSpeed FLOAT (10,3),
statusId int);


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\PI\\results.csv'
INTO TABLE results
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n' IGNORE 1 LINES;

select *
from results;

drop table df1 ;

drop table constructors ;
CREATE TABLE constructors(
ROW1 INT,
constructorId int,
constructorRef VARCHAR(50),
name VARCHAR(50),
nationality VARCHAR(50),
url VARCHAR(150));


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\PI\\constructors.csv'
INTO TABLE constructors
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n' IGNORE 1 LINES;

SELECT *
FROM CONSTRUCTORS;

drop table drivers ;
CREATE TABLE drivers(
ROW1 INT,
driverId int,
driverRef LONGTEXT,
number LONGTEXT,
code LONGTEXT,
dob date,
nationality LONGTEXT,
url LONGTEXT,
forename LONGTEXT,
surname LONGTEXT
);


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\PI\\drivers.csv'
INTO TABLE drivers
FIELDS TERMINATED BY ',' ENCLOSED BY '\"' ESCAPED BY '\"' 
LINES TERMINATED BY '\n' IGNORE 1 LINES;

SELECT *
FROM drivers;

SELECT *
FROM races;

SELECT   Year
FROM races
GROUP BY YEAR
ORDER BY COUNT(*) DESC
LIMIT 1;
#pregunta 1,completa , resumida, Year 2021.

SELECT *
FROM results;

SELECT forename, surname
FROM drivers
where driverId= (SELECT   driverId
FROM results
where position=1
GROUP BY driverId
ORDER BY COUNT(*) DESC
LIMIT 1);
#pregunta 2, completa, resumida: forename=Lewis; surname=Hamilton


SELECT name
FROM races
where circuitId= (SELECT  circuitId
FROM races
GROUP BY circuitId
ORDER BY COUNT(*) DESC
LIMIT 1) LIMIT 1;
#pregunta 3, resumida, completa: Italian Grand Prix


SELECT forename, surname
FROM drivers
where driverId=(SELECT  driverId
FROM results
WHERE constructorId in (SELECT constructorId
FROM constructors
where nationality='British' or 'American')
GROUP BY driverId
ORDER BY SUM(points) DESC
LIMIT 1);
#Pregunta 4 (resumida, completa), Jenson Button
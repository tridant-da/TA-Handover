---*******************Patron Location Data-SA*************

--*********************ADELAIDE INTERNATIONAL****************************
--TOTAL

SELECT COUNT(DISTINCT SEQ_ID,CUST_NAME_ID, ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING" RT
WHERE RT.EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND RT.EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
--33663

--1. Local
WITH ADELAIDE AS
(SELECT DISTINCT SUBSTR (POSTCODE,1,4) AS POSTCODE FROM 
    (SELECT DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,
            CASE WHEN POSTCODE BETWEEN '5000' AND '5999' THEN POSTCODE
             END AS POSTCODE
FROM  "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE POSTCODE IS NOT NULL
)
WHERE LEN(POSTCODE)='4'
ORDER BY POSTCODE
)
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE IN (SELECT * FROM ADELAIDE)
AND STATE ='SA'
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE
--21667


--INTERSTATE
WITH ADELAIDE AS
(SELECT DISTINCT SUBSTR (POSTCODE,1,4) AS POSTCODE FROM 
    (SELECT DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,
            CASE WHEN POSTCODE BETWEEN '5000' AND '5999' THEN POSTCODE
             END AS POSTCODE
FROM  "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE POSTCODE IS NOT NULL
)
WHERE LEN(POSTCODE)='4'
ORDER BY POSTCODE
)
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE, POSTCODE) FROM
(
SELECT  SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,SUBSTR (POSTCODE, 1,4) AS POSTCODE
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND STATE <>'SA'
AND POSTCODE NOT IN (SELECT * FROM ADELAIDE)
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE)
--1848

--INTERNATIONAL
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE, POSTCODE) FROM
(
SELECT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,SUBSTR (POSTCODE, 1,4) AS POSTCODE
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND COUNTRY NOT IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE)
--72

--UNKNOWN

SELECT DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND (POSTCODE IS NULL
    OR POSTCODE =''
    OR POSTCODE NOT BETWEEN '5000' AND '5999'
    OR COUNTRY IS NULL
    OR COUNTRY =''
     )
     ORDER BY POSTCODE
--11955 

------Intrastate

---City of Adelaide 

SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE BETWEEN '5000' AND '5006'
AND STATE ='SA'
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE
--2296

--Greater Metro 
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE BETWEEN '5007' AND '5199'
AND STATE ='SA'
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE
--17348

--Regional SA
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE BETWEEN '5200' AND '5999'
AND STATE ='SA'
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE
--2023

--------State Breakdown
--ACT
WITH ACT AS
(SELECT DISTINCT SUBSTR (POSTCODE,1,4) AS POSTCODE FROM 
(SELECT DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,
            CASE WHEN POSTCODE BETWEEN '0200' AND '0299' THEN POSTCODE
                 WHEN POSTCODE BETWEEN '2600' AND '2618' THEN POSTCODE
                 WHEN POSTCODE BETWEEN '2900' AND '2920' THEN POSTCODE
                 END AS POSTCODE
FROM  "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE POSTCODE IS NOT NULL
)
WHERE LEN(POSTCODE)='4'
ORDER BY POSTCODE
)
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE IN (SELECT * FROM ACT)
AND STATE ='ACT'
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE
--85

--NSW
WITH NSW AS
(SELECT DISTINCT SUBSTR (POSTCODE,1,4) AS POSTCODE FROM 
(SELECT DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,
            CASE WHEN POSTCODE BETWEEN '2000' AND '2599' THEN POSTCODE
                 WHEN POSTCODE BETWEEN '2619' AND '2898' THEN POSTCODE
                 WHEN POSTCODE BETWEEN '2921' AND '2999' THEN POSTCODE
                 END AS POSTCODE
FROM  "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE POSTCODE IS NOT NULL
)
WHERE LEN(POSTCODE)='4'
ORDER BY POSTCODE
)
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE IN (SELECT * FROM NSW)
AND STATE ='NSW'
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE
--571

--NT
WITH NT AS
(SELECT DISTINCT SUBSTR (POSTCODE,1,4) AS POSTCODE FROM 
(SELECT DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,
            CASE WHEN POSTCODE BETWEEN '0800' AND '0899' THEN POSTCODE
                 WHEN POSTCODE BETWEEN '0900' AND '0999' THEN POSTCODE
                 END AS POSTCODE
FROM  "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE POSTCODE IS NOT NULL
)
WHERE LEN(POSTCODE)='4'
ORDER BY POSTCODE
)
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE IN (SELECT * FROM NT)
AND STATE ='NT'
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE
--62

--QLD
WITH QLD AS
(SELECT DISTINCT SUBSTR (POSTCODE,1,4) AS POSTCODE FROM 
(SELECT DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,
            CASE WHEN POSTCODE BETWEEN '4000' AND '4999' THEN POSTCODE
                 WHEN POSTCODE BETWEEN '9000' AND '9999' THEN POSTCODE
                 END AS POSTCODE
FROM  "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE POSTCODE IS NOT NULL
)
WHERE LEN(POSTCODE)='4'
ORDER BY POSTCODE
)
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE IN (SELECT * FROM QLD)
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
AND STATE ='QLD'
ORDER BY POSTCODE
--139

--SA
WITH SA AS
(SELECT DISTINCT SUBSTR (POSTCODE,1,4) AS POSTCODE FROM 
(SELECT DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,
            CASE WHEN POSTCODE BETWEEN '5000' AND '5799' THEN POSTCODE
                 WHEN POSTCODE BETWEEN '5800' AND '5999' THEN POSTCODE
                 END AS POSTCODE
FROM  "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE POSTCODE IS NOT NULL
)
WHERE LEN(POSTCODE)='4'
ORDER BY POSTCODE
)
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE IN (SELECT * FROM SA)
AND STATE ='SA'
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE
--21707

--TAS
WITH TAS AS
(SELECT DISTINCT SUBSTR (POSTCODE,1,4) AS POSTCODE FROM 
(SELECT DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,
            CASE WHEN POSTCODE BETWEEN '7000' AND '7799' THEN POSTCODE
                 WHEN POSTCODE BETWEEN '7800' AND '7999' THEN POSTCODE
                 END AS POSTCODE
FROM  "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE POSTCODE IS NOT NULL
)
WHERE LEN(POSTCODE)='4'
ORDER BY POSTCODE
)
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE IN (SELECT * FROM TAS)
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE
--26

--VIC
WITH VIC AS
(SELECT DISTINCT SUBSTR (POSTCODE,1,4) AS POSTCODE FROM 
(SELECT DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,
            CASE WHEN POSTCODE BETWEEN '3000' AND '3999' THEN POSTCODE
                 WHEN POSTCODE BETWEEN '8000' AND '8999' THEN POSTCODE
                 END AS POSTCODE
FROM  "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE POSTCODE IS NOT NULL
)
WHERE LEN(POSTCODE)='4'
ORDER BY POSTCODE
)
SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE IN (SELECT * FROM VIC)
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE
--915



-----------------------

SELECT COUNT (DISTINCT SEQ_ID,CUST_NAME_ID,ROW_NAME,SEAT_NUM,EVENT_VENUE_NAME,EVENT_DATE,POSTCODE, STATE, COUNTRY)
FROM "PROD_WAREHOUSE_DB"."DWH"."REPORTING_TICKETING"
WHERE EVENT_TOURNAMENT_SERIES_YEAR ='2022'
AND EVENT_TOURNAMENT_NAME = 'ADELAIDE INTERNATIONAL'
AND POSTCODE BETWEEN '5200' AND '5899'
AND STATE ='SA'
AND COUNTRY  IN ('AU', 'AUSTRALIA', 'AUSTALIA','AUS')
ORDER BY POSTCODE
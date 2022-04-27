

SET StartDate = date('2022-01-17');
SET EndDate = date('2022-02-28');

CREATE OR REPLACE TEMPORARY TABLE PROD_WAREHOUSE_DB.DWH.MEMBER_EMAILS AS
SELECT distinct lower(m.EMAIL) as member_email
FROM "PROD_WAREHOUSE_DB"."DWH"."RPT_CS_MT2_PARTICIPANTS_DEDUPED" m
Where m.TACurrent = 'Y' -- MemberMembershipStatus = 'Active' -
and m.EMAIL like '%_@_%.%';

CREATE OR REPLACE TEMPORARY TABLE PROD_WAREHOUSE_DB.DWH.NEWCH_PARTICIPANTS1 AS
select distinct Contact_ID, Contact_EmailAddress
from "PROD_WAREHOUSE_DB"."DWH"."VW_COURT_HIRE_CASUALBOOKINGS"
where BookingSessionDate BETWEEN $StartDate AND $EndDate
EXCEPT
select Contact_ID, Contact_EmailAddress
from "PROD_WAREHOUSE_DB"."DWH"."VW_COURT_HIRE_CASUALBOOKINGS"
where BookingSessionDate >= (Select DATEADD(year, -2, CAST($StartDate as date))) and BookingSessionDate < $StartDate
;

CREATE OR REPLACE TEMPORARY TABLE PROD_WAREHOUSE_DB.DWH.NEWCH_PARTICIPANTS AS
select distinct ch.Contact_ID, ch.Contact_EmailAddress
from PROD_WAREHOUSE_DB.DWH.NEWCH_PARTICIPANTS1 ch
where ch.Contact_EmailAddress is not null
AND ch.Contact_EmailAddress not in (
select distinct Contact_EmailAddress
from "PROD_WAREHOUSE_DB"."DWH"."VW_OCS_SESSION_REGISTRATIONS"
where Contact_EmailAddress like '%_@_%.__%'
);

-- Insert into appropriate table
--insert into "PROD_WAREHOUSE_DB"."DWH"."RPT_NEW_PARTICIPANTS_COURT_HIRE_MONTHLY"
Select monthname($EndDate) as Date, year($EndDate) as Year,State, Count(distinct Contact_EmailAddress) as NewCHParticanpts
FROM(
Select r.Contact_EmailAddress, MAX(r.State) as State
FROM "PROD_WAREHOUSE_DB"."DWH"."VW_COURT_HIRE_CASUALBOOKINGS" r
inner join PROD_WAREHOUSE_DB.DWH.NEWCH_PARTICIPANTS n on n.Contact_EmailAddress = r.Contact_EmailAddress
Where r.State IS NOT NULL
AND n.Contact_EmailAddress not in (
select member_email
from PROD_WAREHOUSE_DB.DWH.MEMBER_EMAILS
)
GROUP BY r.Contact_EmailAddress
) A
GROUP BY State
ORDER BY Count(distinct Contact_EmailAddress) desc
;

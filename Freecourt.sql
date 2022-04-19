-- New Participants who have redeemed coupon code 'FREECODE' from 17th Jan 2022 - 28th Feb 2022
-- Freecourt coupon data was extracted from Clubspark source and manually loaded to Snowflake, to the table Freecourt

-- Freecourt table
use database dev_landing_db;
use schema "DEV_LANDING_DB"."ZZ_DELETE_TICKETEKPERTH";

-- Free court information from Clubspark loaded to freecourt table
select count(*) from FREECOURT;

-- Filtering the new participants 
select 
date("Booking Date") as Booking_Date,
"Court Fee",
"Customer Paid",
"Email Address",
"Venue Name",
"State"
from freecourt where 
"Booking Date" between '2022-01-17' 
and '2022-02-28'
and upper("Email Address") in 
(select upper(user_emailaddress) from NEW_PARTICIPANTS_LIST);

-- Group by venue
select 
"Venue Name", count(*)
from freecourt where 
"Booking Date" between '2022-01-17' 
and '2022-02-28'
and upper("Email Address") in 
(select upper(user_emailaddress) from NEW_PARTICIPANTS_LIST)
group by "Venue Name";

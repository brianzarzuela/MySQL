-- ---------------------------------------------------------------------------------

-- File       : zarzuela_HW8.sql
-- Author     : Brian Zarzuela
-- Date       : April 2020
--
-- Desciption :
--    Set of commands for utilizing the JOBS database to explore the use of relational
--    algebra, subqueries, and joins with MySQL.
--
-- Notes      :
--
-- ---------------------------------------------------------------------------------

-- Open the database
use JOBS;


-- ---------------------------------------------------------------------------------
--  1. Theoretical relational algebra statement:
--     (EMPLOYER[statecode]) + (QUARTER[location])
select statecode from employer
union
select location from quarter;


-- ---------------------------------------------------------------------------------
--  2. Theoretical relational algebra equijoin between employer and interview with
--     a projection of companyname, division, statecode, and salaryoffered.
select employer.companyname, employer.division, employer.statecode, salaryoffered
from employer inner join interview
on employer.companyname = interview.companyname and employer.division = interview.division;


-- ---------------------------------------------------------------------------------
--  3. Theoretical relational algebra statement:
--     STATE - EMPLOYER
select * from state
where statecode not in (select statecode from employer);


-- ---------------------------------------------------------------------------------
--  4. Theoretical relational algebra statement:
--     INTERVIEW[companyname, minhrsoffered]
select distinct companyname, minhrsoffered from interview;


-- ---------------------------------------------------------------------------------
--  5. Theoretical relational algebra selection from the state table that includes
--     all of the tuples/records that have 'a', 'e', 'i', 'o', or 'u' as the third
--     letter of the description.
select statecode, description from state
where lower(substr(description,3,1)) in ('a', 'e', 'i', 'o', 'u');


-- ---------------------------------------------------------------------------------
--  6. Show the quarter code, location, and state description for locations in the
--     quarter table  that also are found in state.
select quarter.qtrcode, quarter.location, description
from quarter inner join state
on quarter.location = state.statecode;


-- ---------------------------------------------------------------------------------
--  7. Show the description for all states as well as the companynames of employers
--     located in each state.
select state.description, companyname
from state left outer join employer
on state.statecode = employer.statecode;






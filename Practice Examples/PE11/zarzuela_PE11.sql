-- ---------------------------------------------------------------------------------

-- File       : zarzuela_pe11.sql
-- Author     : Brian Zarzuela
-- Date       : April 2020
--
-- Desciption :
--    Set of commands for creating the hospital database from an ER diagram and set
--    of transposed relations.
--
-- Notes      :
--    - Database in all uppercase
--    - Tables in lowercase with '_' as word seperators
--    - Attributes in Pascal case
--    - Booleans represented by tinyint(1)
--        - 0 as FALSE
--        - 1 as TRUE

-- ---------------------------------------------------------------------------------

-- Drop the database if it already exists
drop database if exists ZARZUELA_PE11;

-- Create the database
create database ZARZUELA_PE11;

-- Open the database
use ZARZUELA_PE11;

/* ---------------------------------------------------------------------------------
Create the department table from the relation

department (DeptNum, Name)
  PK = DeptNum 

- DeptNum should be a whole number that is best suited to store up to 200. The value
  should start at 0 and be incremented by 1 for each new record added.
- Name must hold between 1 and 50 characters
--------------------------------------------------------------------------------- */
create table department(
  DeptNum tinyint unsigned auto_increment,
  Name varchar(50) not null,
  constraint department_pk primary key (DeptNum)
);

describe department;

/* ---------------------------------------------------------------------------------
Create the insurance_company table from the relation

insurance_company (CoID, Name)
  PK = CoID

- CoID should be a whole number that is best suited to store up to 65,000. The value
  should start at 0 and be incremented by 1 for each new record added.
- Name must hold between 1 and 80 characters.
--------------------------------------------------------------------------------- */
create table insurance_company(
  CoID smallint unsigned auto_increment,
  Name varchar(80) not null,
  constraint insurance_company_pk primary key (CoID)
);

describe insurance_company;

/* ---------------------------------------------------------------------------------
Create the person table from the relation

person (PersonID, FirstName, LastName)
  PK = PersonID

- PersonID should be a whole number that is best suited to store up to 65,000. The 
  value should start at 0 and be incremented by 1 for each new record added.
- FirstName and LastName must hold between 1 and 25 characters.
- Add appropriate discriminator(s).
--------------------------------------------------------------------------------- */
create table person(
  PersonID smallint unsigned auto_increment,
  FirstName varchar(25) not null,
  LastName varchar(25) not null,
  -- Discriminator added for staff subtype
  IsStaff tinyint(1) not null default 0,
  -- Discriminator added for patient subtype
  IsPatient tinyint(1) not null default 0,
  constraint person_pk primary key (PersonID)
);

describe person;

/* ---------------------------------------------------------------------------------
Create the staff table from the relation

staff (StaffID, ManagerID)
  PK = StaffID

- staff(StaffID) must exist in person(PersonID)
- staff(ManagerID) must exist in staff(StaffID)
- Add appropriate discriminator(s).
--------------------------------------------------------------------------------- */
create table staff(
  StaffID smallint unsigned,
  ManagerID smallint unsigned,
  -- Discriminator added for staff type
  StaffType enum ('support_staff', 'nurse', 'doctor'),
  constraint staff_StaffID_fk foreign key (StaffID) references person(PersonID),
  constraint staff_ManagerID_fk foreign key (ManagerID) references staff(StaffID),
  constraint staff_pk primary key (StaffID)
);

describe staff;

/* ---------------------------------------------------------------------------------
create the department_staff table fromt he relation

department_staff (DeptNum, StaffID)
  PK = DeptNum, StaffID

- department_staff(DeptNum) mei department(DeptNum)
- department_staff(StaffID) mei staff(StaffID)
--------------------------------------------------------------------------------- */
create table department_staff(
  DeptNum tinyint unsigned,
  StaffID smallint unsigned,
  constraint department_staff_DeptNum_fk foreign key (DeptNum) references department(DeptNum),
  constraint department_staff_StaffID_fk foreign key (StaffID) references staff(StaffID),
  constraint department_staff_pk primary key (DeptNum, StaffID)
);

describe department_staff;

/* ---------------------------------------------------------------------------------
Create the support_staff table from the relation

support_staff (Support_StaffID, Wage)
  PK = Support_StaffID

- support_staff(Support_StaffID) mei staff(StaffID)
- wage should be in the format of ##.##. A value is required.
--------------------------------------------------------------------------------- */
create table support_staff(
  Support_StaffID smallint unsigned,
  wage decimal(4,2) not null,
  constraint support_staff_Support_StaffID_fk foreign key (Support_StaffID) references staff(StaffID),
  constraint support_staff_pk primary key (Support_StaffID)
);

describe support_staff;

/* ---------------------------------------------------------------------------------
Create the nurse table from the relation

nurse (NurseID, Certification)
  PK = NurseID

- nurse(NurseID) mei staff(StaffID)
- certification should allow only the values of 'LPN', 'RN', and 'APRN'. A value
  is required.
--------------------------------------------------------------------------------- */
create table nurse(
  NurseID smallint unsigned,
  Certification enum ('LPN', 'RN', 'APRN') not null,
  constraint nurse_NurseID_fk foreign key (NurseID) references staff(StaffID),
  constraint nurse_pk primary key (NurseID)
);

describe nurse;

/* ---------------------------------------------------------------------------------
Create the doctor table from the relation

doctor (DoctorID, MentorID)
  PK = DoctorID

- doctor(DoctorID) mei staff(StaffID)
- doctor(MentorID) mei doctor(DoctorID)
--------------------------------------------------------------------------------- */
create table doctor(
  DoctorID smallint unsigned,
  MentorID smallint unsigned,
  constraint doctor_DoctorID_fk foreign key (DoctorID) references staff(StaffID),
  constraint doctor_MentorID_fk foreign key (MentorID) references doctor(DoctorID),
  constraint doctor_pk primary key (DoctorID)
);

describe doctor;

/* ---------------------------------------------------------------------------------
Create the patient table from the relation

patient (PatientID, DoctorID)
  PK = Patient ID

- patient(PatientID) must exist in person(PersonID)
- patient(DoctorID) must exist in doctor(DoctorID)
--------------------------------------------------------------------------------- */
create table patient(
  PatientID smallint unsigned,
  DoctorID smallint unsigned,
  constraint patient_PatientID_fk foreign key (PatientID) references person(PersonID),
  constraint patient_DoctorID_fk foreign key (DoctorID) references doctor(DoctorID),
  constraint patient_pk primary key (PatientID)
);

describe patient;

/* ---------------------------------------------------------------------------------
Create the insurance_policy table from the relation

insurance_policy (PolicyNum, PatientID, InsCoID)
  PK = PolicyNum, PatientID, InsCoID

- insurance_policy(PatientID) mei patient(PatientID)
- insurance_policy(InsCoID) mei insurance_company(CoID)
- PolicyNum should allow between 0 and 25 characters to be stored.
--------------------------------------------------------------------------------- */
create table insurance_policy(
  PolicyNum varchar(25),
  PatientID smallint unsigned,
  InsCoID smallint unsigned,
  constraint insurance_policy_PatientID_fk foreign key (PatientID) references patient(PatientID),
  constraint insurance_policy_InsCoID_fk foreign key (InsCoID) references insurance_company(CoID),
  constraint insurance_policy_pk primary key (PolicyNum, PatientID, InsCoID)
);

describe insurance_policy;


/* ---------------------------------------------------------------------------------

--------------------------------------------------------------------------------- */
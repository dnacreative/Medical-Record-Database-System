DROP TABLE IF EXISTS Patient CASCADE;
DROP TABLE IF EXISTS Doctor CASCADE;
DROP TABLE IF EXISTS Pharmacist CASCADE;
DROP TABLE IF EXISTS Student CASCADE;
DROP TABLE IF EXISTS Employee CASCADE;
DROP TABLE IF EXISTS Faculty CASCADE;
DROP TABLE IF EXISTS Staff CASCADE;
DROP TABLE IF EXISTS Dependent CASCADE;
DROP TABLE IF EXISTS Std_phone CASCADE;
DROP TABLE IF EXISTS Emp_phone CASCADE;
DROP TABLE IF EXISTS Depends_on CASCADE;
DROP TABLE IF EXISTS Prescription CASCADE;
DROP TABLE IF EXISTS Temp_Prescription CASCADE;
DROP TABLE IF EXISTS Medicine CASCADE;
DROP TABLE IF EXISTS Suggested_med CASCADE;
DROP TABLE IF EXISTS Temp_Suggested_med CASCADE;
DROP TABLE IF EXISTS Pres_Disease CASCADE;
DROP TABLE IF EXISTS Med_salts CASCADE;
DROP TABLE IF EXISTS Pha_phone CASCADE;
DROP TABLE IF EXISTS Doc_phone CASCADE;
DROP TABLE IF EXISTS Updates CASCADE;
DROP TABLE IF EXISTS Stock CASCADE;
DROP TABLE IF EXISTS Schedule CASCADE;
DROP TABLE IF EXISTS Test_result CASCADE;
DROP TABLE IF EXISTS Pat_password CASCADE;
DROP TABLE IF EXISTS Temp_Suggested_med CASCADE;
DROP TABLE IF EXISTS Temp_Prescription CASCADE;
DROP TYPE IF EXISTS day CASCADE;

CREATE TABLE Patient 
(
id_pat varchar(30) primary key,
name varchar(30) not null,
gender varchar(10) not null,
date_of_birth date not null,
check( gender in ('male' ,'female') )
);

CREATE TABLE Doctor(

id_doc varchar(30) primary key,
name varchar(30) not null,
qualification varchar(30) not null,
field varchar(30) not null,
house_no varchar(50) ,
city varchar(15),
state varchar(15),
pin_code numeric(6,0),
joining_date date not null

);

CREATE TABLE Pharmacist(

id_pha varchar(30) primary key,
name varchar(30) not null,
qualification varchar(30) not null,
house_no varchar(50) ,
city varchar(30),
state varchar(30),
pin_code numeric(6,0),
joining_date date not null
);

CREATE TABLE Student(

id_std varchar(30) primary key,
entry_no varchar(15) not null,
hostel_name varchar(15) not null,
room_no varchar(10) not null,
gaurdian_name varchar(30) not null,
gaurdian_phone varchar(15) not null,
house_no varchar(50) ,
city varchar(15),
state varchar(15),
pin_code numeric(6,0),
foreign key (id_std) references Patient(id_pat) on delete cascade on update cascade

);
CREATE TABLE Employee(

id_emp varchar(30) primary key,
house_no varchar(50) ,
city varchar(15),
state varchar(15),
pin_code numeric(6,0),
foreign key (id_emp) references Patient(id_pat) on delete cascade on update cascade


);
CREATE TABLE Faculty(

id_fac varchar(30) primary key,
department varchar(30) not null,
foreign key (id_fac) references Employee(id_emp) on delete cascade on update cascade

);
CREATE TABLE Staff(

id_fac varchar(30) primary key,
position varchar(30) not null,
foreign key (id_fac) references Employee(id_emp) on delete cascade on update cascade

);
CREATE TABLE Dependent(

id_dep varchar(30) primary key,
relation varchar(20) not null

);
CREATE TABLE Depends_on(

id_dep varchar(30),
id_fac varchar(30),
primary key(id_dep,id_fac),
foreign key(id_fac) references Faculty(id_fac) on delete cascade on update cascade
);


CREATE TABLE Prescription(
id_doc varchar(30),
id_pat varchar(30),
id_pha varchar(30),
time_stamp timestamp,
description varchar(50),
medical_cert bytea,
primary key(id_doc,id_pat,id_pha,time_stamp),
foreign key (id_doc) references Doctor(id_doc) on delete cascade on update cascade,
foreign key (id_pat) references Patient(id_pat) on delete cascade on update cascade,
foreign key (id_pha) references Pharmacist(id_pha) on delete cascade on update cascade
);

CREATE TABLE Temp_Prescription(
id_doc varchar(30),
id_pat varchar(30),
time_stamp timestamp,
description varchar(50),
status smallint,
primary key(id_doc,id_pat,time_stamp),
foreign key (id_doc) references Doctor(id_doc) on delete cascade on update cascade,
foreign key (id_pat) references Patient(id_pat) on delete cascade on update cascade
);



CREATE TABLE Medicine(

name varchar(30),
dose int ,
primary key (name,dose)

);

CREATE TABLE Suggested_med(

id_doc varchar(30),
id_pat varchar(30),
id_pha varchar(30),
name varchar(30),
dose int ,
quantity int ,
time_stamp timestamp,
primary key(id_doc,id_pat,id_pha,name,dose,time_stamp),
foreign key (id_doc,id_pat,id_pha,time_stamp) references Prescription(id_doc,id_pat,id_pha,time_stamp) on delete cascade on update cascade,
foreign key (name,dose) references Medicine(name,dose) on delete cascade on update cascade

);

CREATE TABLE Temp_Suggested_med(

id_doc varchar(30),
id_pat varchar(30),
name varchar(30),
dose int ,
quantity int,
time_stamp timestamp,
primary key(id_doc,id_pat,name,dose,time_stamp),
foreign key (id_doc,id_pat,time_stamp) references Temp_Prescription(id_doc,id_pat,time_stamp) on delete cascade on update cascade,
foreign key (name,dose) references Medicine(name,dose) on delete cascade on update cascade

);


CREATE TABLE Test_result(
indx serial,
id_doc varchar(30),
id_pat varchar(30),
id_pha varchar(30),
time_stamp timestamp,
test_result bytea,
primary key(id_doc,id_pat,id_pha,time_stamp,indx),
foreign key(id_doc,id_pat,id_pha,time_stamp) references Prescription(id_doc,id_pat,id_pha,time_stamp) on delete cascade on update cascade

);
CREATE TABLE Pres_Disease(

id_doc varchar(30),
id_pat varchar(30),
id_pha varchar(30),
time_stamp timestamp,
disease varchar(30),
primary key(id_doc,id_pat,id_pha,time_stamp,disease),
foreign key(id_doc,id_pat,id_pha,time_stamp) references Prescription(id_doc,id_pat,id_pha,time_stamp) on delete cascade on update cascade

);
CREATE TABLE Med_salts(

name varchar(30),
dose int ,
salt varchar(50),
primary key(name,dose,salt),
foreign key(name, dose) references Medicine(name, dose) on delete cascade on update cascade

);
CREATE TABLE Stock(

name varchar(30),
dose int ,
expiry_date date,
quantity int,
primary key(name,dose,expiry_date),
foreign key(name, dose) references Medicine(name, dose) on delete cascade on update cascade


);
CREATE TABLE Updates(

id_pha varchar(30),
name varchar(30),
dose int ,
expiry_date date,
time_stamp timestamp,
add_quantity int not null,
primary key(id_pha,name,dose,expiry_date,time_stamp),
foreign key(id_pha) references Pharmacist(id_pha) on delete cascade on update cascade,
foreign key(name, dose,expiry_date) references Stock(name, dose, expiry_date) on delete cascade on update cascade


);
CREATE TABLE Doc_phone(

id_doc varchar(30),
phone_no varchar(15),
primary key(id_doc,phone_no),
foreign key (id_doc) references Doctor(id_doc) on delete cascade on update cascade

);
CREATE TABLE Emp_phone(

id_emp varchar(30),
phone_no varchar(15),
primary key(id_emp,phone_no),
foreign key (id_emp) references Employee(id_emp) on delete cascade on update cascade
);
CREATE TABLE Std_phone(

id_std varchar(30),
phone_no varchar(15),
primary key(id_std,phone_no),
foreign key (id_std) references Student(id_std) on delete cascade on update cascade

);
CREATE TABLE Pha_phone(
id_pha varchar(30),
phone_no varchar(15),
primary key(id_pha,phone_no),
foreign key (id_pha) references Pharmacist(id_pha) on delete cascade on update cascade
);

CREATE TYPE day AS ENUM ('Sunday','Monday', 'Tuesday', 'Wednesday','Thursday','Friday','Saturday');

CREATE TABLE Schedule(
id_doc varchar(30),
schedule_day day,
start_time time,
end_time time,
primary key(id_doc,schedule_day,start_time,end_time),
foreign key(id_doc) references Doctor(id_doc) on delete cascade on update cascade
);

CREATE TABLE Pat_Password(

id_pat varchar(30),
password varchar(15),
primary key(id_pat),
foreign key (id_pat) references Patient(id_pat) on delete cascade on update cascade
);

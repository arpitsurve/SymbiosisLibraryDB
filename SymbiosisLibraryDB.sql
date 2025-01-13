USE college;
CREATE TABLE student(
rollno INT PRIMARY KEY,
name VARCHAR(25),
marks INT NOT NULL,
grade VARCHAR(1),
city VARCHAR(15)
);

CREATE TABLE dept(
id INT PRIMARY KEY,
name VARCHAR(25)
);

INSERT INTO dept
VALUES
(101,"English"),
(102,"IT");

UPDATE dept 
SET id = 103
WHERE id = 102;

SELECT * FROM dept;

CREATE TABLE teacher(
id INT PRIMARY KEY,
name VARCHAR(25),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES dept(id)
ON DELETE CASCADE
ON UPDATE CASCADE
);
INSERT INTO teacher
VALUES
(101,"adam"),
(102,"eve");

INSERT INTO student
(rollno, name, marks, grade, city)
VALUES
(101, "Noosha", 91, "A", "Hyderabad"),
(102, "Bhumika", 78, "C", "Mumbai"),
(103, "chetan", 85, "B", "Mumbai"),
(104, "dhruv", 90, "A", "Delhi"),
(105, "emanuel", 12, "F", "Delhi"),
(106, "Farah", 82, "B", "Pune");

SELECT city, avg(marks)
FROM student
GROUP BY city
ORDER BY avg(marks)
DESC;

CREATE TABLE IF NOT EXISTS payments(
Cust_id INT PRIMARY KEY,
customer VARCHAR(25),
mode VARCHAR(20),
city VARCHAR(20)
);

INSERT INTO payments
VALUES
(101, "OLIVIA BARETT", "netbanking", "portland"),
(102, "ETHAN SINCLAIR", "credit card", "miami"),
(103, "MAYA HERNANDEZ ", "credit card", "seattle"),
(104, "LIAM DONOVAN", "netbanking", "denver"),
(105, "SOFIA NGUYEN", "credit card", "new orleans"),
(106, "CALEB FOSTER", "debit card", "minneapolis"),
(107, "AVA PATEL", "debit card", "pheonix"),
(108, "LUCAS CARTER", "netbanking", "boston"),
(109, "ISABELL MARTINEZ", "netbanking", "nashville"),
(110, "Jackson Brooks", "credit card", "Boston");

SELECT mode, count(mode)
FROM payments
GROUP BY mode;

SELECT city, count(rollno)
FROM student
GROUP BY city
HAVING max(marks >= 90);

SET SQL_SAFE_UPDATES = 1;

UPDATE student
SET grade = "O"
WHERE grade = "A";
SELECT * FROM student;

------------------------------------------------------------------------------------------------------------------------------

CREATE DATABASE SIUlibrary;
USE SIUlibrary;
CREATE TABLE SIU_library(
Slid INT PRIMARY KEY,
lname VARCHAR(50),
location VARCHAR(25),
no_of_branches INT NOT NULL
);
INSERT INTO siu_library
VALUE
(1, "Pune Central library", "Pune", 10);

CREATE TABLE IF NOT EXISTS I_library(
Iid INT PRIMARY KEY,
lname VARCHAR(50),
city VARCHAR(15),
area VARCHAR(20),
Slid INT,
FOREIGN KEY (Slid) REFERENCES SIU_library(Slid)
);
CREATE TABLE IF NOT EXISTS a_specialization(
spec_id INT PRIMARY KEY,
spec_name VARCHAR(50)
);
CREATE TABLE IF NOT EXISTS author(
aid INT PRIMARY KEY,
aname VARCHAR(20),
email VARCHAR(25),
phoneno INT NOT NULL,
spec_id INT,
FOREIGN KEY (spec_id) REFERENCES a_specialization(spec_id)
);
CREATE TABLE IF NOT EXISTS department(
depid INT PRIMARY KEY,
dname VARCHAR(15),
Iid INT,
FOREIGN KEY(Iid) REFERENCES I_library(Iid)
);
CREATE TABLE IF NOT EXISTS memeber(
memid INT PRIMARY KEY,
Iid INT,
FOREIGN KEY(Iid) REFERENCES I_library(Iid)
);
CREATE TABLE IF NOT EXISTS books(
bid INT PRIMARY KEY,
bname VARCHAR(50),
price INT,
Iid INT,
FOREIGN KEY(Iid) REFERENCES I_library(Iid)
);
CREATE TABLE IF NOT EXISTS publisher(
pid INT PRIMARY KEY,
pname VARCHAR(25),
bid INT,
FOREIGN KEY (bid) REFERENCES books(bid)
);
CREATE TABLE IF NOT EXISTS writes(
aid INT PRIMARY KEY,
bid INT,
FOREIGN KEY (bid) REFERENCES books(bid),
pid INT,
FOREIGN KEY (pid) REFERENCES publisher(pid)
);
CREATE TABLE IF NOT EXISTS seller(
sid INT PRIMARY KEY,
sname VARCHAR(25),
city VARCHAR(25)
);
CREATE TABLE IF NOT EXISTS sold_by(
sid int,
FOREIGN KEY (sid) REFERENCES seller(sid),
bid int,
FOREIGN KEY (bid) REFERENCES books(bid)
);
CREATE TABLE IF NOT EXISTS no_of_copies(
bnid INT PRIMARY KEY,
bid int,
FOREIGN KEY (bid) REFERENCES books(bid),
bl_id INT
);
CREATE TABLE IF NOT EXISTS issue(
issid INT PRIMARY KEY,
memid INT,
FOREIGN KEY (memid) REFERENCES memeber(memid),
bnid INT,
FOREIGN KEY(bnid) REFERENCES no_of_copies(bnid),
Iid INT,
FOREIGN KEY(Iid) REFERENCES I_library(Iid),
issue_date DATE,
return_date DATE
);
CREATE TABLE IF NOT EXISTS purchase(
purid INT PRIMARY KEY,
Iid int,
FOREIGN KEY(Iid) REFERENCES I_library(Iid),
sid int,
FOREIGN KEY (sid) REFERENCES seller(sid),
bid INT,
FOREIGN KEY (bid) REFERENCES books(bid),
quantity INT,
pdate DATE,
total_cost INT
);
CREATE TABLE IF NOT EXISTS employee(
eid INT PRIMARY KEY,
emp_name VARCHAR(25),
email VARCHAR(35),
salary INT,
Iid INT,
FOREIGN KEY (Iid) REFERENCES I_library(Iid),
depid INT,
FOREIGN KEY (depid) REFERENCES department(depid)
);
CREATE TABLE IF NOT EXISTS staff(
sta_id INT PRIMARY KEY,
memid INT,
FOREIGN KEY (memid) REFERENCES memeber(memid),
sname VARCHAR(25),
email VARCHAR(35),
depid INT,
FOREIGN KEY (depid) REFERENCES department(depid)
);
CREATE TABLE IF NOT EXISTS SIUstudent(
stid INT PRIMARY KEY,
memid INT,
FOREIGN KEY (memid) REFERENCES memeber(memid),
stuname VARCHAR(25),
email VARCHAR(35),
depid INT,
FOREIGN KEY (depid) REFERENCES department(depid)
);
SELECT *
FROM books;

INSERT INTO i_library
VALUES
(1, 'SITLib', 'Pune', 'Lavale', 1),
(2, 'SIBMLib', 'Pune', 'Lavale', 1),
(3, 'SSACLib', 'Nagpur', 'Ramnagar', 1),
(4, 'SSLALib', 'Pune', 'Vimannagar', 1),
(5, 'SIBMBLib', 'Bangalore', 'Jaynagar', 1),
(6, 'SITMHLib', 'Hyderabad', 'Banjara hills', 1),
(7, 'SIOMLib', 'Pune', 'S.B.Road', 1),
(8, 'SITMNLib', 'Noida', 'Golf course area', 1),
(9, 'SSLAHLib', 'Hyderabad', 'Gacchibowli', 1),
(10, 'SSBSLib', 'Pune', 'Tithnagar', 1);

INSERT INTO books VALUES
(1, 'Operating System', 1000, 1),
(2, 'Management System', 2500, 2),
(3, 'Supply chain management', 500, 8),
(4, 'Bioinformatics', 780, 10),
(5, 'Tele informatics', 4567, 10),
(6, 'IP and Patents formation', 345, 4),
(7, 'Engineering Graphics', 2456, 1),
(8, 'Customer Management', 3467, 5),
(9, 'Buying Pattern Analysis', 456, 8),
(10, 'Digital Finance', 600, 8),
(11, 'Telecommunication', 1500, 6),
(12, 'Algorithms', 6754, 1),
(13, 'Child Law', 1800, 4),
(14, 'Multimanagers', 2345, 2),
(15, 'MicroEconomics', 267, 5),
(16, 'Electronics', 2341, 1),
(17, 'Structure foundations', 1700, 3),
(18, 'Ecohomes', 1234, 3),
(19, 'Mobile Communication', 456, 6),
(20, 'Labor Laws', 3452, 9),
(21, 'Copyrights', 2789, 9),
(22, 'Research Laws', 1100, 9),
(23, 'DBMS', 700, 1),
(24, 'Computer networks', 3451, 1);

SELECT *
FROM a_specialization;

INSERT INTO author
VALUES
(1, 'Shruti', 'abc@gmail.com', '6447896',"101"),
(2, 'Shivam Kapoor', 'adf@gmail.com', '2345778',"201"),
(3, 'Ameya', 'ert@gmail.com', '23456789',"301"),
(4, 'Pooja Pai', 'edr@gamil.com', '32554565',"401"),
(5, 'Brian Kernighan', 'rtyu@gmail.com', '2143454',"501"),
(6, 'Ken Thompson', 'errt@gmail.com', '2343454',"601");

INSERT INTO a_specialization VALUES
(101, 'Technical'),
(201, 'Fiction'),
(301, 'Non_Fiction'),
(401, 'Autobiographies'),
(501, 'Technical'),
(601, 'Real life stories');

INSERT INTO writes 
VALUES --parat kar
(1, 1, 2),
(2, 2, 3),
(3, 5, 2),
(4, 6, 4),
(5, 1, 5),
(6, 1, 2),
(7, 4, 1),
(8, 2, 2),
(9, 5, 5),
(10, 6, 4),
(11, 1, 1),
(12, 4, 2),
(13, 5, 5),
(14, 6, 2),
(15, 3, 1),
(16, 4, 2),
(17, 6, 5),
(18, 2, 4),
(19, 5, 1),
(20, 1, 2),
(21, 3, 5),
(22, 5, 2),
(23, 6, 1),
(24, 3, 3);

INSERT INTO publisher 
VALUES -- parat kar
(1, 'Tata Macgraw hill'),
(2, 'Pragati book store'),
(3, 'Prentice Hall'),
(4, 'oReilly'),
(5, 'Emrald publishing');

INSERT INTO Seller 
VALUES
(1, 'Kohinoor', 'Pune'),
(2, 'Shiksha', 'Pune'),
(3, 'ABP', 'Noida'),
(4, 'Technical', 'Hyderabad'),
(5, 'Timenowta', 'Bangalore'),
(6, 'Kirti', 'Pune');

INSERT INTO department
VALUES -- PARAT KAR
(1, 'Civil', 'SIT', 1),
(2, 'E&TC', 'SIT', 1),
(3, 'Biology', 'SSBS', 10),
(4, 'Law', 'SSLA', 4),
(5, 'Structure', 'SSAC', 3),
(6, 'Finance management', 'SIBM', 2),
(7, 'Digital Telecommunications', 'SITMH', 6),
(8, 'Clinical Research', 'SSBS', 10);

INSERT INTO siustudent VALUES -- parat kar
(1, 1, 'Pooja', 'aswq@gmail.com',  1),
(2, 16,'Satish', 'azsx@gmail.com', 1),
(3, 13, 'Amar', 'cvnn@gmail.com',  2),
(4, 44, 'Meera', 'lkio@gmail.com',  2),
(5, 35, 'Ravi', 'fghj@gmail.com',  2),
(6, 26, 'Adit', 'cfgb@gmail.com',  3);

INSERT INTO memeber VALUES
(1, 1),
(16, 1),
(13, 1),
(44, 1),
(35, 1),
(26, 10),
(45, 1),
(23, 10),
(12, 3),
(78, 1),
(49, 4),
(50, 1);

INSERT INTO Staff VALUES -- parat kar
(1, 45, 'Satish', 'sddf@gmail.com',1),
(2, 23, 'Rachit', 'zxzxc@gmail.com',3),
(3, 12, 'Seema', 'lkklk@gmail.com',5),
(4, 78, 'Sayali', 'xzcxc@gmail.com',2),
(5, 49,  'Aditya', 'cvvcb@gmail.com',4),
(6, 50,  'Archit', 'gfdfg@gmail.com',1);

INSERT INTO Purchase VALUES -- parat kar
(1001, 1, 1, 3, 1, 100, '2015-07-12', 70000),
(1002, 2, 3, 4, 2, 1000, '2015-04-10', 80000),
(1003, 1, 4, 2, 5, 45, '2016-08-01', 4500),
(1004, 4, 1, 5, 6, 34, '2016-02-06', 23000),
(1005, 3, 4, 1, 9, 20, '2017-03-15', 1200),
(1006, 1, 2, 4, 10, 89, '2017-04-20', 4500),
(1007, 2, 5, 2, 12, 67, '2018-07-25', 5600),
(1008, 3, 2, 4, 15, 45, '2018-03-27', 50000),
(1009, 4, 3, 1, 16, 340, '2019-02-12', 7800),
(1010, 1, 1, 2, 17, 23, '2020-07-11', 10000);
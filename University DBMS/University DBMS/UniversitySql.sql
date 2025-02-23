
#Entities
CREATE TABLE Role (
  Role_ID INT PRIMARY KEY AUTO_INCREMENT,
  role_name VARCHAR(50),
  description TEXT,
  created_at DATETIME,
  updated_at DATETIME
);
CREATE TABLE Permissions (
  Permission_ID INT PRIMARY KEY AUTO_INCREMENT,
  permission_name VARCHAR(50),
  description TEXT,
  created_at DATETIME,
  updated_at DATETIME
);
CREATE TABLE Role_Permissions (
  Role_ID INT,
  Permission_ID INT,
  PRIMARY KEY (Role_ID, Permission_ID),
  FOREIGN KEY (Role_ID) REFERENCES Role(Role_ID),
  FOREIGN KEY (Permission_ID) REFERENCES Permissions(Permission_ID)
);
CREATE TABLE Faculty (
  Faculty_ID INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  dean VARCHAR(100),
  created_at DATETIME,
  updated_at DATETIME
);
CREATE TABLE Department (
  Department_ID INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  faculty_id INT,
  budget DECIMAL(15, 2),
  FOREIGN KEY (faculty_id) REFERENCES Faculty(Faculty_ID)
);
CREATE TABLE Student (
  Student_ID INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  email VARCHAR(100) UNIQUE,
  password VARCHAR(255),
  date_of_birth DATE,
  level INT,
  cgpa DECIMAL(3, 2),
  major_department_id INT,
  minor_department_id INT,
  role_id INT,
  status VARCHAR(50),
  created_at DATETIME,
  updated_at DATETIME,
  FOREIGN KEY (major_department_id) REFERENCES Department(Department_ID),
  FOREIGN KEY (minor_department_id) REFERENCES Department(Department_ID),
  FOREIGN KEY (role_id) REFERENCES Role(Role_ID)
);
CREATE TABLE Activities (
  Activity_ID INT PRIMARY KEY AUTO_INCREMENT,
  activity_name VARCHAR(100),
  description TEXT,
  created_at DATETIME,
  updated_at DATETIME
);
CREATE TABLE Student_Activities (
  Student_ID INT,
  Activity_ID INT,
  participation_date DATE,
  PRIMARY KEY (Student_ID, Activity_ID),
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Activity_ID) REFERENCES Activities(Activity_ID)
);
CREATE TABLE Library (
  Library_ID INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  location VARCHAR(255),
  status VARCHAR(50),
  created_at DATETIME,
  updated_at DATETIME
);
CREATE TABLE Books (
  Book_ID INT PRIMARY KEY AUTO_INCREMENT,
  title VARCHAR(200),
  author VARCHAR(100),
  publication_year INT,
  genre VARCHAR(50),
  Library_ID INT,
  status VARCHAR(50),
  created_at DATETIME,
  updated_at DATETIME,
  FOREIGN KEY (Library_ID) REFERENCES Library(Library_ID)
);
CREATE TABLE Borrow (
  Borrow_ID INT PRIMARY KEY AUTO_INCREMENT,
  Student_ID INT,
  Book_ID INT,
  borrow_date DATE,
  return_date DATE,
  created_at DATETIME,
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Book_ID) REFERENCES Books(Book_ID)
);
CREATE TABLE Lecturer(
  Lecturer_ID INT PRIMARY KEY AUTO_INCREMENT,
  name varchar(32),
  email varchar(32),
  specialization VARCHAR(50),
  department_id INT,
  role_id INT,
  FOREIGN KEY (role_id) REFERENCES Role(Role_ID),
  FOREIGN KEY (department_id) REFERENCES Department(Department_ID)
);
CREATE TABLE Course (
  Course_ID INT PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(100),
  credits INT,
  level INT,
  department_id INT,
  status VARCHAR(50),
  lecturer_id INT ,
  created_at DATETIME,
  updated_at DATETIME,
  FOREIGN KEY (department_id) REFERENCES Department(Department_ID),
  FOREIGN KEY (lecturer_id) REFERENCES Lecturer(Lecturer_ID)
);
CREATE TABLE Enrollment (
  Enrollment_ID INT PRIMARY KEY AUTO_INCREMENT,
  Student_ID INT,
  Course_ID INT,
  enrollment_date DATE,
  grade DECIMAL(4, 2),
  created_at DATETIME,
  FOREIGN KEY (Student_ID) REFERENCES Student(Student_ID),
  FOREIGN KEY (Course_ID) REFERENCES Course(Course_ID)
);
CREATE TABLE Exams ( 
  Exam_ID INT PRIMARY KEY AUTO_INCREMENT,
  exam_name VARCHAR(100),
  course_id INT,
  lecturer_id INT,
  exam_date DATE,
  exam_duration TIME,
  exam_type VARCHAR(50),
  created_at DATETIME,
  updated_at DATETIME,
  FOREIGN KEY (course_id) REFERENCES Course(Course_ID),
  FOREIGN KEY (lecturer_id) REFERENCES Lecturer(Lecturer_ID)
);
CREATE TABLE Exam_Results (
  Exam_Result_ID INT PRIMARY KEY AUTO_INCREMENT,
  exam_id INT,
  student_id INT,
  grade DECIMAL(5, 2),
  status VARCHAR(50),
  created_at DATETIME,
  updated_at DATETIME,
  FOREIGN KEY (exam_id) REFERENCES Exams(Exam_ID),
  FOREIGN KEY (student_id) REFERENCES Student(Student_ID)
);
#insertion
-- Insert into Role
INSERT INTO Role (role_name, description, created_at, updated_at)
VALUES 
('Admin', 'Administrator role', NOW(), NOW()),
('Student', 'Student role', NOW(), NOW()),
('Lecturer', 'Lecturer role', NOW(), NOW()),
('Guest', 'Guest role', NOW(), NOW());

-- Insert into Permissions
INSERT INTO Permissions (permission_name, description, created_at, updated_at)
VALUES 
('View', 'Permission to view', NOW(), NOW()),
('Edit', 'Permission to edit', NOW(), NOW()),
('Delete', 'Permission to delete', NOW(), NOW()),
('Create', 'Permission to create', NOW(), NOW());

-- Insert into Role_Permissions
INSERT INTO Role_Permissions (Role_ID, Permission_ID)
VALUES
(1, 1),
(1, 2),
(2, 1),
(3, 3);

-- Insert into Faculty
INSERT INTO Faculty (name, dean, created_at, updated_at)
VALUES 
('Engineering', 'Dr. Smith', NOW(), NOW()),
('Arts', 'Dr. Johnson', NOW(), NOW()),
('Science', 'Dr. Taylor', NOW(), NOW()),
('Medicine', 'Dr. Lee', NOW(), NOW());
-- Insert into Department
INSERT INTO Department (name, faculty_id, budget)
VALUES 
('Computer Science', 1, 500000.00),
('Physics', 3, 300000.00),
('Literature', 2, 200000.00),
('Biology', 3, 400000.00);
-- Insert into Student
INSERT INTO Student (name, email, password, date_of_birth, level, cgpa, major_department_id, minor_department_id, role_id, status, created_at, updated_at)
VALUES 
('Alice', 'alice@example.com', 'pass123', '2000-01-01', 1, 3.5, 1, NULL, 2, 'Active', NOW(), NOW()),
('Bob', 'bob@example.com', 'pass123', '1999-05-15', 2, 3.7, 2, NULL, 2, 'Active', NOW(), NOW()),
('Charlie', 'charlie@example.com', 'pass123', '2001-09-10', 1, 3.2, 3, NULL, 2, 'Active', NOW(), NOW()),
('Diana', 'diana@example.com', 'pass123', '2002-03-20', 1, 3.8, 4, NULL, 2, 'Active', NOW(), NOW());
-- Insert into Activities
INSERT INTO Activities (activity_name, description, created_at, updated_at)
VALUES
('Hackathon', 'Annual Coding Competition', NOW(), NOW()),
('Art Exhibition', 'Displaying student artworks', NOW(), NOW()),
('Science Fair', 'Showcasing science projects', NOW(), NOW()),
('Music Festival', 'Annual music event', NOW(), NOW());
-- Insert into Student_Activities
INSERT INTO Student_Activities (Student_ID, Activity_ID, participation_date)
VALUES
(1, 1, '2024-02-20'),
(2, 2, '2024-03-15'),
(3, 3, '2024-04-10'),
(4, 4, '2024-05-05');
-- Insert into Library
INSERT INTO Library (name, location, status, created_at, updated_at)
VALUES
('Central Library', 'Main Campus', 'Open', NOW(), NOW()),
('Science Library', 'Science Building', 'Open', NOW(), NOW()),
('Arts Library', 'Arts Wing', 'Closed', NOW(), NOW()),
('Engineering Library', 'Engineering Block', 'Open', NOW(), NOW());
-- Insert into Books
INSERT INTO Books (title, author, publication_year, genre, Library_ID, status, created_at, updated_at)
VALUES
('Introduction to Algorithms', 'Thomas H. Cormen', 2009, 'Educational', 1, 'Available', NOW(), NOW()),
('The Great Gatsby', 'F. Scott Fitzgerald', 1925, 'Fiction', 2, 'Checked Out', NOW(), NOW()),
('Physics for Scientists and Engineers', 'Raymond A. Serway', 2018, 'Science', 1, 'Available', NOW(), NOW()),
('Biology Concepts and Connections', 'Neil A. Campbell', 2017, 'Science', 2, 'Available', NOW(), NOW());
-- Insert into Borrow
INSERT INTO Borrow (Student_ID, Book_ID, borrow_date, return_date, created_at)
VALUES
(1, 1, '2024-06-01', '2024-06-15', NOW()),
(2, 2, '2024-06-05', '2024-06-20', NOW()),
(3, 3, '2024-06-10', '2024-06-25', NOW()),
(4, 4, '2024-06-15', '2024-06-30', NOW());
-- Insert into Lecturer
INSERT INTO Lecturer (name, email, specialization, department_id, role_id)
VALUES
('Dr. Smith', 'smith@university.edu', 'Computer Science', 1, 3),
('Dr. Johnson', 'johnson@university.edu', 'Physics', 2, 3),
('Dr. Taylor', 'taylor@university.edu', 'Literature', 3, 3),
('Dr. Lee', 'lee@university.edu', 'Biology', 4, 3);
-- Insert into Course
INSERT INTO Course (name, credits, level, department_id, status, created_at, updated_at)
VALUES 
('Data Structures', 3, 1, 1, 'Active', NOW(), NOW()),
('Thermodynamics', 4, 2, 2, 'Active', NOW(), NOW()),
('Shakespeare Studies', 3, 1, 3, 'Active', NOW(), NOW()),
('Cell Biology', 4, 2, 4, 'Active', NOW(), NOW());

-- Insert into Enrollment
INSERT INTO Enrollment (Student_ID, Course_ID, enrollment_date, grade, created_at)
VALUES
(1, 1, '2024-01-15', 85.00, NOW()),
(2, 2, '2024-01-16', 90.00, NOW()),
(3, 3, '2024-01-17', 75.00, NOW()),
(4, 4, '2024-01-18', 88.00, NOW());
-- Insert into Exams
INSERT INTO Exams (exam_name, course_id, lecturer_id, exam_date, exam_duration, exam_type, created_at, updated_at)
VALUES
('Midterm Exam - Data Structures', 1, 1, '2024-03-10', '02:00:00', 'Written', NOW(), NOW()),
('Final Exam - Thermodynamics', 2, 2, '2024-06-20', '03:00:00', 'Written', NOW(), NOW()),
('Quiz - Shakespeare Studies', 3, 3, '2024-02-15', '00:30:00', 'MCQ', NOW(), NOW()),
('Lab Exam - Cell Biology', 4, 4, '2024-04-25', '01:30:00', 'Practical', NOW(), NOW());
-- Insert into Exam_Results
INSERT INTO Exam_Results (exam_id, student_id, grade, status, created_at, updated_at)
VALUES
(1, 1, 85.00, 'Passed', NOW(), NOW()),
(2, 2, 90.00, 'Passed', NOW(), NOW()),
(3, 3, 78.00, 'Passed', NOW(), NOW()),
(4, 4, 88.00, 'Passed', NOW(), NOW());




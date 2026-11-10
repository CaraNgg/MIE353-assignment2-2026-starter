--8. For each student and each department in which the student has taken at least two
--courses with different course numbers, compare the student’s grade in their lowestlevel course in that 
--department with their grade in their highest-level course in that
--department. A course is higher-level if it has a higher course number within its department (MIE353
--is higher than MIE250), and graduate courses are higher-level than all
--undergraduate and 500-level courses. If several courses share the same course number,
--use the one with the higher grade. Your result should consist of four columns: the
--student’s full name, the department code, the (lowest, highest) pair of courses, and the
--(lowest, highest) pair of grades for those courses. Be sure to list all student–department
--combinations that qualify.

-- students full name, department code, (lowest, highest) pair of courses, (lowest, highest) grades
-- department, ece, civ, mie, edm

-- select full name, code

CREATE TABLE courseDepartment AS
SELECT courseId, courseName, LEFT(courseId, 3) AS department
FROM course;

COPY (
    SELECT student.firstName || ' ' || student.lastName AS fullName,
    coursedepartment.department, 


) TO 'src/main/resources/data/output/query8.csv' (HEADER, DELIMITER ',');
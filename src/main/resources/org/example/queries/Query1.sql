--1. How many students received a grade of 80 or above in mie301h1f?

COPY (
    SELECT COUNT(DISTINCT studentId) as numStudents
    FROM transcript
    WHERE UPPER(courseId) = 'MIE301H1F' AND grade >= 80
) TO 'src/main/resources/data/output/query1.csv' (HEADER, DELIMITER ',');
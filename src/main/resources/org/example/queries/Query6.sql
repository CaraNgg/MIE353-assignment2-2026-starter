-- 6. List all the students (full names) who have taken a course named “Data Modelling”
--and received a grade of 90 or above in at least one course not named “Data Modelling”.

COPY (
    SELECT DISTINCT student.firstName || ' ' || student.lastName as fullName
    FROM student
    WHERE student.studentId IN (
        SELECT transcript.studentID
        FROM transcript
        JOIN course ON transcript.courseId = course.courseId
        WHERE courseName = 'Data Modelling'
    )
    AND student.studentID IN(
        SELECT transcript.studentId
        FROM transcript
        JOIN course ON transcript.courseId = course.courseId
        WHERE courseName <> 'Data Modelling' AND grade >= 90
    )
    
) TO 'src/main/resources/data/output/query6.csv' (HEADER, DELIMITER ',');
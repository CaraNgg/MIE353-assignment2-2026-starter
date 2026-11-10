-- 4. What are the full names of all professors who have taught at least one course taken by Rebecca Ward?

COPY (
    SELECT DISTINCT professor.firstName || ' ' || professor.lastName as fullName
    FROM professor
    JOIN teaches ON professor.profId = teaches.profId
    JOIN transcript ON teaches.courseId = transcript.courseId
    JOIN student ON transcript.studentId = student.studentId
    WHERE student.firstName = 'Rebecca' AND student.lastName = 'Ward'

) TO 'src/main/resources/data/output/query4.csv' (HEADER, DELIMITER ',');
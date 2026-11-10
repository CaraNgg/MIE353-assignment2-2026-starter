-- 3. What are the full names3 of professors teaching exactly one course?

COPY (
    SELECT professor.firstName || ' ' || professor.lastName AS fullName
    FROM professor
    JOIN teaches ON professor.profId = teaches.profId
    GROUP BY professor.profId, professor.firstName, professor.lastName
    HAVING COUNT(DISTINCT teaches.courseId) = 1
) TO 'src/main/resources/data/output/query3.csv' (HEADER, DELIMITER ',');
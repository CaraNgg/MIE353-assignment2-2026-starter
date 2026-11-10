-- 5. Which professors (full names) who teach at least one course have never given a failing grade in any of their 
--courses? (A failing grade is 49 or below).

COPY (
    SELECT DISTINCT professor.firstName || ' ' || professor.lastName as fullName
    FROM professor
    JOIN teaches ON professor.profId = teaches.profId
    WHERE professor.profId NOT IN (
        SELECT teaches.profId
        FROM teaches
        JOIN transcript ON teaches.courseID = transcript.courseID
        WHERE transcript.grade <= 49
    )
    
) TO 'src/main/resources/data/output/query5.csv' (HEADER, DELIMITER ',');
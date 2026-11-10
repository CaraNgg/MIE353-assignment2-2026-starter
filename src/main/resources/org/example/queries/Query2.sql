--2. What are all the names of fourth-year courses? (fourth-year courses have a number code beginning with 4 after their department code)

COPY (
    SELECT courseName AS fourthYearCourses
    FROM course
    WHERE courseId LIKE '___4%'
) TO 'src/main/resources/data/output/query2.csv' (HEADER, DELIMITER ',');
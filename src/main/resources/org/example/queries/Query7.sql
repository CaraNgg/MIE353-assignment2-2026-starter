-- 7. Find all pairs of students who have taken at least three courses in common. For each
-- pair, list both students’ full names (as two columns, each pair listed only once), the
-- number of courses they have in common, and each student’s average grade across those
-- shared courses.

-- full names, # courses in common, avg grade across those shared courses
-- fullName1, fullName1, coursesInCommon, avgGrade1, avgGrade2

COPY (
    SELECT student1.firstName || ' ' || student1.lastName AS fullName1,
        student2.firstName || ' ' || student2.lastName as fullName2,
        COUNT(DISTINCT t1.courseId) as coursesInCommon,
        AVG(t1.grade) as avgGrade1,
        AVG(t2.grade) as avgGrade2
    FROM transcript t1
    JOIN transcript t2 ON t1.studentId < t2.studentId AND t1.courseId = t2.courseId -- find distinct pairs
    JOIN student student1 ON t1.studentId = student1.studentId
    JOIN student student2 ON t2.studentId = student2.studentId
    GROUP BY student1.firstName, student1.lastName, student1.studentId, student2.firstName, student2.lastName, student2.studentId
    HAVING COUNT(DISTINCT t1.courseId) >= 3 --at least 3 course in common

) TO 'src/main/resources/data/output/query7.csv' (HEADER, DELIMITER ',');
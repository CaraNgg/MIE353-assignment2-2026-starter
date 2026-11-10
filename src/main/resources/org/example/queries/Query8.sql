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

COPY (
    --highest grade for each course for each student
    WITH highestGradeEachCourse AS (
        SELECT
            transcript.studentId,
            LEFT(transcript.courseId, 3) AS deptCode, --department code
            (course.gradCourse % 2) || '_' || transcript.courseId AS courseId, --udnergrad and 500 courses are 0_, grad courses are 1_
            MAX(transcript.grade) AS grade
        FROM transcript
        JOIN course ON transcript.courseId = course.courseId
        GROUP BY transcript.studentId, transcript.courseId, course.gradCourse
    ),

    --lowest and highest courses for each student for each department
    LowHighPerDeptPerStudent AS (
        SELECT
            studentId,
            deptCode,
            MIN(courseId) AS lowestCourse,
            MAX(courseId) AS highestCourse
        FROM highestGradeEachCourse
        GROUP BY studentId, deptCode
        HAVING COUNT(DISTINCT SUBSTR(courseId, 6, 3)) >= 2 --only count a dept for a student if theyve taken >=2 classes in that dept
    )

    --fullName, department code, (low,high) courses for the student, (low,high) grades for those courses
    SELECT s.firstName || ' ' || s.lastName AS fullName,
        lh.deptCode,
        '(' || SUBSTR(lh.lowestCourse, 3) || ', ' || SUBSTR(lh.highestCourse, 3) || ')' AS pairOfLowHighCourses,
        '(' || lowCourseGrade.grade || ', ' || highCourseGrade.grade || ')' AS pairOfLowHighGrades
    FROM LowHighPerDeptPerStudent lh
    JOIN student s ON lh.studentId = s.studentId
    JOIN highestGradeEachCourse lowCourseGrade
      ON lh.studentId = lowCourseGrade.studentId
      AND lh.lowestCourse = lowCourseGrade.courseId
    JOIN highestGradeEachCourse highCourseGrade
      ON lh.studentId = highCourseGrade.studentId
      AND lh.highestCourse = highCourseGrade.courseId
) TO 'src/main/resources/data/output/query8.csv' (HEADER, DELIMITER ',');
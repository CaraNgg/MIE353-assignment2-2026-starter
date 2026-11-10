CREATE TABLE IF NOT EXISTS gradCourses (
    courseId   VARCHAR(20) PRIMARY KEY,
    courseName VARCHAR(255) NOT NULL
);
INSERT INTO gradCourses SELECT courseId, courseName FROM course WHERE gradCourse IN (1, 2);
COPY gradCourses TO 'src/main/resources/data/output/gradCourses.csv' (HEADER, DELIMITER ',');
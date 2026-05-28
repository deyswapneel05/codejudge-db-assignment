-- Task 5: Database DDL Schema Definitions

CREATE TABLE students (
    student_id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE batches (
    batch_id VARCHAR(50) PRIMARY KEY,
    batch_code VARCHAR(50) UNIQUE NOT NULL,
    description TEXT
);

CREATE TABLE courses (
    course_id VARCHAR(50) PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL
);

CREATE TABLE enrollments (
    student_id VARCHAR(50),
    batch_id VARCHAR(50),
    enrolled_at DATE NOT NULL,
    PRIMARY KEY (student_id, batch_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (batch_id) REFERENCES batches(batch_id) ON DELETE CASCADE
);

CREATE TABLE problems (
    problem_id VARCHAR(50) PRIMARY KEY,
    course_id VARCHAR(50),
    title VARCHAR(150) NOT NULL,
    statement TEXT NOT NULL,
    difficulty VARCHAR(20) CHECK (difficulty IN ('Easy', 'Medium', 'Hard')),
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE SET NULL
);

CREATE TABLE test_cases (
    test_case_id VARCHAR(50) PRIMARY KEY,
    problem_id VARCHAR(50) NOT NULL,
    input_data TEXT NOT NULL,
    expected_output TEXT NOT NULL,
    is_hidden BOOLEAN DEFAULT TRUE,
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id) ON DELETE CASCADE
);

CREATE TABLE contests (
    contest_id VARCHAR(50) PRIMARY KEY,
    title VARCHAR(150) NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    CONSTRAINT check_times CHECK (end_time > start_time)
);

CREATE TABLE contest_problems (
    contest_id VARCHAR(50),
    problem_id VARCHAR(50),
    points INT DEFAULT 10,
    PRIMARY KEY (contest_id, problem_id),
    FOREIGN KEY (contest_id) REFERENCES contests(contest_id) ON DELETE CASCADE,
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id) ON DELETE CASCADE
);

CREATE TABLE submissions (
    submission_id VARCHAR(50) PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    problem_id VARCHAR(50) NOT NULL,
    language VARCHAR(30) NOT NULL,
    code_submitted TEXT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id) ON DELETE CASCADE
);

CREATE TABLE test_results (
    result_id VARCHAR(50) PRIMARY KEY,
    submission_id VARCHAR(50) NOT NULL,
    test_case_id VARCHAR(50) NOT NULL,
    status VARCHAR(20) CHECK (status IN ('PASS', 'FAIL', 'TLE', 'MLE', 'CE')),
    runtime_ms INT DEFAULT 0,
    FOREIGN KEY (submission_id) REFERENCES submissions(submission_id) ON DELETE CASCADE,
    FOREIGN KEY (test_case_id) REFERENCES test_cases(test_case_id) ON DELETE CASCADE
);

CREATE TABLE sessions (
    session_id VARCHAR(50) PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    login_time TIMESTAMP NOT NULL,
    logout_time TIMESTAMP,
    ip_address VARCHAR(45),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE
);

CREATE TABLE attendance (
    attendance_id VARCHAR(50) PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    batch_id VARCHAR(50) NOT NULL,
    class_date DATE NOT NULL,
    is_present BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (batch_id) REFERENCES batches(batch_id) ON DELETE CASCADE
);

CREATE TABLE regrade_requests (
    request_id VARCHAR(50) PRIMARY KEY,
    submission_id VARCHAR(50) NOT NULL,
    reason TEXT NOT NULL,
    status VARCHAR(20) DEFAULT 'PENDING' CHECK (status IN ('PENDING', 'APPROVED', 'REJECTED')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (submission_id) REFERENCES submissions(submission_id) ON DELETE CASCADE
);

CREATE TABLE plagiarism_flags (
    flag_id VARCHAR(50) PRIMARY KEY,
    submission_id VARCHAR(50) NOT NULL,
    similarity_score DECIMAL(5,2) CHECK (similarity_score BETWEEN 0.00 AND 100.00),
    status VARCHAR(20) DEFAULT 'UNDER_REVIEW',
    FOREIGN KEY (submission_id) REFERENCES submissions(submission_id) ON DELETE CASCADE
);

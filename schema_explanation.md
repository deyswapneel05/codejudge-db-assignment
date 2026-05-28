# Task 1 & 2: Schema and Entity-Relationship Explanation

## 1. Core Entities and Table Representations
Based on the raw CSV dataset from CodeJudge, here is what each table represents and their core purposes:

*   **students**: Stores unique profiles of users/students registered on the platform.
*   **batches**: Represents academic groups or cohorts to which students belong.
*   **courses**: List of curriculum topics or modules taught to specific batches.
*   **enrollments**: A many-to-many relationship mapping which student belongs to which batch.
*   **problems**: Coding challenges or tasks available within various courses.
*   **test_cases**: Validation inputs and expected outputs tied to each coding problem.
*   **contests**: Competitive coding events structured on the platform.
*   **contest_problems**: A mapping table linking specific problems to specific contests.
*   **submissions**: Logs of code submitted by students for specific problems.
*   **test_results**: Detailed evaluation logs of each submission running against specific test cases.
*   **sessions**: Tracking user sessions, logins, and platform activity timing.
*   **attendance**: Daily or lecture-wise engagement tracking logs of students in batches.
*   **regrade_requests**: Logs of requests submitted by students to re-evaluate their code submissions.
*   **plagiarism_flags**: Automated security logs identifying copied code or unfair means.
*   **operation_requests / raw_student_import**: Temporary administrative or operational staging pipelines.

## 2. Why Separate Tables are Required
Dividing data into distinct tables ensures data isolation, minimal storage overhead, and prevents deletion/insertion anomalies. For example:
*   Keeping `students` separate from `submissions` ensures that deleting a student's submission does not accidentally delete the student's entire account from the platform.
*   `test_cases` are separated from `problems` because one problem can have dozens of test cases. Merging them would duplicate the problem statement text multiple times unnecessarily.

# Task 3: Keys, Constraints, and Structural Reasoning

| Table Name | Primary Key | Foreign Key(s) | Candidate/Alternate Keys | Non-NULL Columns | Justification / Rules |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **students** | `student_id` | None | `email` | `student_id`, `email`, `name` | `email` must be UNIQUE. |
| **batches** | `batch_id` | None | `batch_code` | `batch_id`, `batch_code` | Identifies unique student groups. |
| **courses** | `course_id` | None | None | `course_id`, `course_name` | Holds generic problem sets. |
| **enrollments**| Composite: (`student_id`, `batch_id`) | `student_id`, `batch_id` | None | All | Maps students to cohorts safely. |
| **problems** | `problem_id` | `course_id` | None | `problem_id`, `title` | Foreign key references `courses`. |
| **test_cases** | `test_case_id`| `problem_id` | None | All | One-to-Many with `problems`. |
| **contests** | `contest_id` | None | None | `contest_id`, `title` | Manages evaluation events. |
| **contest_problems**| Composite: (`contest_id`, `problem_id`) | `contest_id`, `problem_id` | None | All | Prevents adding same problem twice. |
| **submissions**| `submission_id`| `student_id`, `problem_id` | None | All | Captures individual code attempts. |
| **test_results**| `result_id` | `submission_id`, `test_case_id` | None | All | Evaluates specific test outcomes. |
| **sessions** | `session_id` | `student_id` | None | `session_id`, `student_id`| Tracks live user active periods. |
| **attendance** | `attendance_id`| `student_id`, `batch_id` | None | All | Verification logs for regular classes. |
| **regrade_requests**| `request_id` | `submission_id` | None | All | Handles evaluation disputes. |
| **plagiarism_flags**| `flag_id` | `submission_id` | None | All | Security logs pointing to bad code. |

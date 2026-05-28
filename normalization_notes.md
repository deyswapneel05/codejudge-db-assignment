# Task 4: Normalization Reasoning & Trade-offs

## 1. Redundancy & Dependency Examples in Raw CSVs
*   **Repeated Data:** In raw staging data, student names and batch details are often clubbed together, causing redundant string storage every time an attendance or enrollment row is tracked.
*   **Partial Dependency:** If `student_name` depends purely on `student_id`, storing it inside an `enrollments` table alongside `batch_id` violates 2NF.
*   **Transitive Dependency:** If a test case score depends on a problem context, and the problem context depends on a course, placing course details directly inside `test_results` violates 3NF.

## 2. Final Normalization State
Our structured target design achieves **3NF (Third Normal Format)**. 
*   Every table represents a clean, independent business entity.
*   All partial dependencies are eliminated by separating many-to-many structures (like `enrollments` and `contest_problems`) into dedicated mapping tables.
*   All non-prime attributes are fully dependent *only* on the primary keys.

## 3. Design Trade-offs
*   **Pros:** Data modifications (like updating a student's phone number or email) only require a single row change in the `students` table, preventing any asynchronous data states.
*   **Cons:** Generating a full performance report now requires merging/joining multiple tables (`students` $\bowtie$ `submissions` $\bowtie$ `test_results`), which increases CPU read operations during intensive SQL analytical querying.

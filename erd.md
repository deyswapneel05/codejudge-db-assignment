# Task 6: Entity-Relationship Diagram (ERD)

```mermaid
erDiagram
    students ||--o{ enrollments : "takes"
    batches ||--o{ enrollments : "includes"
    students ||--o{ submissions : "makes"
    students ||--o{ sessions : "logs"
    students ||--o{ attendance : "attends"
    batches ||--o{ attendance : "tracks"
    courses ||--o{ problems : "contains"
    problems ||--o{ test_cases : "has"
    problems ||--o{ contest_problems : "part_of"
    contests ||--o{ contest_problems : "features"
    submissions ||--o{ test_results : "produces"
    test_cases ||--o{ test_results : "validates"
    submissions ||--o{ regrade_requests : "disputes"
    submissions ||--o{ plagiarism_flags : "triggers"

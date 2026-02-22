# Contributing to Event Analytics Platform

Thank you for your interest in contributing.

This project focuses on event-driven data modeling and SQL-based analytics.  
All contributions should preserve the architectural principles and analytical integrity of the system.

---

## Project Philosophy

Before contributing, understand the core principles:

- Events are immutable
- Storage is append-only
- One row = one atomic user action
- Raw data is the single source of truth
- All analytics are derived using SQL
- No derived state is stored in the database

Contributions must align with these principles.

---

## Development Setup

### 1. Clone the Repository

```bash
git clone <repo-url>
cd Event-Analytics-Project

2. Install Dependencies
pip install -r requirements.txt
3. Configure Environment
cp env.example .env
Update .env with your local PostgreSQL credentials.

4. Create Database
createdb event_analytics
5. Apply Schema
psql event_analytics -f sql/schema/events.sql

Running the System

Ingest a Test Event
python -m ingestion.test_ingest

Execute Analytics
psql event_analytics
\i sql/analytics/churn_classification.sql


⸻

Contribution Guidelines

Python (Ingestion Layer)
	•	Keep ingestion logic minimal
	•	Validate input strictly
	•	Do not introduce business logic into ingestion
	•	Preserve idempotency (event_id as primary key)

SQL (Analytics Layer)
	•	Use CTEs for clarity
	•	Keep queries readable and declarative
	•	Avoid hard-coded assumptions
	•	Ensure metrics are recomputable from raw events

Documentation
	•	Update README files when adding new features
	•	Clearly define any new metric in plain language
	•	Explain design decisions and tradeoffs

⸻

What Should Not Be Added

This repository intentionally excludes:
	•	Dashboard frameworks
	•	Web APIs
	•	Scheduling systems
	•	Cloud infrastructure
	•	Machine learning models
	•	Derived state tables

If proposing major architectural changes, open an issue first.

⸻

Pull Request Process
	1.	Fork the repository
	2.	Create a feature branch
	3.	Commit focused, descriptive changes
	4.	Open a pull request explaining:
	•	What was changed
	•	Why it was changed
	•	How it aligns with project philosophy

⸻

Reporting Issues

When reporting a bug, include:
	•	PostgreSQL version
	•	Python version
	•	Steps to reproduce
	•	Expected vs actual behavior
	•	Relevant logs or error messages

⸻

Code Style
	•	Clear naming conventions
	•	Small, focused functions
	•	Readable SQL formatting
	•	No unnecessary abstraction
	•	No premature optimization

Clarity over cleverness.

⸻

Scope Boundary Reminder

This project demonstrates:
	•	Event modeling
	•	Append-only storage
	•	SQL analytics (engagement, retention, churn)

Scaling, orchestration, and deployment concerns belong in separate projects.

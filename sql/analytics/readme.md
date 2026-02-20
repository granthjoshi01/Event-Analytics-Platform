# SQL Analytics Layer

## Overview

This directory contains the analytical logic of the Event Analytics Platform.

All metrics are derived directly from the immutable `events` table.  
No pre-aggregated tables or derived user states are stored.

This layer defines:

- Engagement metrics
- Retention analysis
- Funnel progression
- Churn classification

All logic is expressed declaratively in SQL.

---

## Architectural Position


Ingestion Layer

↓

events table (PostgreSQL)

↓

SQL Analytics (this directory)

↓

Insights & Interpretation


This layer transforms raw event facts into business-level insights.

---

## File Structure


    ├── churn_classification.sql
    ├── dau.sql
    ├── retention_basic.sql
    ├── retention_cohorts.sql
    ├── retention_day1.sql
    ├── signup_counts.sql
    ├── funnels/
    │   └── …
    └── README.md

---

## Engagement Metrics

###  [dau.sql](dau.sql)

Daily Active Users.

**Definition:**  
Count of distinct `user_id` performing at least one event per calendar day.

Purpose:
- Measures engagement trend
- Validates ingestion health

---

### [signup_counts.sql](signup_counts.sql)

Daily signup events.

**Definition:**  
Count of `user_signed_up` events grouped by day.

Purpose:
- Measures acquisition
- Detects duplicate retry behavior

---

## Retention Metrics

### [retention_basic.sql](retention_basic.sql)

**Definition:**  
Users who perform any event after signup.

Purpose:
- Measures initial activation
- Establishes baseline retention

---

### [retention_day1.sql](retention_day1.sql)

**Definition:**  
Users active exactly one calendar day after signup.

Purpose:
- Measures short-term engagement
- Common industry benchmark

---

### [retention_cohorts.sql](retention_cohorts.sql)

**Definition:**  
Retention measured relative to each user's signup date.

Purpose:
- Enables cohort analysis
- Supports Day-N retention curves

---

## Churn Modeling

### [churn_classification.sql](churn_classification.sql)

Users are classified based on inactivity duration:

- **Active**: < 7 days inactive
- **Soft churn**: 7–13 days inactive
- **Churned**: 14–29 days inactive
- **Hard churn**: ≥ 30 days inactive

Churn is inferred from inactivity — not from explicit events.

Purpose:
- Identify disengagement
- Enable lifecycle analysis
- Provide classification foundation for potential ML

---

## Funnels

Located in the `funnels/` subdirectory.

Funnels measure user progression between events, such as:

- Signup → Activity
- Signup → Day-1 Activity

Funnels rely on:
- Event ordering
- Distinct user progression
- Time-relative logic

---

## How to Execute Queries

From project root:

```bash
psql event_analytics
\i sql/analytics/<filename>.sql









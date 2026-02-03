# Data Model – Event Analytics Project

## Overview

This project models **user interaction data** in the form of events.
An *event* represents a single action performed by a user at a specific point in time
(e.g., page view, button click, signup).

The data model is designed with the following principles:

- Preserve raw data as the source of truth
- Define a clear grain of data
- Enable future analytical modeling (funnels, retention, cohorts)
- Support scalability and extensibility

---

## Core Concept: Event

An **event** is defined as:

> One action performed by one user at one specific time.

Examples of events:
- A user viewing a page
- A user clicking a button
- A user signing up
- A user completing a purchase

Each event is stored as **one row** in the database.

---

## Grain of the Data

The grain of this dataset is:

> **One row per user event per timestamp**

This means:
- No aggregation at ingestion time
- Each user action is captured independently
- Historical accuracy is preserved

Defining the grain upfront ensures consistent analysis later and prevents ambiguity in metrics.

---

## Raw Events Table

The first table in the system is the **raw events table**, which stores data exactly as it is generated.

### Purpose of `raw_events`

- Acts as the immutable source of truth
- Stores untransformed, append-only data
- Enables reprocessing and re-modeling without data loss
- Separates ingestion from analytics logic

No business logic or aggregation is applied at this stage.

---

## Table: `raw_events`

| Column Name  | Description |
|--------------|-------------|
| `event_id`   | Unique identifier for each event |
| `event_time` | Timestamp when the event occurred |
| `user_id`    | Identifier of the user who triggered the event |
| `session_id` | Identifier grouping related user actions |
| `event_type` | Type of event (e.g., page_view, click, signup) |
| `page`       | Page or screen where the event occurred |
| `device`     | Device type (mobile, desktop, tablet) |
| `country`    | Country associated with the user |

---

## Design Decisions

- **Raw-first approach**: Raw data is stored before any transformation to preserve accuracy.
- **Append-only strategy**: Events are never updated or deleted.
- **Minimal assumptions**: Only essential fields are included initially.
- **Future-ready**: The model allows easy extension into fact and dimension tables.

---

## Future Modeling (Out of Scope for Phase 1)

In later phases, this raw table will be transformed into:

- Fact tables (e.g., `fact_events`)
- Dimension tables (e.g., users, time, device)
- Analytical views for metrics and reporting

These transformations are intentionally deferred until sufficient data patterns are observed.

---

## Summary

This data model establishes a strong foundation for analytics by:

- Clearly defining data grain
- Preserving raw historical events
- Enabling accurate and flexible SQL analysis
- Supporting future scalability and modeling

The goal is to prioritize **correctness and clarity** before optimization or scale.

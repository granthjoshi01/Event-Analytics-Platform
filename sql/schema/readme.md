
# Database Schema

## Overview

This directory defines the core storage schema for the Event Analytics Platform.

The system is built around a single append-only table:

> `events`

This table acts as the immutable source of truth for all downstream analytics, including engagement metrics, retention analysis, funnels, and churn classification.

No derived metrics or state are stored at the schema level.

---

## Design Principles

The schema follows these foundational principles:

- **Immutable events**
- **Append-only storage**
- **One row = one atomic action**
- **Strict constraints for data integrity**
- **Analytics computed downstream via SQL**

The database stores facts. Interpretation happens later.

---

## Core Table: `events`

```sql
CREATE TABLE IF NOT EXISTS events (
    event_id UUID PRIMARY KEY,
    event_name TEXT NOT NULL,
    event_time TIMESTAMPTZ NOT NULL,
    user_id TEXT NOT NULL,
    properties JSONB NOT NULL DEFAULT '{}',
    ingested_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

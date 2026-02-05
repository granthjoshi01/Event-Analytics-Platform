# Event Data Model

## Overview

This document defines the **core event data model** used by the Event Analytics Pipeline.

The purpose of this model is to establish a **correct, stable, and extensible foundation** for analytics in a SaaS environment. All downstream analytics—including metrics, funnels, retention, and churn—are derived exclusively from this event data.

This document focuses on **conceptual data modeling**, not physical database implementation.

---

## What Is an Event?

An **event** is an immutable, append-only record representing a **single atomic action** that occurred in a client application at a specific point in time.

An event answers the following questions:
- **What happened?**
- **Who performed the action?**
- **When did it occur?**
- **In what context did it happen?**

Events describe **actions**, not states.

---

## Design Principles

The event model adheres to the following principles:

1. **Immutability**  
   Once written, events are never updated or deleted.

2. **Append-only**  
   New information is captured by inserting new events, never by modifying historical data.

3. **Atomicity**  
   One event represents one indivisible action.

4. **Raw Data Preservation**  
   Events store facts, not interpretations or derived metrics.

5. **SQL-driven Intelligence**  
   All analytical meaning is derived downstream using SQL, not embedded in raw data.

6. **Recomputability**  
   Any metric must be recomputable from raw events alone.

---

## Event Granularity

Each event represents a **single occurrence** of an action.

Examples:
- A user clicking a button → 1 event
- A user logging in twice → 2 events
- Creating three projects → 3 events

Batching multiple actions into a single event is not allowed.

---

## Canonical Event Contract

Every event in the system must conform to the following **conceptual contract**.

### Mandatory Fields

| Field Name   | Description |
|-------------|-------------|
| `event_id`  | Globally unique identifier for the event |
| `event_name`| Stable, verb-based name describing the action |
| `event_time`| Timestamp when the action occurred |
| `user_id`   | Identifier of the user who performed the action |
| `properties`| Key-value metadata providing contextual details |

These fields are required for an event to be considered valid.

---

## Event Naming Conventions

Event names must follow consistent and predictable conventions to ensure long-term analytical stability.

### Rules
- Use **snake_case**
- Use **past-tense verbs**
- Describe **actions**, not states
- Avoid embedding business logic in event names

### Valid Examples
- `user_signed_up`
- `login_succeeded`
- `project_created`
- `feature_used`

### Invalid Examples
- `is_active_user`
- `user_status`
- `daily_login_count`
- `churned_user`

---

## Event Properties

Event properties provide **additional context** about an event.

### Characteristics
- Descriptive, not analytical
- Optional and extensible
- Schema-flexible
- May evolve over time

### Valid Properties
- `plan_type`
- `project_id`
- `feature_name`
- `source`

### Invalid Properties
- `is_power_user`
- `retention_bucket`
- `churn_risk_score`
- `daily_event_count`

Properties must never encode derived insights, classifications, or metrics.

---

## What This Model Intentionally Excludes

The raw event model does **not** include:

- Aggregated metrics (DAU, MAU, funnels)
- User state flags (e.g., active, churned)
- Counters or cumulative values
- Machine learning features or predictions
- Dashboards or visualization logic

All such constructs are derived downstream from raw events.

---

## Relationship to Downstream Analytics

This event model acts as the **single source of truth** for all analytics.

Downstream layers may:
- Aggregate events
- Join events with dimensional tables
- Compute metrics and trends
- Define retention and churn logic

Raw events themselves remain unchanged.

---

## Out of Scope (Future Considerations)

The following topics are intentionally deferred:
- Multi-tenant support
- Schema versioning
- Streaming ingestion
- Late-arriving event handling
- Warehouse-level optimization

These will be addressed after the core model is validated.

---



# Ingestion Module

## Overview

This directory contains the **event ingestion layer** of the Event Analytics Platform.

The ingestion layer is responsible for:

- Validating incoming event payloads  
- Enforcing schema correctness  
- Guaranteeing idempotent writes  
- Persisting immutable events into PostgreSQL  

It acts as the controlled entry point between external event producers and the analytics storage layer.

---

## Design Principles

The ingestion system is intentionally designed to be:

- **Strict** — invalid events are rejected  
- **Idempotent** — duplicate retries do not create duplicate records  
- **Minimal** — no business logic is embedded  
- **Deterministic** — every accepted event is written exactly once  
- **Recomputable** — no derived metrics are stored  

The ingestion layer preserves facts.  
It does not interpret or aggregate data.

---

## File Structure

       ├── init.py
       ├── ingest_event.py
       ├── validation.py
       ├── test_ingest.py
       └── readme.md

### ingest_event.py

Core ingestion function.

Responsibilities:

- Establish database connection  
- Call validation logic  
- Insert event into `events` table  
- Enforce idempotency via `event_id`  
- Commit transaction safely  

This file contains the system’s write path.

---

### validation.py

Event schema enforcement module.

Responsibilities:

- Validate required fields  
- Validate data types  
- Ensure ISO timestamp formatting  
- Enforce minimal structural integrity  

Raises `ValidationError` for malformed events.

This ensures the storage layer never receives invalid data.

---

### test_ingest.py

Local event simulation script.

Responsibilities:

- Generate synthetic events  
- Call `ingest_event()`  
- Simulate client-side event emission  

This acts as a stand-in for:

- Web applications  
- Mobile applications  
- Backend services  

It allows end-to-end testing of the ingestion flow.

---

### __init__.py

Marks the directory as a Python package.

No runtime logic.

---

## Event Contract

Each event must contain:

- `event_id` (UUID string)  
- `event_name` (string)  
- `event_time` (ISO 8601 timestamp)  
- `user_id` (string)  
- `properties` (JSON object)  

Events are treated as immutable facts.

---

## Idempotency

Duplicate events (same `event_id`) are ignored at insert time.

This ensures:

- Safe client retries  
- No double counting  
- Stable analytics results  

Idempotency is enforced at the database layer using primary key constraints.

---



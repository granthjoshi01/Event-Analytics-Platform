# Event Ingestion Contract

## Overview

This document defines the **external event ingestion contract** for the Event Analytics Pipeline.

Client applications send event data to this system using a structured payload.  
This contract ensures consistency, correctness, and long-term analytical reliability.

The ingestion layer validates events but does not enrich, aggregate, or mutate them.

---

## Ingestion Philosophy

- Clients are responsible for emitting events
- The analytics system is passive and append-only
- Invalid events are rejected early
- Raw events are never modified after ingestion
- All intelligence lives downstream in SQL

---

## Event Payload Structure

Each event must be sent as a single JSON object with the following structure.

```json
{
  "event_id": "uuid",
  "event_name": "string",
  "event_time": "ISO-8601 timestamp",
  "user_id": "string",
  "properties": { "key": "value" }
}
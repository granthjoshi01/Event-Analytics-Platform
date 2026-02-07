from ingestion.ingest_event import ingest_event
import uuid
from datetime import datetime, timezone

event = {
    "event_id": str(uuid.uuid4()),
    "event_name": "user_signed_up",
    "event_time": datetime.now(timezone.utc).isoformat(),
    "user_id": "user_456",
    "properties": {
        "plan_type": "free"
    }
}

ingest_event(event)

print("Event ingested successfully")

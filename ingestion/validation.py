import uuid
from datetime import datetime, timezone
from dateutil.parser import isoparse


class ValidationError(Exception):
    pass


def validate_event(event: dict) -> None:
    required_fields = ["event_id", "event_name", "event_time", "user_id"]

    for field in required_fields:
        if field not in event:
            raise ValidationError(f"Missing required field: {field}")

    # event_id
    try:
        uuid.UUID(event["event_id"])
    except Exception:
        raise ValidationError("event_id must be a valid UUID")

    # event_name
    if not isinstance(event["event_name"], str) or not event["event_name"].strip():
        raise ValidationError("event_name must be a non-empty string")

    # event_time
    try:
        event_time = isoparse(event["event_time"])
    except Exception:
        raise ValidationError("event_time must be a valid ISO-8601 timestamp")

    if event_time > datetime.now(timezone.utc):
        raise ValidationError("event_time cannot be in the future")

    # user_id
    if not isinstance(event["user_id"], str) or not event["user_id"].strip():
        raise ValidationError("user_id must be a non-empty string")

    # properties
    if "properties" in event and not isinstance(event["properties"], dict):
        raise ValidationError("properties must be an object if provided")
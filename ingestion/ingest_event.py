import psycopg2
from psycopg2.extras import Json
from ingestion.validation import validate_event, ValidationError


def ingest_event(event: dict):
    validate_event(event)

    conn = psycopg2.connect(
        dbname="event_analytics",
        user="granthjoshi",
        host="localhost",
        port=5432,
    )

    query = """
    INSERT INTO events (
        event_id,
        event_name,
        event_time,
        user_id,
        properties
    )
    VALUES (%s, %s, %s, %s, %s)
    ON CONFLICT (event_id) DO NOTHING;
    """

    with conn:
        with conn.cursor() as cur:
            cur.execute(
                query,
                (
                    event["event_id"],
                    event["event_name"],
                    event["event_time"],
                    event["user_id"],
                    Json(event.get("properties", {})),
                ),
            )

    conn.close()
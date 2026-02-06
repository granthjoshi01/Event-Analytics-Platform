CREATE TABLE IF NOT EXISTS events (
    event_id UUID PRIMARY KEY,
    event_name TEXT NOT NULL,
    event_time TIMESTAMPTZ NOT NULL,
    user_id TEXT NOT NULL,
    properties JSONB NOT NULL DEFAULT '{}',
    ingested_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);


ALTER TABLE events
ADD CONSTRAINT event_name_not_empty
CHECK (event_name <> '');


ALTER TABLE events
ADD CONSTRAINT event_time_not_future
CHECK (event_time <= NOW());

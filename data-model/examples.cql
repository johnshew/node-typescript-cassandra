
use nagbot

drop materialized view if exists reminders_by_user

drop materialized view if exists reminders_by_next_notification;
drop table if exists reminders;

create table reminders (
    reminder_id timeuuid,
    user_id uuid,
    name text,
    description text,
    last_notification timestamp,
    next_notification timestamp,
    completed boolean,
    schedule list<text>,
    primary key (reminder_id)
);


create materialized view reminders_by_user as
  select * from reminder
  where reminder_id is not null and user_id is not null
  primary key (user_id, reminder_id);

create materialized view reminders_by_next_notification as
  select * from reminder
  where reminder_id is not null and next_notification is not null
  primary key (next_notification, reminder_id)
  with clustering order by ( next_notification asc );
  


CREATE TABLE scores (
  user TEXT,
  game TEXT,
  year INT,
  month INT,
  day INT,
  score INT,
  PRIMARY KEY (user, game, year, month, day)
)

CREATE MATERIALIZED VIEW alltimehigh AS
       SELECT user FROM scores
       WHERE game IS NOT NULL AND score IS NOT NULL AND user IS NOT NULL AND year IS NOT NULL AND month IS NOT NULL AND day IS NOT NULL
       PRIMARY KEY (game, score, user, year, month, day)
       WITH CLUSTERING ORDER BY (score desc)

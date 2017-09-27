drop keyspace if exists nagbot;

CREATE KEYSPACE nagbot
  WITH REPLICATION = { 'class' : 'SimpleStrategy', 'replication_factor' : 1 };


use nagbot;

drop materialized view if exists reminders_by_user;
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
  select * from reminders
  where reminder_id is not null and user_id is not null
  primary key (user_id, reminder_id);

create materialized view reminders_by_next_notification as
  select * from reminders
  where reminder_id is not null and next_notification is not null
  primary key (next_notification, reminder_id)
  with clustering order by ( next_notification asc );
  
insert into reminders (reminder_id, user_id, next_notification, last_notification, description) values(now(), 01234567-0123-0123-0123-0123456789ab, dateOf(now()), '2000-01-01', 'empty fridge');
insert into reminders (reminder_id, user_id, next_notification, last_notification, description) values(now(), 01234567-0123-0123-0123-0123456789ab, dateOf(now()), '2000-01-01', 'run');
insert into reminders (reminder_id, user_id, next_notification, last_notification, description) values(now(), 01234567-0123-0123-0123-0123456789ab, dateOf(now()), '2000-01-01', 'swim');
 
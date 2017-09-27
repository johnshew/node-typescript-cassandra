
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

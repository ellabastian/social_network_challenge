TRUNCATE TABLE accounts RESTART IDENTITY CASCADE;
TRUNCATE TABLE posts RESTART IDENTITY;

INSERT INTO accounts(email_address, username) VALUES('davidjackson@google.com', 'davidjackson');
INSERT INTO accounts(email_address, username) VALUES('emmawatson@google.com', 'emmawatson1');

INSERT INTO posts(title, content, views, account_id) VALUES('A day in the life of..', 'This is a diary of my day', 600, 1);
INSERT INTO posts(title, content, views, account_id) VALUES('Favourite foods', 'My favourite food is chocolate', 1000, 2);
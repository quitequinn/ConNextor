---------------------------------------------------------------
-- PostgreSQL Data Definition Language
-- 
-- Import this file into database server to recreate all tables
-- psql -U postgres -d connextor < connextor.xxxx.xx.xx.ddl
-- 
-- Follow the updating procedure outlined by the styles guide
---------------------------------------------------------------


--------------------------
---------- DROP ----------
--------------------------

DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS user_interests CASCADE;
DROP TABLE IF EXISTS user_to_interest CASCADE;
DROP TABLE IF EXISTS user_expertise CASCADE;
DROP TABLE IF EXISTS user_to_expertise CASCADE;
DROP TABLE IF EXISTS user_specializations CASCADE;
DROP TABLE IF EXISTS user_to_specialization CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS proj_user_classes CASCADE;
DROP TABLE IF EXISTS user_to_proj CASCADE;
DROP TABLE IF EXISTS proj_posts CASCADE;
DROP TABLE IF EXISTS proj_post_comments CASCADE;
DROP TABLE IF EXISTS proj_tags CASCADE;
DROP TABLE IF EXISTS proj_to_tag CASCADE;
DROP TABLE IF EXISTS proj_tasks CASCADE;
DROP TABLE IF EXISTS proj_task_comments CASCADE;

DROP TABLE IF EXISTS tablename CASCADE;

-- DROP TYPE IF EXISTS user_type CASCADE;

----------------------------
---------- CREATE ----------
----------------------------

-- CREATE TYPE user_type AS ENUM (
--     'type1',
--     'type2'
-- );

CREATE TABLE users (
    id                       BIGSERIAL PRIMARY KEY,
    user_name                TEXT NOT NULL UNIQUE, --custom domain
    first_name               TEXT NOT NULL,
    last_name                TEXT NOT NULL,
    email                    TEXT NOT NULL UNIQUE,
    -- location                 TEXT NULL, Requires list of locations
    biography                TEXT NULL,
    -- verified                 INT NOT NULL DEFAULT 0,
    -- user_type                user_type NOT NULL DEFAULT 'type1', Can take care of verification
    -- privacy                  INT NOT NULL DEFAULT 0, Settings, implemented later
    -- activity                 INT NOT NULL DEFAULT 0, Activity assessment, could be nightly
    -- facebook_oauth           TEXT NULL,
    date_registered          TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE user_interests (
    id                       BIGSERIAL PRIMARY KEY,
    interest_name            TEXT NOT NULL UNIQUE,
    description              TEXT NOT NULL
);

CREATE TABLE user_to_interest (
    user_id                  BIGINT NOT NULL REFERENCES users(id),
    interest_id              BIGINT NOT NULL REFERENCES user_interests(id),
    PRIMARY KEY (user_id, interest_id)
);

CREATE TABLE user_expertise (
    id                       BIGSERIAL PRIMARY KEY,
    expertise_name           TEXT NOT NULL UNIQUE,
    description              TEXT NOT NULL
);

CREATE TABLE user_to_expertise (
    user_id                  BIGINT NOT NULL REFERENCES users(id),
    expertise_id             BIGINT NOT NULL REFERENCES user_expertise(id),
    PRIMARY KEY (user_id, expertise_id)
);


CREATE TABLE user_specializations (
    id                       BIGSERIAL PRIMARY KEY,
    specialization_name      TEXT NOT NULL UNIQUE,
    description              TEXT NOT NULL
);

CREATE TABLE user_to_specialization (
    user_id                  BIGINT NOT NULL REFERENCES users(id),
    specialization_id        BIGINT NOT NULL REFERENCES user_specializations(id),
    PRIMARY KEY (user_id, specialization_id)
);

CREATE TABLE projects (
    id                       BIGSERIAL PRIMARY KEY,
    proj_title               TEXT NOT NULL,
    short_description        TEXT NOT NULL,
    long_description         TEXT NULL,
    -- privacy                  INT NOT NULL DEFAULT 0,
    date_created             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

-- Users bind to projects under classes. We can predefine these classes
-- But we need our pre-defined classes, and their authority

-- Owner / Founder
-- Core Members
-- Contributor
-- Investors
-- ...

-- Furthermore, we will have contributor groups that are customizable by core members

-- Design
-- Marketing
-- Backend
-- Frontend

-- Users who fall under the Contributor class will also fall under these custom groupings
-- And tasks can fall under these groups, with privacy setting.

CREATE TABLE proj_user_classes (
    id                       BIGSERIAL PRIMARY KEY,
    class_name               TEXT NOT NULL
);

CREATE TABLE user_to_proj (
    user_id                  BIGINT NOT NULL REFERENCES users(id),
    proj_id                  BIGINT NOT NULL REFERENCES projects(id),
    PRIMARY KEY (user_id, proj_id),
    class_id                 BIGINT NOT NULL REFERENCES proj_user_classes(id),
    UNIQUE (user_id, class_id)
);

CREATE TABLE proj_posts (
    id                       BIGSERIAL PRIMARY KEY,
    proj_id                  BIGINT NOT NULL REFERENCES projects(id),
    user_id                  BIGINT NOT NULL REFERENCES users(id),
    post_title               TEXT NOT NULL,
    post_content             TEXT NULL,
    -- comment_count            INT NOT NULL This requires PostgreSQL Triggers. #Denomalization
    date_created             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    date_last_edit           TIMESTAMP NULL
);

CREATE TABLE proj_post_comments (
    id                       BIGSERIAL PRIMARY KEY,
    proj_post_id             BIGINT NOT NULL REFERENCES proj_posts(id),
    user_id                  BIGINT NOT NULL REFERENCES users(id),
    comment_content          TEXT NOT NULL,
    date_created             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE proj_tags (
    id                       BIGSERIAL PRIMARY KEY,
    tag_name                 TEXT NOT NULL UNIQUE
);

CREATE TABLE proj_to_tag (
	proj_id                  BIGINT NOT NULL REFERENCES projects(id),
    tag_id                   BIGINT NOT NULL REFERENCES proj_tags(id),
    PRIMARY KEY (proj_id, tag_id)
);

CREATE TABLE proj_tasks (
    id                       BIGSERIAL PRIMARY KEY,
    proj_id                  BIGINT NOT NULL REFERENCES projects(id),
    user_id                  BIGINT NOT NULL REFERENCES users(id),
    task_name                TEXT NOT NULL,
    task_description         TEXT NULL,
    state                    INT NOT NULL DEFAULT 0,
    -- privacy                  INT NOT NULL DEFAULT 0,
    -- comment_count            INT NOT NULL, This requires PostgreSQL Triggers. #Denomalization
    date_created             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE proj_task_comments (
    id                       BIGSERIAL PRIMARY KEY,
    proj_task_id             BIGINT NOT NULL REFERENCES proj_tasks(id),
    user_id                  BIGINT NOT NULL REFERENCES users(id),
    comment_content          TEXT NOT NULL,
    date_created             TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
);



---------------------------
---------- GRANT ----------
---------------------------

GRANT SELECT, INSERT, UPDATE, DELETE ON users TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON user_interests TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON user_to_interest TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON user_expertise TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON user_to_expertise TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON user_specializations TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON user_to_specialization TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON projects TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON proj_user_classes TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON user_to_proj TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON proj_posts TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON proj_post_comments TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON proj_tags TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON proj_to_tag TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON proj_tasks TO connextoruser;
GRANT SELECT, INSERT, UPDATE, DELETE ON proj_task_comments TO connextoruser;



----------------------------
---------- INSERT ----------
----------------------------

INSERT INTO users (user_name, first_name, last_name, email) VALUES ('davidsong', 'david', 'song', 'davidsong@connextor.com');
INSERT INTO users (user_name, first_name, last_name, email) VALUES ('emmaclement', 'emmalene', 'clementine', 'emmaclement@connextor.com');
INSERT INTO users (user_name, first_name, last_name, email) VALUES ('stratos', 'stratos', 'elements', 'stratos@connextor.com');

INSERT INTO user_interests (interest_name, description) VALUES ('Music', 'For the Music Lovers');
INSERT INTO user_interests (interest_name, description) VALUES ('Movies', 'They make us wild; they make us cry. We really can''t live without them.');
INSERT INTO user_interests (interest_name, description) VALUES ('Food', 'We are nothing without food.');
INSERT INTO user_interests (interest_name, description) VALUES ('Sleep', 'For us, it''s quite easy being lazy');

INSERT INTO user_to_interest VALUES (1, 1);
INSERT INTO user_to_interest VALUES (1, 2);
INSERT INTO user_to_interest VALUES (1, 3);
INSERT INTO user_to_interest VALUES (2, 4);
INSERT INTO user_to_interest VALUES (3, 2);
INSERT INTO user_to_interest VALUES (3, 3);

INSERT INTO projects (proj_title, short_description) VALUES ('Google', 'Building the fastest Search Engine and exploit all personal data to make money.');
INSERT INTO projects (proj_title, short_description) VALUES ('ConNextor', 'Connecting the next generation of thinkers and builders.');
INSERT INTO projects (proj_title, short_description) VALUES ('Capital One Data Mining','Creating models to estimate and predict customer interests.');


INSERT INTO proj_user_classes (class_name) VALUES ('Founder');
INSERT INTO proj_user_classes (class_name) VALUES ('Core Member');
INSERT INTO proj_user_classes (class_name) VALUES ('Manager');
INSERT INTO proj_user_classes (class_name) VALUES ('Contributor');
INSERT INTO proj_user_classes (class_name) VALUES ('Investor');
INSERT INTO proj_user_classes (class_name) VALUES ('Stalker');


INSERT INTO proj_tags (tag_name) VALUES ('Big Data');
INSERT INTO proj_tags (tag_name) VALUES ('Web Design');
INSERT INTO proj_tags (tag_name) VALUES ('Human Technology Interface');
INSERT INTO proj_tags (tag_name) VALUES ('Wearable Techonology');
INSERT INTO proj_tags (tag_name) VALUES ('Information Security');
INSERT INTO proj_tags (tag_name) VALUES ('Creativity');
INSERT INTO proj_tags (tag_name) VALUES ('Social Connection Building');

INSERT INTO proj_to_tag VALUES (1, 1);
INSERT INTO proj_to_tag VALUES (1, 2);
INSERT INTO proj_to_tag VALUES (1, 5);
INSERT INTO proj_to_tag VALUES (2, 2);
INSERT INTO proj_to_tag VALUES (2, 6);
INSERT INTO proj_to_tag VALUES (2, 7);
INSERT INTO proj_to_tag VALUES (3, 1);


---------------------------
---------- INDEX ----------
---------------------------

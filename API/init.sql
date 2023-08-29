CREATE TABLE users
(
    id         INT AUTO_INCREMENT PRIMARY KEY,
    email      VARCHAR(255) NOT NULL,
    password   VARCHAR(255) NOT NULL,
    lastname   VARCHAR(255) NOT NULL,
    firstname  VARCHAR(255) NOT NULL,
    sexe       VARCHAR(50) NOT NULL,
    birthdate  DATE         NOT NULL,
    validated  BOOLEAN      NOT NULL DEFAULT FALSE,
    note       FLOAT        NOT NULL DEFAULT 0,
    dateSignIn DATE         NOT NULL,
    profession INT,
    role       INT
);

CREATE TABLE files
(
    id        INT AUTO_INCREMENT PRIMARY KEY,
    user_id   INT          NOT NULL,
    title     VARCHAR(255) NOT NULL,
    file      VARCHAR(255) NOT NULL,
    dateAdd   DATE         NOT NULL,
    validated BOOLEAN      NOT NULL DEFAULT FALSE,
    type      INT          NOT NULL
);

CREATE TABLE professions
(
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE roles
(
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE types
(
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

CREATE TABLE requetes(
    id INT AUTO_INCREMENT PRIMARY KEY,
    client INT NOT NULL,
    timer VARCHAR(255) NOT NULL,
    type INT NOT NULL,
    title VARCHAR(255) NOT NULL,
    slots INT NOT NULL,
    accepted BOOLEAN NOT NULL DEFAULT FALSE,
    done BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE requetes_inscriptions
(
    id       INT AUTO_INCREMENT PRIMARY KEY,
    requete  INT     NOT NULL,
    user     INT     NOT NULL,
    accepted BOOLEAN NOT NULL DEFAULT FALSE
);

CREATE TABLE tasks
(
    id      INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT          NOT NULL,
    title   VARCHAR(255) NOT NULL,
    type    INT          NOT NULL,
    content VARCHAR(255) NOT NULL
);

CREATE TABLE typetasks
(
    id   INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);


INSERT INTO users (email,
                   password,
                   lastname,
                   firstname,
                   birthdate,
                   profession,
                   role)
VALUES ('bob@email.fr',
        'bob',
        'bob',
        'bob',
        '1990-01-01',
        1,
        1);

INSERT INTO typetasks (name)
VALUES ('A faire');
INSERT INTO typetasks (name)
VALUES ('En cours');
INSERT INTO typetasks (name)
VALUES ('Complétée');
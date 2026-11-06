CREATE TABLE api_keys
(
    id           varchar(55) primary key,
    user_id      varchar(55)  not null references users (id) on DELETE cascade,
    name         varchar(255) not null,
    key_hash     varchar(255) not null unique,
    time_created bigint       not null,
    expires_at   bigint       null
);

CREATE INDEX api_keys_user_id_idx ON api_keys (user_id);

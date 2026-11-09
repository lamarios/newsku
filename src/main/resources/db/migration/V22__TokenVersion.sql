-- tokens carry the version they were issued with, increasing it invalidates all of them
alter table users
    add column token_version integer not null default 0;

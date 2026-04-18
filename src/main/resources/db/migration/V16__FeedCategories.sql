CREATE TABLE feed_categories
(
    id          varchar(55) primary key,
    name        varchar(255) not null,
    user_id     varchar(55)  not null references users (id) on DELETE cascade
);


alter table feeds
    add column category_id varchar(55) null references feed_categories (id) on DELETE cascade;
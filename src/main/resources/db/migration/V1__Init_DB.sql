create sequence hibernate_sequence start 1 increment 1;

create table card (
                  id int8 not null,
                  file_name varchar(255),
                  text varchar(2048) not null,
                  deck_id int8 not null,
                  status_id int8,
                  primary key (id)
);

create table deck (
                  id int8 not null,
                  name varchar(255)  not null,
                  user_id int8,
                  primary key (id)
);

create table deck_statuses (
                  id int8 not null,
                  status varchar(255),
                  deck_id int8  not null,
                  primary key (id)
);

create table message (
                  id int8 not null,
                  tag varchar(255),
                  text varchar(255) not null,
                  user_id int8,
                  primary key (id)
);

create table user_role (
                  user_id int8 not null,
                  roles varchar(255)
);

create table usr (
                  id int8 not null,
                  activation_code varchar(255),
                  active boolean not null,
                  email varchar(255),
                  password varchar(255) not null,
                  username varchar(255) not null,
                  primary key (id)
);

alter table if exists card
                  add constraint card_deck_fk
                  foreign key (deck_id) references deck;

alter table if exists card
                  add constraint card_status_fk
                  foreign key (status_id) references deck_statuses;

alter table if exists deck
                  add constraint deck_user_fk
                  foreign key (user_id) references usr;

alter table if exists deck_statuses
                  add constraint status_deck_fk
                  foreign key (deck_id) references deck;

alter table if exists message
                  add constraint message_user_fk
                  foreign key (user_id) references usr;

alter table if exists user_role
                  add constraint user_role_fk
                  foreign key (user_id) references usr;

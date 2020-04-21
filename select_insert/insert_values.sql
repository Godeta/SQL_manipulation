 DROP TABLE public.chitter_user;
--création de la table
CREATE TABLE public.chitter_user
(
    username character varying(10) COLLATE pg_catalog."default",
    user_id integer NOT NULL DEFAULT nextval('chitter_user_user_id_seq'::regclass),
    encrypted_password character varying(10) COLLATE pg_catalog."default",
    email character varying(20) COLLATE pg_catalog."default",
    date_joined date,
    CONSTRAINT chitter_user_pkey PRIMARY KEY (user_id)
)

drop table follower;
create table follower 
(
    user_id INT not null,
    follower_id int not null,
    constraint follower_user_id_fkey foreign key (user_id) --contrainte clé étrangère
    references chitter_user (user_id) on delete cascade --si user_id de chiffer_user est supprimé, celui de follower le sera aussi
)

drop table post;
create table post 
(
post_id int not null DEFAULT nextval('post_post_id_seq'::regclass), --par défaut suite 1,2,3...
 user_id int not null,
post_text varchar(50),
posted_on timestamp with time zone DEFAULT CURRENT_TIMESTAMP, --temps, par défaut le temps actuel
constraint post_pkey primary key (post_id),
constraint post_user_id_fkey foreign key
references chitter_user (user_id) on delete cascade
)


insert into chitter_user(
user_id, username, encrypted_password, email, date_joined)
values
(default,'firstuser','d63dc91e61','randommail@din.com','2019-02-25'); --default car type serial donc il va generer un id random

select * from chitter_user;

insert into chitter_user 
( username, encrypted_password)
values
('seconduser','9z65f4e5gd');

insert into post (user_id,post_text)
values
(1,'hello world !'),
(1, 'hello solar system !');



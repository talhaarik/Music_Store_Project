drop table album_album_song;
drop table single_physical_form;
drop table album_physical_form;
drop table feat_single;
drop table feat_album_song;
drop trigger album_shelf;
drop trigger single_shelf;
drop table single_shelf;
drop table album_shelf;
drop trigger sell_album;
drop trigger sell_single;
drop table single_sale;
drop table album_sale;
drop table singer_creates_single;
drop table singer_creates_album;
drop table album_song;
drop table album;
drop table singles;
drop table shelf;
drop table staff;
drop table customer;
drop table singer;
drop table physical_form;


create table physical_form (
physical_form_id number primary key,
physical_form_name varchar2(30)
);
    
create table singer (
singer_id number primary key,
singer_name varchar2(64) not null,
rate number
);

create table customer (
customer_id number primary key,
first_name varchar2(64) not null,
middle_name varchar2(64),
last_name varchar2(64) not null,
country varchar2(64),
city varchar2(64),
district varchar2(64),
street varchar2(64),
street_number number,
apartment_number number,
postal_code number,
birth_date date
);

create table staff(
staff_id number primary key,
first_name varchar2(64) not null,
middle_name varchar2(64),
last_name varchar2(64) not null,
country varchar2(64),
city varchar2(64),
district varchar2(64),
street varchar2(64),
street_number number,
apartment_number number,
postal_code number,
birth_date date,
employment_date date
);

create table shelf(
shelf_id number primary key,
shelf_capacity number not null
);

create table singles(
single_id number primary key,
title varchar2(64) not null,
price number not null,
genre varchar2(64),
release_date date,
rate number(1,1),
stock number not null
);

create table album(
album_id number primary key,
title varchar2(64) not null,
price number not null,
genre varchar2(64),
release_date date,
rate number,
stock number not null
);


-- album song --
create table album_song(
album_song_id number primary key,
title varchar2(64) not null,
genre varchar2(64),
rate number
);

-- singer album relation --

create table singer_creates_album (
singer_id number not null,
album_id number not null,
constraint pk_singer_creates_album primary key (singer_id, album_id)
);

ALTER TABLE singer_creates_album
ADD CONSTRAINT fk_album_id_singer_creates_album
FOREIGN KEY (album_id)
REFERENCES album(album_id);

ALTER TABLE singer_creates_album
ADD CONSTRAINT fk_singer_id_singer_creates_album
FOREIGN KEY (singer_id)
REFERENCES singer(singer_id);

-- singer sinlge relation--

create table singer_creates_single (
singer_id number not null,
single_id number not null,
constraint pk_singer_creates_single primary key (singer_id, single_id)
);

ALTER TABLE singer_creates_single
ADD CONSTRAINT fk_single_id_singer_creates_single
FOREIGN KEY (single_id)
REFERENCES singles(single_id);

ALTER TABLE singer_creates_single
ADD CONSTRAINT fk_singer_id_singer_creates_single
FOREIGN KEY (singer_id)
REFERENCES singer(singer_id);* 

-- sale--
create table sale (
sale_id number primary key,
sale_date date,
payment_method varchar2(32),
customer_id number not null,
staff_id number not null
);


ALTER TABLE sale
ADD CONSTRAINT fk_customer_id_sale
FOREIGN KEY (customer_id)
REFERENCES customer(customer_id);


ALTER TABLE sale
ADD CONSTRAINT fk_staff_id_sale
FOREIGN KEY (staff_id)
REFERENCES staff(staff_id);

--album sale--

create table album_sale (
album_id number not null,
sale_id number not null,
constraint pk_album_sale primary key (album_id, sale_id)
);


ALTER TABLE album_sale
ADD CONSTRAINT fk_album_id_album_sale
FOREIGN KEY (album_id)
REFERENCES album(album_id);

ALTER TABLE album_sale
ADD CONSTRAINT fk_sale_id_album_sale
FOREIGN KEY (sale_id)
REFERENCES sale(sale_id);

-- single sale--

create table single_sale (
single_id number not null,
sale_id number not null,
constraint pk_single_sale primary key (single_id, sale_id)
);

ALTER TABLE single_sale
ADD CONSTRAINT fk_single_id_single_sale
FOREIGN KEY (single_id)
REFERENCES singles(single_id);

ALTER TABLE single_sale
ADD CONSTRAINT fk_sale_id_single_sale
FOREIGN KEY (sale_id)
REFERENCES sale(sale_id);

-- album shelf--
create table album_shelf (
album_id number not null,
shelf_id number not null,
constraint pk_album_shelf primary key (album_id, shelf_id)
);

ALTER TABLE album_shelf
ADD CONSTRAINT fk_album_id_album_shelf
FOREIGN KEY (album_id)
REFERENCES album(album_id);

ALTER TABLE album_shelf
ADD CONSTRAINT fk_shelf_id_album_shelf
FOREIGN KEY (shelf_id)
REFERENCES shelf(shelf_id);


-- single shelf--
create table single_shelf (
single_id number not null,
shelf_id number not null,
constraint pk_single_shelf primary key (single_id, shelf_id)
);

ALTER TABLE single_shelf
ADD CONSTRAINT fk_single_id_single_shelf
FOREIGN KEY (single_id)
REFERENCES singles(single_id);

ALTER TABLE single_shelf
ADD CONSTRAINT fk_shelf_id_single_shelf
FOREIGN KEY (shelf_id)
REFERENCES shelf(shelf_id);

-- feat album song--

create table feat_album_song (
singer_id number not null,
album_song_id number not null,
constraint pk_feat_album_song primary key (singer_id, album_song_id)
);

ALTER TABLE feat_album_song
ADD CONSTRAINT fk_feat_album_song_singer_id
FOREIGN KEY (singer_id)
REFERENCES singer(singer_id);

ALTER TABLE feat_album_song
ADD CONSTRAINT fk_feat_album_song_album_song_id
FOREIGN KEY (album_song_id)
REFERENCES album_song(album_song_id);


--feat single --

create table feat_single (
singer_id number not null,
single_id number not null,
constraint pk_feat_feat_single primary key (singer_id, single_id)
);

ALTER TABLE feat_single
ADD CONSTRAINT fk_feat_single_singer_id
FOREIGN KEY (singer_id)
REFERENCES singer(singer_id);

ALTER TABLE feat_single
ADD CONSTRAINT fk_feat_single_single_id
FOREIGN KEY (single_id)
REFERENCES singles(single_id);

-- album physical form --

create table album_physical_form (
physical_form_id number not null,
album_id number not null,
constraint pk_album_physical_form primary key (physical_form_id, album_id)
);

ALTER TABLE album_physical_form
ADD CONSTRAINT fk_album_physical_form_physical_form_id
FOREIGN KEY (physical_form_id)
REFERENCES physical_form(physical_form_id);


ALTER TABLE album_physical_form
ADD CONSTRAINT fk_album_physical_form_album_id
FOREIGN KEY (album_id)
REFERENCES album(album_id);

-- single physical form --

create table single_physical_form (
physical_form_id number not null,
single_id number not null,
constraint pk_single_physical_form primary key (physical_form_id, single_id)
);

ALTER TABLE single_physical_form
ADD CONSTRAINT fk_single_physical_form_physical_form_id
FOREIGN KEY (physical_form_id)
REFERENCES physical_form(physical_form_id);


ALTER TABLE single_physical_form
ADD CONSTRAINT fk_single_physical_form_single_id
FOREIGN KEY (single_id)
REFERENCES singles(single_id);

-- album album song--
create table album_album_song (
album_id number not null,
album_song_id number not null,
constraint pk_album_album_song primary key (album_id, album_song_id)
);

ALTER TABLE album_album_song
ADD CONSTRAINT fk_album_album_song_album_id
FOREIGN KEY (album_id)
REFERENCES album(album_id);


ALTER TABLE album_album_song
ADD CONSTRAINT fk_album_album_song_form_album_song_id
FOREIGN KEY (album_song_id)
REFERENCES album_song(album_song_id);
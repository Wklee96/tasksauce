DROP TABLE IF EXISTS public.users CASCADE;
DROP TABLE IF EXISTS job_request CASCADE;
DROP TABLE IF EXISTS job_offer CASCADE;
drop table if exists OFFER_BIDS cascade;
drop table if exists REQUESt_BIDS cascade;

CREATE TABLE public.users (
	"username" CHAR(64),
	"email" CHAR(128),
	"password" CHAR(60),
	CONSTRAINT users_pkey PRIMARY KEY (username)
);


CREATE TABLE job_request (
	"job" CHAR(64),
	"loc" CHAR(128),
	"date" DATE,
	"var" TIME,
	"desc" CHAR(128),
	"user" CHAR (64) references public.users(username),
	"job_id" int generated by default as identity primary key
);



CREATE TABLE request_bids(
	"job_id" int references job_request(job_id),
	"bid_user" char(64) references public.users(username),
	"bid_price" int,
	"bid_info" char(1000),
	"bid_id" int generated by default as identity primary key
);


CREATE TABLE job_offer (
	"job" CHAR(64),
	"loc" CHAR(128),
	"date" DATE,
	"var" TIME,
	"desc" CHAR(128),
	"user" CHAR (128),
	"job_id" int generated by default as identity primary key
);

CREATE TABLE offer_bids(
	"job_id" int references job_request(job_id),
	"bid_user" char(64) references public.users(username),
	"bid_price" int,
	"bid_info" char(1000),
	"bid_id" int generated by default as identity primary key
);

-- relation set between job req and request bids
CREATE TABLE request_in_progress(
	"job_id" int references job_request(job_id),
	"bid_id" int references request_bids(bid_id),
	primary key (job_id, bid_id)
);

-- relation set between job offer and offer bids
CREATE TABLE offer_in_progress(
	"job_id" int references job_offer(job_id),
	"bid_id" int references offer_bids(bid_id)
	primary key (job_id, bid_id)
);

-- relation set between job req and completed
CREATE TABLE request_completed(
	"job_id" int references job_request(job_id),
	"bid_id" int references request_bids(bid_id),
	primary key (job_id, bid_id)
);

-- relation set between job offer and completed
CREATE TABLE offer_completed(
	"job_id" int references job_offer(job_id),
	"bid_id" int references offer_bids(bid_id)
	primary key (job_id, bid_id)
);

INSERT INTO public.users (username, email, password)
VALUES ('dummy1','dummy1@yahoo.com','$2b$10$99cAtaDvYXFAJCMOqGavCuML5dCdlDYZoAEYfwVXu/ASZpKiAGPnS');
 INSERT INTO public.users (username, email, password)
VALUES ('dummy2','dummy2@yahoo.com','$2b$10$99cAtaDvYXFAJCMOqGavCuDrC4GADX0PaHFJ8M08gTnAsBiE2LCwW');

INSERT INTO job_request ("job", "loc", "date", "var", "desc","user") 
VALUES ('Babysitting', 'AMK', '2019-08-13', '05:30', 'Look after 4yo','dummy1');
INSERT INTO job_request ("job", "loc", "date", "var", "desc","user") 
VALUES ('Gardening', 'TPY', '2019-08-15', '08:30', 'Rebuild my backyard','dummy2');
INSERT INTO job_request ("job", "loc", "date", "var", "desc","user") 
VALUES ('Cooking', 'JE', '2019-08-25', '18:30', 'Cook dinner for family of 5','dummy1');
INSERT INTO job_request ("job", "loc", "date", "var", "desc","user") 
VALUES ('Delivery', 'KR', '2019-12-01', '12:30', 'Deliver parcel from Changi to Kent Ridge','dummy1');
INSERT INTO job_request ("job", "loc", "date", "var", "desc","user") 
VALUES ('Food Delivery', 'KR', '2019-12-01', '18:30', 'Deliver food from Atlas Cafe to NUS','dummy1');

INSERT INTO job_offer ("job", "loc", "date", "var", "desc","user") 
VALUES ('Assemble Furniture', 'AMK', '2019-08-05', '16:30', 'Help to assemble IKEA book shelf','dummy1');
INSERT INTO job_offer ("job", "loc", "date", "var", "desc","user") 
VALUES ('Drive', 'CMW', '2019-08-19', '08:30', 'Drive me to Changi Airport','dummy1');
INSERT INTO job_offer ("job", "loc", "date", "var", "desc","user") 
VALUES ('Babysitting', 'BG', '2019-08-25', '19:00', 'Look after my 3yo','dummy2');
INSERT INTO job_offer ("job", "loc", "date", "var", "desc","user") 
VALUES ('Delivery', 'KR', '2019-12-01', '12:30', 'Deliver parcel from Jurong East to Kent Ridge','dummy2');
insert into REQUEST_BIDS values ('1','dummy1','1','tested bid')
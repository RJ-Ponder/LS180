--
-- PostgreSQL database dump
-- the command line command: pg_dump business -t weather --inserts > dump.sql
-- without --inserts, the data will be inserted via copy from stdin
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: weather; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE TABLE weather (
    date date NOT NULL,
    low integer NOT NULL,
    high integer NOT NULL,
    rainfall numeric(6,3) DEFAULT 0
);


ALTER TABLE public.weather OWNER TO "ec2-user";

--
-- Data for Name: weather; Type: TABLE DATA; Schema: public; Owner: ec2-user
--

INSERT INTO weather VALUES ('2016-03-07', 29, 32, 0.000);
INSERT INTO weather VALUES ('2016-03-08', 23, 31, 0.000);
INSERT INTO weather VALUES ('2016-03-09', 17, 28, 0.000);
INSERT INTO weather VALUES ('2016-03-01', 34, 43, 0.118);
INSERT INTO weather VALUES ('2016-03-02', 32, 44, 0.118);
INSERT INTO weather VALUES ('2016-03-03', 31, 47, 0.157);
INSERT INTO weather VALUES ('2016-03-04', 33, 42, 0.079);
INSERT INTO weather VALUES ('2016-03-05', 39, 46, 0.276);
INSERT INTO weather VALUES ('2016-03-06', 32, 43, 0.079);


--
-- PostgreSQL database dump complete
--


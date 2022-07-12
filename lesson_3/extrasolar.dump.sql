--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: 
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

--
-- Name: spectral_type_enum; Type: TYPE; Schema: public; Owner: ec2-user
--

CREATE TYPE spectral_type_enum AS ENUM (
    'O',
    'B',
    'A',
    'F',
    'G',
    'K',
    'M'
);


ALTER TYPE public.spectral_type_enum OWNER TO "ec2-user";

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: moons; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE TABLE moons (
    id integer NOT NULL,
    designation integer NOT NULL,
    semi_major_axis numeric,
    mass numeric,
    planet_id integer,
    CONSTRAINT moons_designation_check CHECK ((designation > 0)),
    CONSTRAINT moons_mass_check CHECK ((mass > 0.0)),
    CONSTRAINT moons_semi_major_axis_check CHECK ((semi_major_axis > 0.0))
);


ALTER TABLE public.moons OWNER TO "ec2-user";

--
-- Name: moons_id_seq; Type: SEQUENCE; Schema: public; Owner: ec2-user
--

CREATE SEQUENCE moons_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.moons_id_seq OWNER TO "ec2-user";

--
-- Name: moons_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ec2-user
--

ALTER SEQUENCE moons_id_seq OWNED BY moons.id;


--
-- Name: planets; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE TABLE planets (
    id integer NOT NULL,
    designation character(1) NOT NULL,
    mass numeric NOT NULL,
    star_id integer NOT NULL,
    semi_major_axis numeric NOT NULL,
    CONSTRAINT planets_mass_check CHECK ((mass > 0.0))
);


ALTER TABLE public.planets OWNER TO "ec2-user";

--
-- Name: planets_id_seq; Type: SEQUENCE; Schema: public; Owner: ec2-user
--

CREATE SEQUENCE planets_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.planets_id_seq OWNER TO "ec2-user";

--
-- Name: planets_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ec2-user
--

ALTER SEQUENCE planets_id_seq OWNED BY planets.id;


--
-- Name: stars; Type: TABLE; Schema: public; Owner: ec2-user; Tablespace: 
--

CREATE TABLE stars (
    id integer NOT NULL,
    name character varying(50) NOT NULL,
    distance numeric NOT NULL,
    companions integer NOT NULL,
    spectral_type spectral_type_enum NOT NULL,
    CONSTRAINT stars_companions_check CHECK ((companions >= 0)),
    CONSTRAINT stars_distance_check CHECK ((distance > (0)::numeric))
);


ALTER TABLE public.stars OWNER TO "ec2-user";

--
-- Name: stars_id_seq; Type: SEQUENCE; Schema: public; Owner: ec2-user
--

CREATE SEQUENCE stars_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.stars_id_seq OWNER TO "ec2-user";

--
-- Name: stars_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: ec2-user
--

ALTER SEQUENCE stars_id_seq OWNED BY stars.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ec2-user
--

ALTER TABLE ONLY moons ALTER COLUMN id SET DEFAULT nextval('moons_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ec2-user
--

ALTER TABLE ONLY planets ALTER COLUMN id SET DEFAULT nextval('planets_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: ec2-user
--

ALTER TABLE ONLY stars ALTER COLUMN id SET DEFAULT nextval('stars_id_seq'::regclass);


--
-- Data for Name: moons; Type: TABLE DATA; Schema: public; Owner: ec2-user
--



--
-- Name: moons_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ec2-user
--

SELECT pg_catalog.setval('moons_id_seq', 1, false);


--
-- Data for Name: planets; Type: TABLE DATA; Schema: public; Owner: ec2-user
--

INSERT INTO planets VALUES (1, 'b', 0.0036, 13, 0.04);
INSERT INTO planets VALUES (2, 'c', 0.1, 14, 40);


--
-- Name: planets_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ec2-user
--

SELECT pg_catalog.setval('planets_id_seq', 2, true);


--
-- Data for Name: stars; Type: TABLE DATA; Schema: public; Owner: ec2-user
--

INSERT INTO stars VALUES (13, 'Alpha Centauri B', 4.37, 3, 'K');
INSERT INTO stars VALUES (14, 'Epsilon Eridani', 10.5, 0, 'K');


--
-- Name: stars_id_seq; Type: SEQUENCE SET; Schema: public; Owner: ec2-user
--

SELECT pg_catalog.setval('stars_id_seq', 14, true);


--
-- Name: moons_pkey; Type: CONSTRAINT; Schema: public; Owner: ec2-user; Tablespace: 
--

ALTER TABLE ONLY moons
    ADD CONSTRAINT moons_pkey PRIMARY KEY (id);


--
-- Name: planets_designation_key; Type: CONSTRAINT; Schema: public; Owner: ec2-user; Tablespace: 
--

ALTER TABLE ONLY planets
    ADD CONSTRAINT planets_designation_key UNIQUE (designation);


--
-- Name: planets_pkey; Type: CONSTRAINT; Schema: public; Owner: ec2-user; Tablespace: 
--

ALTER TABLE ONLY planets
    ADD CONSTRAINT planets_pkey PRIMARY KEY (id);


--
-- Name: stars_name_key; Type: CONSTRAINT; Schema: public; Owner: ec2-user; Tablespace: 
--

ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_name_key UNIQUE (name);


--
-- Name: stars_pkey; Type: CONSTRAINT; Schema: public; Owner: ec2-user; Tablespace: 
--

ALTER TABLE ONLY stars
    ADD CONSTRAINT stars_pkey PRIMARY KEY (id);


--
-- Name: moons_planet_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ec2-user
--

ALTER TABLE ONLY moons
    ADD CONSTRAINT moons_planet_id_fkey FOREIGN KEY (planet_id) REFERENCES planets(id);


--
-- Name: planets_star_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: ec2-user
--

ALTER TABLE ONLY planets
    ADD CONSTRAINT planets_star_id_fkey FOREIGN KEY (star_id) REFERENCES stars(id);


--
-- Name: public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA public FROM PUBLIC;
REVOKE ALL ON SCHEMA public FROM postgres;
GRANT ALL ON SCHEMA public TO postgres;
GRANT ALL ON SCHEMA public TO PUBLIC;


--
-- PostgreSQL database dump complete
--


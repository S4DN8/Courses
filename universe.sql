--
-- PostgreSQL database dump
--

-- Dumped from database version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)
-- Dumped by pg_dump version 12.17 (Ubuntu 12.17-1.pgdg22.04+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

DROP DATABASE universe;
--
-- Name: universe; Type: DATABASE; Schema: -; Owner: freecodecamp
--

CREATE DATABASE universe WITH TEMPLATE = template0 ENCODING = 'UTF8' LC_COLLATE = 'C.UTF-8' LC_CTYPE = 'C.UTF-8';


ALTER DATABASE universe OWNER TO freecodecamp;

\connect universe

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: explorer; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.explorer (
    explorer_id integer NOT NULL,
    name character varying(50) NOT NULL,
    country character varying(50) NOT NULL,
    age integer NOT NULL,
    discoveries_count integer NOT NULL,
    is_active boolean NOT NULL,
    experience_years numeric(4,2) NOT NULL,
    biography text,
    CONSTRAINT explorer_age_check CHECK ((age > 0)),
    CONSTRAINT explorer_discoveries_count_check CHECK ((discoveries_count >= 0)),
    CONSTRAINT explorer_experience_years_check CHECK ((experience_years >= (0)::numeric))
);


ALTER TABLE public.explorer OWNER TO freecodecamp;

--
-- Name: explorer_explorer_id_seq; Type: SEQUENCE; Schema: public; Owner: freecodecamp
--

CREATE SEQUENCE public.explorer_explorer_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.explorer_explorer_id_seq OWNER TO freecodecamp;

--
-- Name: explorer_explorer_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: freecodecamp
--

ALTER SEQUENCE public.explorer_explorer_id_seq OWNED BY public.explorer.explorer_id;


--
-- Name: galaxy; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.galaxy (
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    galaxy_type character varying(30) NOT NULL,
    galaxy_age_in_billions_of_years numeric(4,2) NOT NULL,
    galaxy_distance_from_earth numeric(4,2) NOT NULL
);


ALTER TABLE public.galaxy OWNER TO freecodecamp;

--
-- Name: moon; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.moon (
    moon_id integer NOT NULL,
    planet_id integer NOT NULL,
    name character varying(30) NOT NULL,
    moon_is_spherical boolean NOT NULL,
    moon_has_life boolean NOT NULL,
    moon_temperature_in_celsius integer NOT NULL
);


ALTER TABLE public.moon OWNER TO freecodecamp;

--
-- Name: planet; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.planet (
    planet_id integer NOT NULL,
    star_id integer NOT NULL,
    name character varying(30) NOT NULL,
    planet_type character varying(30) NOT NULL,
    planet_temperature_in_celsius integer NOT NULL,
    planet_has_life boolean NOT NULL,
    planet_amount_of_moon integer NOT NULL,
    planet_description text
);


ALTER TABLE public.planet OWNER TO freecodecamp;

--
-- Name: star; Type: TABLE; Schema: public; Owner: freecodecamp
--

CREATE TABLE public.star (
    star_id integer NOT NULL,
    galaxy_id integer NOT NULL,
    name character varying(30) NOT NULL,
    star_type character varying(30) NOT NULL,
    star_age_in_billions_of_years numeric(4,2) NOT NULL,
    star_temperature_in_celsius integer NOT NULL,
    star_amount_of_planets integer NOT NULL
);


ALTER TABLE public.star OWNER TO freecodecamp;

--
-- Name: explorer explorer_id; Type: DEFAULT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.explorer ALTER COLUMN explorer_id SET DEFAULT nextval('public.explorer_explorer_id_seq'::regclass);


--
-- Data for Name: explorer; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.explorer VALUES (1, 'Carl Sagan', 'USA', 62, 5, false, 40.50, 'Famous astrophysicist and science communicator.');
INSERT INTO public.explorer VALUES (2, 'Galileo Galilei', 'Italy', 77, 12, false, 50.00, 'Pioneer of modern observational astronomy.');
INSERT INTO public.explorer VALUES (3, 'Vera Rubin', 'USA', 88, 8, false, 45.30, 'Discovered evidence of dark matter.');


--
-- Data for Name: galaxy; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.galaxy VALUES (1, 'Milky Way', 'Spiral', 13.60, 0.00);
INSERT INTO public.galaxy VALUES (2, 'Andromeda', 'Spiral', 10.00, 2.50);
INSERT INTO public.galaxy VALUES (3, 'Triangulum', 'Spiral', 12.00, 3.00);
INSERT INTO public.galaxy VALUES (4, 'Sombrero', 'Lenticular', 9.00, 29.00);
INSERT INTO public.galaxy VALUES (5, 'Pinwheel', 'Spiral', 11.50, 21.00);
INSERT INTO public.galaxy VALUES (6, 'Black Eye', 'Spiral', 11.00, 17.00);


--
-- Data for Name: moon; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.moon VALUES (1, 1, 'Moon', true, false, -20);
INSERT INTO public.moon VALUES (2, 2, 'Phobos', false, false, -40);
INSERT INTO public.moon VALUES (3, 2, 'Deimos', false, false, -50);
INSERT INTO public.moon VALUES (4, 3, 'Europa', true, true, -160);
INSERT INTO public.moon VALUES (5, 3, 'Ganymede', true, true, -150);
INSERT INTO public.moon VALUES (6, 3, 'Callisto', true, false, -140);
INSERT INTO public.moon VALUES (7, 3, 'Io', true, false, -130);
INSERT INTO public.moon VALUES (8, 4, 'Titan', true, true, -180);
INSERT INTO public.moon VALUES (9, 4, 'Enceladus', true, true, -200);
INSERT INTO public.moon VALUES (10, 5, 'Charon', true, false, -220);
INSERT INTO public.moon VALUES (11, 6, 'Triton', true, false, -235);
INSERT INTO public.moon VALUES (12, 6, 'Miranda', true, false, -210);
INSERT INTO public.moon VALUES (13, 7, 'Ariel', true, false, -200);
INSERT INTO public.moon VALUES (14, 7, 'Oberon', true, false, -190);
INSERT INTO public.moon VALUES (15, 8, 'Titania', true, false, -180);
INSERT INTO public.moon VALUES (16, 9, 'Prometheus', false, false, -170);
INSERT INTO public.moon VALUES (17, 9, 'Pandora', false, false, -160);
INSERT INTO public.moon VALUES (18, 10, 'Haumea', true, false, -140);
INSERT INTO public.moon VALUES (19, 11, 'Makemake', true, false, -130);
INSERT INTO public.moon VALUES (20, 12, 'Eris', true, false, -220);


--
-- Data for Name: planet; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.planet VALUES (1, 1, 'Earth', 'Terrestrial', 15, true, 1, 'Only known habitable planet');
INSERT INTO public.planet VALUES (2, 1, 'Mars', 'Terrestrial', -60, false, 2, 'Has ice caps and signs of water');
INSERT INTO public.planet VALUES (3, 1, 'Jupiter', 'Gas Giant', -110, false, 79, 'Largest planet in the Solar System');
INSERT INTO public.planet VALUES (4, 1, 'Saturn', 'Gas Giant', -140, false, 83, 'Has magnificent ice rings');
INSERT INTO public.planet VALUES (5, 2, 'HD 209458 b', 'Gas Giant', 1000, false, 0, 'First exoplanet with detected atmosphere');
INSERT INTO public.planet VALUES (6, 2, 'Gliese 581 d', 'Terrestrial', -40, true, 1, 'In the habitable zone of its star');
INSERT INTO public.planet VALUES (7, 3, 'Kepler-22b', 'Super-Earth', 22, true, 2, 'Possibly has a liquid ocean');
INSERT INTO public.planet VALUES (8, 3, 'Proxima b', 'Terrestrial', -39, true, 0, 'In the habitable zone of Proxima Centauri');
INSERT INTO public.planet VALUES (9, 4, 'WASP-12b', 'Gas Giant', 2500, false, 0, 'Atmosphere is evaporating');
INSERT INTO public.planet VALUES (10, 4, 'Trappist-1d', 'Terrestrial', 19, true, 1, 'One of the Trappist-1 planets');
INSERT INTO public.planet VALUES (11, 5, 'Trappist-1e', 'Terrestrial', 5, true, 1, 'May have liquid water');
INSERT INTO public.planet VALUES (12, 6, '55 Cancri e', 'Super-Earth', 2000, false, 0, 'Surface possibly covered in lava');


--
-- Data for Name: star; Type: TABLE DATA; Schema: public; Owner: freecodecamp
--

INSERT INTO public.star VALUES (1, 1, 'Sun', 'Yellow Dwarf', 4.60, 5500, 8);
INSERT INTO public.star VALUES (2, 1, 'Procyon', 'White Dwarf', 2.70, 6500, 3);
INSERT INTO public.star VALUES (3, 2, 'Aldebaran', 'Red Giant', 6.40, 3900, 4);
INSERT INTO public.star VALUES (4, 3, 'Vega', 'Blue-White Dwarf', 0.45, 9600, 2);
INSERT INTO public.star VALUES (5, 4, 'Betelgeuse', 'Red Supergiant', 8.00, 3500, 3);
INSERT INTO public.star VALUES (6, 5, 'Antares', 'Red Supergiant', 12.00, 3200, 2);


--
-- Name: explorer_explorer_id_seq; Type: SEQUENCE SET; Schema: public; Owner: freecodecamp
--

SELECT pg_catalog.setval('public.explorer_explorer_id_seq', 3, true);


--
-- Name: explorer explorer_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.explorer
    ADD CONSTRAINT explorer_id UNIQUE (explorer_id);


--
-- Name: explorer explorer_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.explorer
    ADD CONSTRAINT explorer_pkey PRIMARY KEY (explorer_id);


--
-- Name: galaxy galaxy_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_id UNIQUE (galaxy_id);


--
-- Name: galaxy galaxy_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.galaxy
    ADD CONSTRAINT galaxy_pkey PRIMARY KEY (galaxy_id);


--
-- Name: moon moon_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_id UNIQUE (moon_id);


--
-- Name: moon moon_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT moon_pkey PRIMARY KEY (moon_id);


--
-- Name: planet planet_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_id UNIQUE (planet_id);


--
-- Name: planet planet_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT planet_pkey PRIMARY KEY (planet_id);


--
-- Name: star star_id; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_id UNIQUE (star_id);


--
-- Name: star star_pkey; Type: CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT star_pkey PRIMARY KEY (star_id);


--
-- Name: star galaxy_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.star
    ADD CONSTRAINT galaxy_id FOREIGN KEY (galaxy_id) REFERENCES public.galaxy(galaxy_id);


--
-- Name: moon planet_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.moon
    ADD CONSTRAINT planet_id FOREIGN KEY (planet_id) REFERENCES public.planet(planet_id);


--
-- Name: planet star_id; Type: FK CONSTRAINT; Schema: public; Owner: freecodecamp
--

ALTER TABLE ONLY public.planet
    ADD CONSTRAINT star_id FOREIGN KEY (star_id) REFERENCES public.star(star_id);


--
-- PostgreSQL database dump complete
--


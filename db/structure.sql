--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: bikes; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE bikes (
    id integer NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    in_use boolean DEFAULT false,
    station_id integer,
    uuid character varying(255) NOT NULL,
    registration_id character varying(255),
    name character varying(255)
);


--
-- Name: bikes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE bikes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: bikes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE bikes_id_seq OWNED BY bikes.id;


--
-- Name: operators; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE operators (
    id integer NOT NULL,
    authentication_token character varying(255),
    approved boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    uid character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    provider character varying(255),
    url character varying(255)
);


--
-- Name: operators_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE operators_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: operators_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE operators_id_seq OWNED BY operators.id;


--
-- Name: rates; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rates (
    id integer NOT NULL,
    name character varying(255),
    price numeric,
    closed_at timestamp without time zone
);


--
-- Name: rates_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rates_id_seq OWNED BY rates.id;


--
-- Name: rents; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE rents (
    id integer NOT NULL,
    bike_id integer,
    user_id integer,
    openned_at timestamp without time zone,
    closed_at timestamp without time zone,
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    terminal_station_id integer,
    starting_station_id integer NOT NULL,
    rate_id integer
);


--
-- Name: rents_history; Type: VIEW; Schema: public; Owner: -
--

CREATE VIEW rents_history AS
 SELECT count(*) AS count,
    all_rents.station_id,
    array_agg(all_rents.id) AS rents_ids,
    ((date_trunc('day'::text, ((all_rents.closed_at)::timestamp with time zone - '00:00:00'::interval)) + '00:00:00'::interval))::date AS day
   FROM ( SELECT rents.closed_at,
            rents.id,
            rents.terminal_station_id AS station_id
           FROM rents
        UNION
         SELECT rents.closed_at,
            rents.id,
            rents.starting_station_id AS station_id
           FROM rents) all_rents
  WHERE (all_rents.closed_at IS NOT NULL)
  GROUP BY ((date_trunc('day'::text, ((all_rents.closed_at)::timestamp with time zone - '00:00:00'::interval)) + '00:00:00'::interval))::date, all_rents.station_id;


--
-- Name: rents_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE rents_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: rents_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE rents_id_seq OWNED BY rents.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE schema_migrations (
    version character varying(255) NOT NULL
);


--
-- Name: stations; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE stations (
    id integer NOT NULL,
    latitude numeric,
    longitude numeric,
    name character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    gates_count integer DEFAULT 0 NOT NULL
);


--
-- Name: stations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE stations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: stations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE stations_id_seq OWNED BY stations.id;


--
-- Name: users; Type: TABLE; Schema: public; Owner: -; Tablespace: 
--

CREATE TABLE users (
    id integer NOT NULL,
    name character varying(255),
    surname character varying(255),
    created_at timestamp without time zone,
    updated_at timestamp without time zone,
    photo character varying(255)
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE users_id_seq OWNED BY users.id;


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY bikes ALTER COLUMN id SET DEFAULT nextval('bikes_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY operators ALTER COLUMN id SET DEFAULT nextval('operators_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rates ALTER COLUMN id SET DEFAULT nextval('rates_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY rents ALTER COLUMN id SET DEFAULT nextval('rents_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY stations ALTER COLUMN id SET DEFAULT nextval('stations_id_seq'::regclass);


--
-- Name: id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY users ALTER COLUMN id SET DEFAULT nextval('users_id_seq'::regclass);


--
-- Name: bikes_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY bikes
    ADD CONSTRAINT bikes_pkey PRIMARY KEY (id);


--
-- Name: operators_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY operators
    ADD CONSTRAINT operators_pkey PRIMARY KEY (id);


--
-- Name: rates_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rates
    ADD CONSTRAINT rates_pkey PRIMARY KEY (id);


--
-- Name: rents_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY rents
    ADD CONSTRAINT rents_pkey PRIMARY KEY (id);


--
-- Name: stations_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY stations
    ADD CONSTRAINT stations_pkey PRIMARY KEY (id);


--
-- Name: users_pkey; Type: CONSTRAINT; Schema: public; Owner: -; Tablespace: 
--

ALTER TABLE ONLY users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: index_operators_on_authentication_token; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX index_operators_on_authentication_token ON operators USING btree (authentication_token);


--
-- Name: index_rents_on_bike_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rents_on_bike_id ON rents USING btree (bike_id);


--
-- Name: index_rents_on_user_id; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE INDEX index_rents_on_user_id ON rents USING btree (user_id);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -; Tablespace: 
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user",public;

INSERT INTO schema_migrations (version) VALUES ('20140730051429');

INSERT INTO schema_migrations (version) VALUES ('20140730051657');

INSERT INTO schema_migrations (version) VALUES ('20140730052024');

INSERT INTO schema_migrations (version) VALUES ('20140731052018');

INSERT INTO schema_migrations (version) VALUES ('20140731055337');

INSERT INTO schema_migrations (version) VALUES ('20140731055457');

INSERT INTO schema_migrations (version) VALUES ('20140731061305');

INSERT INTO schema_migrations (version) VALUES ('20140801034518');

INSERT INTO schema_migrations (version) VALUES ('20140805053932');

INSERT INTO schema_migrations (version) VALUES ('20140806103254');

INSERT INTO schema_migrations (version) VALUES ('20140806154105');

INSERT INTO schema_migrations (version) VALUES ('20140808054843');

INSERT INTO schema_migrations (version) VALUES ('20140812035819');

INSERT INTO schema_migrations (version) VALUES ('20140813060032');

INSERT INTO schema_migrations (version) VALUES ('20140813061024');

INSERT INTO schema_migrations (version) VALUES ('20140813062656');

INSERT INTO schema_migrations (version) VALUES ('20140814061813');


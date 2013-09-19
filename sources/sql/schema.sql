--
-- PostgreSQL database dump
--

SET statement_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;

--
-- Name: transfo; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA transfo;


ALTER SCHEMA transfo OWNER TO postgres;

--
-- Name: SCHEMA transfo; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA transfo IS 'standard public schema';


SET search_path = transfo, pg_catalog;

--
-- Name: winding; Type: TYPE; Schema: transfo; Owner: greg
--

CREATE TYPE winding AS (
	voltage numeric(5,1),
	current numeric(5,3)
);


ALTER TYPE transfo.winding OWNER TO greg;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: ei_dimension; Type: TABLE; Schema: transfo; Owner: greg; Tablespace: 
--

CREATE TABLE ei_dimension (
    ei_dimension_id integer NOT NULL,
    reference character varying NOT NULL,
    len_a integer NOT NULL,
    len_b integer NOT NULL,
    len_c integer NOT NULL,
    diameter numeric(2,1) NOT NULL,
    average_h integer NOT NULL
);


ALTER TABLE transfo.ei_dimension OWNER TO greg;

--
-- Name: ei_dimension_ei_dimension_id_seq; Type: SEQUENCE; Schema: transfo; Owner: greg
--

CREATE SEQUENCE ei_dimension_ei_dimension_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE transfo.ei_dimension_ei_dimension_id_seq OWNER TO greg;

--
-- Name: ei_dimension_ei_dimension_id_seq; Type: SEQUENCE OWNED BY; Schema: transfo; Owner: greg
--

ALTER SEQUENCE ei_dimension_ei_dimension_id_seq OWNED BY ei_dimension.ei_dimension_id;


--
-- Name: transformer; Type: TABLE; Schema: transfo; Owner: greg; Tablespace: 
--

CREATE TABLE transformer (
    transformer_reference character varying NOT NULL,
    ei_dimension_id integer NOT NULL,
    weight numeric(3,1) NOT NULL,
    notes character varying[],
    height integer,
    description hstore
);


ALTER TABLE transfo.transformer OWNER TO greg;

--
-- Name: transformer_opt_pp; Type: TABLE; Schema: transfo; Owner: greg; Tablespace: 
--

CREATE TABLE transformer_opt_pp (
    pri_ldc numeric(3,2) NOT NULL,
    power integer NOT NULL,
    z_pri integer NOT NULL,
    z_secs integer[] NOT NULL,
    flo integer NOT NULL,
    fhi integer NOT NULL,
    ul numeric(2,0)
)
INHERITS (transformer);
ALTER TABLE ONLY transformer_opt_pp ALTER COLUMN height SET NOT NULL;


ALTER TABLE transfo.transformer_opt_pp OWNER TO greg;

--
-- Name: transformer_opt_se; Type: TABLE; Schema: transfo; Owner: greg; Tablespace: 
--

CREATE TABLE transformer_opt_se (
    pri_ldc numeric(3,2) NOT NULL,
    power integer NOT NULL,
    z_pri integer NOT NULL,
    z_secs integer[] NOT NULL,
    flo integer NOT NULL,
    fhi integer NOT NULL
)
INHERITS (transformer);
ALTER TABLE ONLY transformer_opt_se ALTER COLUMN height SET NOT NULL;


ALTER TABLE transfo.transformer_opt_se OWNER TO greg;

--
-- Name: transformer_psu; Type: TABLE; Schema: transfo; Owner: greg; Tablespace: 
--

CREATE TABLE transformer_psu (
    power integer NOT NULL,
    pri winding NOT NULL,
    secs winding[] NOT NULL
)
INHERITS (transformer);
ALTER TABLE ONLY transformer_psu ALTER COLUMN height SET NOT NULL;


ALTER TABLE transfo.transformer_psu OWNER TO greg;

--
-- Name: transformer_self; Type: TABLE; Schema: transfo; Owner: greg; Tablespace: 
--

CREATE TABLE transformer_self (
    pri winding NOT NULL,
    inductance numeric(5,3) NOT NULL
)
INHERITS (transformer);
ALTER TABLE ONLY transformer_self ALTER COLUMN height SET NOT NULL;


ALTER TABLE transfo.transformer_self OWNER TO greg;

--
-- Name: ei_dimension_id; Type: DEFAULT; Schema: transfo; Owner: greg
--

ALTER TABLE ONLY ei_dimension ALTER COLUMN ei_dimension_id SET DEFAULT nextval('ei_dimension_ei_dimension_id_seq'::regclass);


--
-- Name: ei_dimension_pkey; Type: CONSTRAINT; Schema: transfo; Owner: greg; Tablespace: 
--

ALTER TABLE ONLY ei_dimension
    ADD CONSTRAINT ei_dimension_pkey PRIMARY KEY (ei_dimension_id);


--
-- Name: transformer_opt_pp_pkey; Type: CONSTRAINT; Schema: transfo; Owner: greg; Tablespace: 
--

ALTER TABLE ONLY transformer_opt_pp
    ADD CONSTRAINT transformer_opt_pp_pkey PRIMARY KEY (transformer_reference);


--
-- Name: transformer_opt_se_pkey; Type: CONSTRAINT; Schema: transfo; Owner: greg; Tablespace: 
--

ALTER TABLE ONLY transformer_opt_se
    ADD CONSTRAINT transformer_opt_se_pkey PRIMARY KEY (transformer_reference);


--
-- Name: transformer_psu_pk; Type: CONSTRAINT; Schema: transfo; Owner: greg; Tablespace: 
--

ALTER TABLE ONLY transformer_psu
    ADD CONSTRAINT transformer_psu_pk PRIMARY KEY (transformer_reference);


--
-- Name: transformer_self_pk; Type: CONSTRAINT; Schema: transfo; Owner: greg; Tablespace: 
--

ALTER TABLE ONLY transformer_self
    ADD CONSTRAINT transformer_self_pk PRIMARY KEY (transformer_reference);


--
-- Name: ei_dimension_fk; Type: FK CONSTRAINT; Schema: transfo; Owner: greg
--

ALTER TABLE ONLY transformer_self
    ADD CONSTRAINT ei_dimension_fk FOREIGN KEY (ei_dimension_id) REFERENCES ei_dimension(ei_dimension_id);


--
-- Name: ei_dimension_fk; Type: FK CONSTRAINT; Schema: transfo; Owner: greg
--

ALTER TABLE ONLY transformer_psu
    ADD CONSTRAINT ei_dimension_fk FOREIGN KEY (ei_dimension_id) REFERENCES ei_dimension(ei_dimension_id);


--
-- Name: transformer_ei_dimension_id_fkey; Type: FK CONSTRAINT; Schema: transfo; Owner: greg
--

ALTER TABLE ONLY transformer
    ADD CONSTRAINT transformer_ei_dimension_id_fkey FOREIGN KEY (ei_dimension_id) REFERENCES ei_dimension(ei_dimension_id);


--
-- Name: transformer_opt_pp_ei_dimension_id_fkey; Type: FK CONSTRAINT; Schema: transfo; Owner: greg
--

ALTER TABLE ONLY transformer_opt_pp
    ADD CONSTRAINT transformer_opt_pp_ei_dimension_id_fkey FOREIGN KEY (ei_dimension_id) REFERENCES ei_dimension(ei_dimension_id);


--
-- Name: transformer_opt_se_ei_dimension_id_fkey; Type: FK CONSTRAINT; Schema: transfo; Owner: greg
--

ALTER TABLE ONLY transformer_opt_se
    ADD CONSTRAINT transformer_opt_se_ei_dimension_id_fkey FOREIGN KEY (ei_dimension_id) REFERENCES ei_dimension(ei_dimension_id);


--
-- Name: transfo; Type: ACL; Schema: -; Owner: postgres
--

REVOKE ALL ON SCHEMA transfo FROM PUBLIC;
REVOKE ALL ON SCHEMA transfo FROM postgres;
GRANT ALL ON SCHEMA transfo TO postgres;
GRANT ALL ON SCHEMA transfo TO PUBLIC;


--
-- PostgreSQL database dump complete
--


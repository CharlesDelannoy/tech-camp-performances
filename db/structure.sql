\restrict zEHETtRyPDGjPzncbwlz7IFoPvs1mKBWh9Qx84EWckzaBUMdF8BQM8cc5mwNpbX

-- Dumped from database version 15.8
-- Dumped by pg_dump version 17.6

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
-- Name: agenda_notes; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agenda_notes (
    id bigint NOT NULL,
    note text,
    agenda_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL,
    done boolean DEFAULT false,
    is_urgent boolean DEFAULT false
);


--
-- Name: agenda_notes_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agenda_notes_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agenda_notes_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agenda_notes_id_seq OWNED BY public.agenda_notes.id;


--
-- Name: agendas; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.agendas (
    id bigint NOT NULL,
    name character varying,
    organization_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: agendas_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.agendas_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: agendas_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.agendas_id_seq OWNED BY public.agendas.id;


--
-- Name: appointments; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.appointments (
    id bigint NOT NULL,
    start_date timestamp(6) without time zone,
    end_date timestamp(6) without time zone,
    agenda_id bigint NOT NULL,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: appointments_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.appointments_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: appointments_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.appointments_id_seq OWNED BY public.appointments.id;


--
-- Name: ar_internal_metadata; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.ar_internal_metadata (
    key character varying NOT NULL,
    value character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: import_files; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.import_files (
    id bigint NOT NULL,
    filename character varying,
    normalized_content text,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: import_files_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.import_files_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: import_files_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.import_files_id_seq OWNED BY public.import_files.id;


--
-- Name: organizations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.organizations (
    id bigint NOT NULL,
    name character varying,
    created_at timestamp(6) without time zone NOT NULL,
    updated_at timestamp(6) without time zone NOT NULL
);


--
-- Name: organizations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.organizations_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: organizations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.organizations_id_seq OWNED BY public.organizations.id;


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying NOT NULL
);


--
-- Name: agenda_notes id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenda_notes ALTER COLUMN id SET DEFAULT nextval('public.agenda_notes_id_seq'::regclass);


--
-- Name: agendas id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendas ALTER COLUMN id SET DEFAULT nextval('public.agendas_id_seq'::regclass);


--
-- Name: appointments id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments ALTER COLUMN id SET DEFAULT nextval('public.appointments_id_seq'::regclass);


--
-- Name: import_files id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.import_files ALTER COLUMN id SET DEFAULT nextval('public.import_files_id_seq'::regclass);


--
-- Name: organizations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations ALTER COLUMN id SET DEFAULT nextval('public.organizations_id_seq'::regclass);


--
-- Name: agenda_notes agenda_notes_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenda_notes
    ADD CONSTRAINT agenda_notes_pkey PRIMARY KEY (id);


--
-- Name: agendas agendas_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendas
    ADD CONSTRAINT agendas_pkey PRIMARY KEY (id);


--
-- Name: appointments appointments_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT appointments_pkey PRIMARY KEY (id);


--
-- Name: ar_internal_metadata ar_internal_metadata_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.ar_internal_metadata
    ADD CONSTRAINT ar_internal_metadata_pkey PRIMARY KEY (key);


--
-- Name: import_files import_files_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.import_files
    ADD CONSTRAINT import_files_pkey PRIMARY KEY (id);


--
-- Name: organizations organizations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.organizations
    ADD CONSTRAINT organizations_pkey PRIMARY KEY (id);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- Name: index_agenda_notes_on_agenda_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_agenda_notes_on_agenda_id ON public.agenda_notes USING btree (agenda_id);


--
-- Name: index_agendas_on_organization_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_agendas_on_organization_id ON public.agendas USING btree (organization_id);


--
-- Name: index_appointments_on_agenda_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_appointments_on_agenda_id ON public.appointments USING btree (agenda_id);


--
-- Name: index_appointments_on_agenda_id_and_start_date; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_appointments_on_agenda_id_and_start_date ON public.appointments USING btree (agenda_id, start_date);


--
-- Name: agendas fk_rails_3a141a9079; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agendas
    ADD CONSTRAINT fk_rails_3a141a9079 FOREIGN KEY (organization_id) REFERENCES public.organizations(id);


--
-- Name: appointments fk_rails_e62737ba49; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.appointments
    ADD CONSTRAINT fk_rails_e62737ba49 FOREIGN KEY (agenda_id) REFERENCES public.agendas(id);


--
-- Name: agenda_notes fk_rails_fbb4bf808d; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.agenda_notes
    ADD CONSTRAINT fk_rails_fbb4bf808d FOREIGN KEY (agenda_id) REFERENCES public.agendas(id);


--
-- PostgreSQL database dump complete
--

\unrestrict zEHETtRyPDGjPzncbwlz7IFoPvs1mKBWh9Qx84EWckzaBUMdF8BQM8cc5mwNpbX

SET search_path TO "$user", public;

INSERT INTO "schema_migrations" (version) VALUES
('20250925082059'),
('20250922150726'),
('20250922150442'),
('20250922085326'),
('20250922085316'),
('20250922085305'),
('20250922085255');


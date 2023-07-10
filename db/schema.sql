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

--
-- Name: api; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA api;


--
-- Name: get(character varying); Type: FUNCTION; Schema: api; Owner: -
--

CREATE FUNCTION api.get(key character varying) RETURNS record
    LANGUAGE sql IMMUTABLE SECURITY DEFINER
    AS $_$
  select "value"
  from "count"
  where "count"."key" = $1;
$_$;


--
-- Name: hit(character varying); Type: FUNCTION; Schema: api; Owner: -
--

CREATE FUNCTION api.hit(key character varying) RETURNS void
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
#variable_conflict use_column
<<fn>>
begin
  insert into "count" ("key", "value")
  values ($1, 1)
  on conflict ("key")
  do update
  set "value" = "count"."value" + 1;
end
$_$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: count; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.count (
    key character varying NOT NULL,
    value bigint DEFAULT 0 NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.schema_migrations (
    version character varying(128) NOT NULL
);


--
-- Name: count count_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.count
    ADD CONSTRAINT count_pkey PRIMARY KEY (key);


--
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- PostgreSQL database dump complete
--


--
-- Dbmate schema migrations
--

INSERT INTO public.schema_migrations (version) VALUES
    ('20230710151138');

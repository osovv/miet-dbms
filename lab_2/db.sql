-- Database generated with pgModeler (PostgreSQL Database Modeler).
-- pgModeler version: 0.9.4
-- PostgreSQL version: 13.0
-- Project Site: pgmodeler.io
-- Model Author: ---

-- Database creation must be performed outside a multi lined SQL file. 
-- These commands were put in this file only as a convenience.
-- 
-- object: miet_lab2 | type: DATABASE --
-- DROP DATABASE IF EXISTS miet_lab2;
CREATE DATABASE miet_lab2;
-- ddl-end --


-- object: public.users | type: TABLE --
-- DROP TABLE IF EXISTS public.users CASCADE;
CREATE TABLE public.users (
	uuid uuid NOT NULL,
	name varchar(20) NOT NULL,
	encrypted_password character varying NOT NULL,
	banned boolean NOT NULL DEFAULT false,
	permissions jsonb NOT NULL,
	requests_count bigint NOT NULL,
	CONSTRAINT users_pk_uuid PRIMARY KEY (uuid)
);
-- ddl-end --
ALTER TABLE public.users OWNER TO postgres;
-- ddl-end --

-- object: index_users_on_uuid | type: INDEX --
-- DROP INDEX IF EXISTS public.index_users_on_uuid CASCADE;
CREATE INDEX index_users_on_uuid ON public.users
USING btree
(
	uuid
);
-- ddl-end --

-- object: public.requests | type: TABLE --
-- DROP TABLE IF EXISTS public.requests CASCADE;
CREATE TABLE public.requests (
	uuid uuid NOT NULL,
	user_uuid uuid NOT NULL,
	song_artist character varying NOT NULL,
	song_name character varying NOT NULL,
	created_at timestamp NOT NULL,
	played_at timestamp,
	skipped boolean DEFAULT false,
	CONSTRAINT requests_pk_uuid PRIMARY KEY (uuid)
);
-- ddl-end --
ALTER TABLE public.requests OWNER TO postgres;
-- ddl-end --

-- object: index_requests_on_uuid | type: INDEX --
-- DROP INDEX IF EXISTS public.index_requests_on_uuid CASCADE;
CREATE INDEX index_requests_on_uuid ON public.requests
USING btree
(
	uuid
);
-- ddl-end --

-- object: index_requests_on_user_uuid | type: INDEX --
-- DROP INDEX IF EXISTS public.index_requests_on_user_uuid CASCADE;
CREATE INDEX index_requests_on_user_uuid ON public.requests
USING btree
(
	user_uuid
);
-- ddl-end --

-- object: index_requests_created_at | type: INDEX --
-- DROP INDEX IF EXISTS public.index_requests_created_at CASCADE;
CREATE INDEX index_requests_created_at ON public.requests
USING btree
(
	created_at
);
-- ddl-end --

-- object: requests_fk_user_uuid | type: CONSTRAINT --
-- ALTER TABLE public.requests DROP CONSTRAINT IF EXISTS requests_fk_user_uuid CASCADE;
ALTER TABLE public.requests ADD CONSTRAINT requests_fk_user_uuid FOREIGN KEY (user_uuid)
REFERENCES public.users (uuid) MATCH SIMPLE
ON DELETE NO ACTION ON UPDATE NO ACTION;
-- ddl-end --



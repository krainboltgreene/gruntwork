--
-- PostgreSQL database dump
--

-- Dumped from database version 9.5.2
-- Dumped by pg_dump version 9.5.2

SET statement_timeout = 0;
SET lock_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: plpgsql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;


--
-- Name: EXTENSION plpgsql; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION plpgsql IS 'PL/pgSQL procedural language';


--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET search_path = public, pg_catalog;

SET default_tablespace = '';

SET default_with_oids = false;

--
-- Name: accounts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE accounts (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    email character varying NOT NULL,
    encrypted_password character varying NOT NULL,
    reset_password_token character varying,
    reset_password_sent_at timestamp without time zone,
    remember_created_at timestamp without time zone,
    sign_in_count integer DEFAULT 0 NOT NULL,
    current_sign_in_at timestamp without time zone,
    last_sign_in_at timestamp without time zone,
    current_sign_in_ip inet,
    last_sign_in_ip inet,
    confirmation_token character varying,
    confirmed_at timestamp without time zone,
    confirmation_sent_at timestamp without time zone,
    unconfirmed_email character varying,
    watching boolean DEFAULT false NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE orders (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    description text NOT NULL,
    requester_id uuid,
    owner_id uuid,
    state character varying NOT NULL,
    subtype integer DEFAULT 0 NOT NULL,
    priority integer DEFAULT 0 NOT NULL,
    finished_at timestamp without time zone,
    canceled_at timestamp without time zone,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: responses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE responses (
    id uuid DEFAULT uuid_generate_v4() NOT NULL,
    order_id uuid NOT NULL,
    account_id uuid NOT NULL,
    message integer NOT NULL,
    created_at timestamp without time zone NOT NULL,
    updated_at timestamp without time zone NOT NULL
);


--
-- Name: schema_migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE schema_migrations (
    version character varying NOT NULL
);


--
-- Name: accounts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY accounts
    ADD CONSTRAINT accounts_pkey PRIMARY KEY (id);


--
-- Name: orders_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY orders
    ADD CONSTRAINT orders_pkey PRIMARY KEY (id);


--
-- Name: responses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY responses
    ADD CONSTRAINT responses_pkey PRIMARY KEY (id);


--
-- Name: index_accounts_on_confirmation_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_confirmation_token ON accounts USING btree (confirmation_token);


--
-- Name: index_accounts_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_created_at ON accounts USING btree (created_at);


--
-- Name: index_accounts_on_email; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX index_accounts_on_email ON accounts USING btree (email);


--
-- Name: index_accounts_on_reset_password_token; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_reset_password_token ON accounts USING btree (reset_password_token);


--
-- Name: index_accounts_on_unconfirmed_email; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_unconfirmed_email ON accounts USING btree (unconfirmed_email);


--
-- Name: index_accounts_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_accounts_on_updated_at ON accounts USING btree (updated_at);


--
-- Name: index_orders_on_canceled_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_canceled_at ON orders USING btree (canceled_at);


--
-- Name: index_orders_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_created_at ON orders USING btree (created_at);


--
-- Name: index_orders_on_finished_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_finished_at ON orders USING btree (finished_at);


--
-- Name: index_orders_on_owner_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_owner_id ON orders USING btree (owner_id);


--
-- Name: index_orders_on_priority; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_priority ON orders USING btree (priority);


--
-- Name: index_orders_on_requester_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_requester_id ON orders USING btree (requester_id);


--
-- Name: index_orders_on_state; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_state ON orders USING btree (state);


--
-- Name: index_orders_on_subtype; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_subtype ON orders USING btree (subtype);


--
-- Name: index_orders_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_orders_on_updated_at ON orders USING btree (updated_at);


--
-- Name: index_responses_on_account_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_responses_on_account_id ON responses USING btree (account_id);


--
-- Name: index_responses_on_created_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_responses_on_created_at ON responses USING btree (created_at);


--
-- Name: index_responses_on_message; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_responses_on_message ON responses USING btree (message);


--
-- Name: index_responses_on_order_id; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_responses_on_order_id ON responses USING btree (order_id);


--
-- Name: index_responses_on_updated_at; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX index_responses_on_updated_at ON responses USING btree (updated_at);


--
-- Name: unique_schema_migrations; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX unique_schema_migrations ON schema_migrations USING btree (version);


--
-- PostgreSQL database dump complete
--

SET search_path TO "$user", public;

INSERT INTO schema_migrations (version) VALUES ('20160518004514');

INSERT INTO schema_migrations (version) VALUES ('20160518004519');

INSERT INTO schema_migrations (version) VALUES ('20160518010242');

INSERT INTO schema_migrations (version) VALUES ('20160518061048');


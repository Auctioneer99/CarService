--
-- PostgreSQL database dump
--

-- Dumped from database version 14.4
-- Dumped by pg_dump version 14.2

-- Started on 2022-07-19 02:43:06

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

--DROP DATABASE carservice;
--
-- TOC entry 4256 (class 1262 OID 16384)
-- Name: carservice; Type: DATABASE; Schema: -; Owner: postgres
--

CREATE DATABASE carservice WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'en_US.utf8';


ALTER DATABASE carservice OWNER TO postgres;

\connect carservice

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
-- TOC entry 3 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

--CREATE SCHEMA public;


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4257 (class 0 OID 0)
-- Dependencies: 3
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS 'standard public schema';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 256 (class 1259 OID 17049)
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO postgres;

--
-- TOC entry 285 (class 1259 OID 17492)
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO postgres;

--
-- TOC entry 259 (class 1259 OID 17064)
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO postgres;

--
-- TOC entry 258 (class 1259 OID 17059)
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO postgres;

--
-- TOC entry 257 (class 1259 OID 17054)
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO postgres;

--
-- TOC entry 260 (class 1259 OID 17069)
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO postgres;

--
-- TOC entry 286 (class 1259 OID 17507)
-- Name: broker_link; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16430)
-- Name: client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16788)
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO postgres;

--
-- TOC entry 297 (class 1259 OID 17756)
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO postgres;

--
-- TOC entry 296 (class 1259 OID 17631)
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO postgres;

--
-- TOC entry 242 (class 1259 OID 16798)
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO postgres;

--
-- TOC entry 274 (class 1259 OID 17297)
-- Name: client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO postgres;

--
-- TOC entry 275 (class 1259 OID 17311)
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO postgres;

--
-- TOC entry 298 (class 1259 OID 17797)
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO postgres;

--
-- TOC entry 276 (class 1259 OID 17316)
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16441)
-- Name: client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO postgres;

--
-- TOC entry 263 (class 1259 OID 17087)
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO postgres;

--
-- TOC entry 241 (class 1259 OID 16793)
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO postgres;

--
-- TOC entry 255 (class 1259 OID 16971)
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16446)
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO postgres;

--
-- TOC entry 264 (class 1259 OID 17168)
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO postgres;

--
-- TOC entry 294 (class 1259 OID 17552)
-- Name: component; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO postgres;

--
-- TOC entry 293 (class 1259 OID 17547)
-- Name: component_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16449)
-- Name: composite_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16452)
-- Name: credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16422)
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO postgres;

--
-- TOC entry 215 (class 1259 OID 16417)
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO postgres;

--
-- TOC entry 299 (class 1259 OID 17813)
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16457)
-- Name: event_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO postgres;

--
-- TOC entry 287 (class 1259 OID 17512)
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO postgres;

--
-- TOC entry 288 (class 1259 OID 17517)
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO postgres;

--
-- TOC entry 301 (class 1259 OID 17839)
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO postgres;

--
-- TOC entry 289 (class 1259 OID 17526)
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO postgres;

--
-- TOC entry 290 (class 1259 OID 17535)
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO postgres;

--
-- TOC entry 291 (class 1259 OID 17538)
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO postgres;

--
-- TOC entry 292 (class 1259 OID 17544)
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO postgres;

--
-- TOC entry 245 (class 1259 OID 16834)
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO postgres;

--
-- TOC entry 295 (class 1259 OID 17609)
-- Name: federated_user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO postgres;

--
-- TOC entry 271 (class 1259 OID 17236)
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO postgres;

--
-- TOC entry 270 (class 1259 OID 17233)
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO postgres;

--
-- TOC entry 246 (class 1259 OID 16839)
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO postgres;

--
-- TOC entry 247 (class 1259 OID 16848)
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO postgres;

--
-- TOC entry 252 (class 1259 OID 16952)
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO postgres;

--
-- TOC entry 253 (class 1259 OID 16957)
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO postgres;

--
-- TOC entry 269 (class 1259 OID 17230)
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16465)
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO postgres;

--
-- TOC entry 210 (class 1259 OID 16386)
-- Name: logs; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.logs (
    id bigint NOT NULL,
    date timestamp without time zone,
    thread character varying(255),
    level character varying(20),
    logger character varying(255),
    log_user character varying(255),
    message character varying(4000),
    error character varying(2000)
);


ALTER TABLE public.logs OWNER TO postgres;

--
-- TOC entry 209 (class 1259 OID 16385)
-- Name: logs_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.logs ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.logs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 251 (class 1259 OID 16949)
-- Name: migration_model; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO postgres;

--
-- TOC entry 268 (class 1259 OID 17221)
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO postgres;

--
-- TOC entry 267 (class 1259 OID 17216)
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO postgres;

--
-- TOC entry 281 (class 1259 OID 17435)
-- Name: policy_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO postgres;

--
-- TOC entry 243 (class 1259 OID 16823)
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO postgres;

--
-- TOC entry 244 (class 1259 OID 16829)
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16471)
-- Name: realm; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16488)
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO postgres;

--
-- TOC entry 273 (class 1259 OID 17245)
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO postgres;

--
-- TOC entry 250 (class 1259 OID 16941)
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16496)
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO postgres;

--
-- TOC entry 306 (class 1259 OID 17947)
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16499)
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16506)
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO postgres;

--
-- TOC entry 248 (class 1259 OID 16857)
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16516)
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO postgres;

--
-- TOC entry 266 (class 1259 OID 17180)
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO postgres;

--
-- TOC entry 265 (class 1259 OID 17173)
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO postgres;

--
-- TOC entry 303 (class 1259 OID 17878)
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO postgres;

--
-- TOC entry 283 (class 1259 OID 17462)
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO postgres;

--
-- TOC entry 282 (class 1259 OID 17447)
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO postgres;

--
-- TOC entry 277 (class 1259 OID 17385)
-- Name: resource_server; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO postgres;

--
-- TOC entry 302 (class 1259 OID 17854)
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO postgres;

--
-- TOC entry 280 (class 1259 OID 17421)
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO postgres;

--
-- TOC entry 278 (class 1259 OID 17393)
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO postgres;

--
-- TOC entry 279 (class 1259 OID 17407)
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO postgres;

--
-- TOC entry 304 (class 1259 OID 17896)
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO postgres;

--
-- TOC entry 305 (class 1259 OID 17906)
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16519)
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO postgres;

--
-- TOC entry 284 (class 1259 OID 17477)
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO postgres;

--
-- TOC entry 212 (class 1259 OID 16394)
-- Name: transports; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transports (
    id bigint NOT NULL,
    number character varying(9) NOT NULL,
    model character varying(32) NOT NULL,
    owner_id character varying NOT NULL
);


ALTER TABLE public.transports OWNER TO postgres;

--
-- TOC entry 211 (class 1259 OID 16393)
-- Name: transports_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.transports ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.transports_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 232 (class 1259 OID 16525)
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO postgres;

--
-- TOC entry 254 (class 1259 OID 16962)
-- Name: user_consent; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO postgres;

--
-- TOC entry 300 (class 1259 OID 17829)
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16530)
-- Name: user_entity; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16538)
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO postgres;

--
-- TOC entry 261 (class 1259 OID 17074)
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO postgres;

--
-- TOC entry 262 (class 1259 OID 17079)
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16543)
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO postgres;

--
-- TOC entry 272 (class 1259 OID 17242)
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16548)
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16551)
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16554)
-- Name: user_session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO postgres;

--
-- TOC entry 249 (class 1259 OID 16860)
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16522)
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO postgres;

--
-- TOC entry 307 (class 1259 OID 32975)
-- Name: userview; Type: VIEW; Schema: public; Owner: postgres
--

CREATE VIEW public.userview AS
 SELECT k_user.id,
    k_role.realm_id AS realm,
    k_role.name AS role,
    (((k_user.first_name)::text || ' '::text) || (k_user.last_name)::text) AS name
   FROM ((public.keycloak_role k_role
     JOIN public.user_role_mapping role_map ON (((role_map.role_id)::text = (k_role.id)::text)))
     JOIN public.user_entity k_user ON (((role_map.user_id)::text = (k_user.id)::text)))
  WHERE ((k_role.realm_id)::text = 'd4586994-289c-4313-8f41-4aa5d69533be'::text);


ALTER TABLE public.userview OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16565)
-- Name: web_origins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO postgres;

--
-- TOC entry 214 (class 1259 OID 16404)
-- Name: works; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.works (
    id bigint NOT NULL,
    transport_id bigint NOT NULL,
    executor_id character varying(36) NOT NULL,
    perform_date timestamp without time zone NOT NULL,
    return_date timestamp without time zone,
    price double precision NOT NULL,
    mileage double precision NOT NULL,
    task character varying(1000) NOT NULL
);


ALTER TABLE public.works OWNER TO postgres;

--
-- TOC entry 213 (class 1259 OID 16403)
-- Name: works_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

ALTER TABLE public.works ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public.works_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 4200 (class 0 OID 17049)
-- Dependencies: 256
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- TOC entry 4229 (class 0 OID 17492)
-- Dependencies: 285
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
\.


--
-- TOC entry 4203 (class 0 OID 17064)
-- Dependencies: 259
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
4430be8f-9173-4c1f-b474-7206a2ccdadd	\N	auth-cookie	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	5973d417-62ca-4183-b800-a2b1963ab903	2	10	f	\N	\N
d4ce51d6-c186-4f95-ab08-f4eaf8b0adcd	\N	auth-spnego	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	5973d417-62ca-4183-b800-a2b1963ab903	3	20	f	\N	\N
6e175855-3e5f-4ed3-9f61-03ea049170a9	\N	identity-provider-redirector	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	5973d417-62ca-4183-b800-a2b1963ab903	2	25	f	\N	\N
dbb48241-97af-4840-aec0-d36e710e52ac	\N	\N	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	5973d417-62ca-4183-b800-a2b1963ab903	2	30	t	29909bff-bfa2-4b5c-9cfe-d7f8218673be	\N
ed196829-059f-485f-be9b-1038c6249ba1	\N	auth-username-password-form	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	29909bff-bfa2-4b5c-9cfe-d7f8218673be	0	10	f	\N	\N
b7275038-abdd-4903-8d0a-3ff9caf56319	\N	\N	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	29909bff-bfa2-4b5c-9cfe-d7f8218673be	1	20	t	5d78d45e-9ad7-4a3a-a0fe-5c191109851e	\N
3f7518d7-7a12-48ec-8d0d-909b4ef016cc	\N	conditional-user-configured	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	5d78d45e-9ad7-4a3a-a0fe-5c191109851e	0	10	f	\N	\N
254a94f5-1487-4f2d-b818-abdb29279857	\N	auth-otp-form	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	5d78d45e-9ad7-4a3a-a0fe-5c191109851e	0	20	f	\N	\N
fe14fba5-e497-4bde-99c1-371ecbc0e0ab	\N	direct-grant-validate-username	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	eefe599b-73a7-41e9-9958-d525cd636eb8	0	10	f	\N	\N
6a9c8ac5-3be1-4884-ad2f-3de1a4547b94	\N	direct-grant-validate-password	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	eefe599b-73a7-41e9-9958-d525cd636eb8	0	20	f	\N	\N
b4e018e9-72fa-4145-b77a-a05a028470f8	\N	\N	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	eefe599b-73a7-41e9-9958-d525cd636eb8	1	30	t	7c004216-6819-4277-8f92-9cb5d4a127bf	\N
ea1ebbb0-0eea-45d4-8b4b-e5e0b6b072f6	\N	conditional-user-configured	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	7c004216-6819-4277-8f92-9cb5d4a127bf	0	10	f	\N	\N
01bdde07-4619-47a2-be43-0d2618bbd1c4	\N	direct-grant-validate-otp	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	7c004216-6819-4277-8f92-9cb5d4a127bf	0	20	f	\N	\N
98059393-7257-441b-ac53-4ba77444dc90	\N	registration-page-form	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	65315acc-ca8d-4924-b4ca-652a4ca31b8e	0	10	t	01c5a63a-52b3-4202-a301-0d7368d69423	\N
8df70848-1f7e-4ec2-81f5-10845d5c86b9	\N	registration-user-creation	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	01c5a63a-52b3-4202-a301-0d7368d69423	0	20	f	\N	\N
c247f3f4-60ea-4b9d-9118-24b9ba6aa824	\N	registration-profile-action	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	01c5a63a-52b3-4202-a301-0d7368d69423	0	40	f	\N	\N
82beb7a0-72af-483f-8c71-e1b019525007	\N	registration-password-action	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	01c5a63a-52b3-4202-a301-0d7368d69423	0	50	f	\N	\N
0d2dd87b-3448-458d-90cd-bf41f0f4d786	\N	registration-recaptcha-action	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	01c5a63a-52b3-4202-a301-0d7368d69423	3	60	f	\N	\N
3b3c6d60-2c68-4786-9727-3ca497a454bf	\N	reset-credentials-choose-user	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	02b0ca33-c680-443e-afd2-fb8af5f66144	0	10	f	\N	\N
b45e029b-4174-4c49-9d0c-eb877e40315b	\N	reset-credential-email	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	02b0ca33-c680-443e-afd2-fb8af5f66144	0	20	f	\N	\N
d2fa591a-1fab-4e29-8e1a-15bc0bf7c932	\N	reset-password	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	02b0ca33-c680-443e-afd2-fb8af5f66144	0	30	f	\N	\N
5d44926f-13c2-40fd-a77b-d6b77f172aa5	\N	\N	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	02b0ca33-c680-443e-afd2-fb8af5f66144	1	40	t	54d18b10-307a-4439-911d-e2e158f0e7a3	\N
04dda3d0-244f-4f88-9203-d507eb08fbc6	\N	conditional-user-configured	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	54d18b10-307a-4439-911d-e2e158f0e7a3	0	10	f	\N	\N
27d783b2-da25-4913-936a-2965128b1109	\N	reset-otp	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	54d18b10-307a-4439-911d-e2e158f0e7a3	0	20	f	\N	\N
75b9889b-2b53-41f3-8ff4-bd6b02ed5b67	\N	client-secret	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	4bda9bab-b271-406e-9830-954114e9e52c	2	10	f	\N	\N
a7e7fb6d-f3eb-4a5f-ad82-ca8f25fa4a10	\N	client-jwt	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	4bda9bab-b271-406e-9830-954114e9e52c	2	20	f	\N	\N
7d4acc64-1955-4533-9e66-98f0c81710f1	\N	client-secret-jwt	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	4bda9bab-b271-406e-9830-954114e9e52c	2	30	f	\N	\N
eba923cd-0aaf-4184-b95b-779e4f8477eb	\N	client-x509	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	4bda9bab-b271-406e-9830-954114e9e52c	2	40	f	\N	\N
da9d05dc-e2e6-4797-b796-0a18c69f53cf	\N	idp-review-profile	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	0543bd92-81bb-4d70-93a8-9215c6e1c8bf	0	10	f	\N	479e0cb0-43f4-47be-a88f-c958bdb82925
74678344-658a-4580-870b-6d1f783042a9	\N	\N	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	0543bd92-81bb-4d70-93a8-9215c6e1c8bf	0	20	t	4b1abaf8-6055-45e6-a43f-13e9b0160472	\N
7fe37778-9156-4216-bf87-a866c2a2e803	\N	idp-create-user-if-unique	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	4b1abaf8-6055-45e6-a43f-13e9b0160472	2	10	f	\N	69c6b50f-6323-4c54-b81e-4314cfd2efeb
c1226046-a0f5-45d6-af67-b9716b66a8b4	\N	\N	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	4b1abaf8-6055-45e6-a43f-13e9b0160472	2	20	t	f2a2b560-7c8b-4715-8d4c-9122d793423f	\N
a490fd3e-e23d-4846-87a5-0ec7b8de1589	\N	idp-confirm-link	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	f2a2b560-7c8b-4715-8d4c-9122d793423f	0	10	f	\N	\N
55de5519-edcc-4076-8256-af94300ebd17	\N	\N	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	f2a2b560-7c8b-4715-8d4c-9122d793423f	0	20	t	16db66d0-6262-439d-957a-a27f63f9fffb	\N
970453d8-eb80-4cbb-9c6e-c3f772756d69	\N	idp-email-verification	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	16db66d0-6262-439d-957a-a27f63f9fffb	2	10	f	\N	\N
a8a9028f-8d44-4c10-b006-0827bdff30bb	\N	\N	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	16db66d0-6262-439d-957a-a27f63f9fffb	2	20	t	75a803a5-0a25-4497-9cd3-fcf244d1b8fe	\N
7e678936-1cdd-44a4-af4f-b46054506e9f	\N	idp-username-password-form	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	75a803a5-0a25-4497-9cd3-fcf244d1b8fe	0	10	f	\N	\N
f1554a4f-0342-471d-ac89-112d8e98f97f	\N	\N	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	75a803a5-0a25-4497-9cd3-fcf244d1b8fe	1	20	t	bdbb29c2-58ea-4130-a6fe-283aed3d8ffd	\N
b8730dda-7771-42e8-a813-b96e6d7e75aa	\N	conditional-user-configured	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	bdbb29c2-58ea-4130-a6fe-283aed3d8ffd	0	10	f	\N	\N
d2c06e15-267d-4ecd-bb9a-887524358202	\N	auth-otp-form	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	bdbb29c2-58ea-4130-a6fe-283aed3d8ffd	0	20	f	\N	\N
5abf9fec-381d-4827-a655-49d94cfac284	\N	http-basic-authenticator	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	d9b2a870-fb28-4891-a93e-5570352e20fa	0	10	f	\N	\N
f6e5fc34-6c40-41f1-9e60-50ca172b1eab	\N	docker-http-basic-authenticator	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	316291ef-36fb-4d92-a675-fc834014f520	0	10	f	\N	\N
fa0ae9a6-0ef7-4a4a-81bb-cc5b01663977	\N	no-cookie-redirect	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	304e9d11-8366-43c9-aba2-1ccffd9a6dc1	0	10	f	\N	\N
1187470a-719e-42d3-98c4-43fe957563e5	\N	\N	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	304e9d11-8366-43c9-aba2-1ccffd9a6dc1	0	20	t	6df607e6-5537-4f80-aadd-b558d6151050	\N
305e123c-db35-43a1-90dd-3e29dd2c0f02	\N	basic-auth	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	6df607e6-5537-4f80-aadd-b558d6151050	0	10	f	\N	\N
be48d5e5-10c6-4413-831a-d93a425c6ada	\N	basic-auth-otp	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	6df607e6-5537-4f80-aadd-b558d6151050	3	20	f	\N	\N
aedb02ac-4c0c-4e2b-8475-c7371fcc3459	\N	auth-spnego	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	6df607e6-5537-4f80-aadd-b558d6151050	3	30	f	\N	\N
347be164-8a83-4cf5-8695-02aea9d63d82	\N	auth-cookie	d4586994-289c-4313-8f41-4aa5d69533be	3911a3e4-12fc-49cd-9688-d5f36f590de2	2	10	f	\N	\N
0247a829-023e-48f7-be74-43d991d1fdce	\N	auth-spnego	d4586994-289c-4313-8f41-4aa5d69533be	3911a3e4-12fc-49cd-9688-d5f36f590de2	3	20	f	\N	\N
4faab11f-1024-4c81-9047-429808af5035	\N	identity-provider-redirector	d4586994-289c-4313-8f41-4aa5d69533be	3911a3e4-12fc-49cd-9688-d5f36f590de2	2	25	f	\N	\N
a956e6fa-07b4-4815-9958-13e3dde6a02c	\N	\N	d4586994-289c-4313-8f41-4aa5d69533be	3911a3e4-12fc-49cd-9688-d5f36f590de2	2	30	t	bd8ee874-3ad6-4531-a45c-0a1cc7566890	\N
5a6722f7-aecd-4b86-aea1-41eb91d5ab25	\N	auth-username-password-form	d4586994-289c-4313-8f41-4aa5d69533be	bd8ee874-3ad6-4531-a45c-0a1cc7566890	0	10	f	\N	\N
861899eb-6eaf-4bc3-b2ef-ebf00c30e05e	\N	\N	d4586994-289c-4313-8f41-4aa5d69533be	bd8ee874-3ad6-4531-a45c-0a1cc7566890	1	20	t	b3837911-bdb3-4e91-8afd-ea6a35d5fea6	\N
1800e21c-a777-4761-af15-beaf3432ac6f	\N	conditional-user-configured	d4586994-289c-4313-8f41-4aa5d69533be	b3837911-bdb3-4e91-8afd-ea6a35d5fea6	0	10	f	\N	\N
368691bf-597e-4b2f-ab3b-a221eabd7180	\N	auth-otp-form	d4586994-289c-4313-8f41-4aa5d69533be	b3837911-bdb3-4e91-8afd-ea6a35d5fea6	0	20	f	\N	\N
034f7313-924f-42cb-8f5d-8fc1dd0cb167	\N	direct-grant-validate-username	d4586994-289c-4313-8f41-4aa5d69533be	3ad587d2-78d8-440a-9082-61fba32fbb04	0	10	f	\N	\N
66da0452-f00e-4ac7-a14b-e38f7d26f4a6	\N	direct-grant-validate-password	d4586994-289c-4313-8f41-4aa5d69533be	3ad587d2-78d8-440a-9082-61fba32fbb04	0	20	f	\N	\N
1d52cbcd-3c9d-4359-bcbb-a16744c96e57	\N	\N	d4586994-289c-4313-8f41-4aa5d69533be	3ad587d2-78d8-440a-9082-61fba32fbb04	1	30	t	123bc0aa-3dde-4e37-99c0-cd9a5f8eaf71	\N
bb4c4a35-09d4-4545-9371-786a68d434b2	\N	conditional-user-configured	d4586994-289c-4313-8f41-4aa5d69533be	123bc0aa-3dde-4e37-99c0-cd9a5f8eaf71	0	10	f	\N	\N
e2915a06-f043-475f-9c10-6cdfecea1d55	\N	direct-grant-validate-otp	d4586994-289c-4313-8f41-4aa5d69533be	123bc0aa-3dde-4e37-99c0-cd9a5f8eaf71	0	20	f	\N	\N
e0acfb33-0327-46b2-810a-927f4ca71b7e	\N	registration-page-form	d4586994-289c-4313-8f41-4aa5d69533be	d9b232d5-ca60-4e5c-8591-d603936ca8c2	0	10	t	48aedce4-c8f6-449c-824e-a32b385d2ad4	\N
917277b9-01db-4cc2-a700-1ce8267086cf	\N	registration-user-creation	d4586994-289c-4313-8f41-4aa5d69533be	48aedce4-c8f6-449c-824e-a32b385d2ad4	0	20	f	\N	\N
72bbce99-7fe2-4be9-89bb-16189e8bc75f	\N	registration-profile-action	d4586994-289c-4313-8f41-4aa5d69533be	48aedce4-c8f6-449c-824e-a32b385d2ad4	0	40	f	\N	\N
781cf550-b4da-4d4e-a256-9b3d6bb6f1c0	\N	registration-password-action	d4586994-289c-4313-8f41-4aa5d69533be	48aedce4-c8f6-449c-824e-a32b385d2ad4	0	50	f	\N	\N
862a483b-97fd-4c43-821d-6239f06ee90c	\N	registration-recaptcha-action	d4586994-289c-4313-8f41-4aa5d69533be	48aedce4-c8f6-449c-824e-a32b385d2ad4	3	60	f	\N	\N
e4d6ee2a-53d5-4d29-82d9-db2915ec1a1b	\N	reset-credentials-choose-user	d4586994-289c-4313-8f41-4aa5d69533be	57f8c2b6-ce0f-41a3-ad70-3bf1f13fcb85	0	10	f	\N	\N
29295013-e480-41bd-b961-b5ee60fe4a16	\N	reset-credential-email	d4586994-289c-4313-8f41-4aa5d69533be	57f8c2b6-ce0f-41a3-ad70-3bf1f13fcb85	0	20	f	\N	\N
0c78b2f2-4a79-4894-8dd2-d5d047a89a10	\N	reset-password	d4586994-289c-4313-8f41-4aa5d69533be	57f8c2b6-ce0f-41a3-ad70-3bf1f13fcb85	0	30	f	\N	\N
ccbe572c-27a4-4ea1-83f2-dbb7a8a2a862	\N	\N	d4586994-289c-4313-8f41-4aa5d69533be	57f8c2b6-ce0f-41a3-ad70-3bf1f13fcb85	1	40	t	3a325652-4539-420b-8430-fdea869cf559	\N
54d1dbbf-6be9-43ef-b44a-b366c5efbfcb	\N	conditional-user-configured	d4586994-289c-4313-8f41-4aa5d69533be	3a325652-4539-420b-8430-fdea869cf559	0	10	f	\N	\N
07d6c5af-c198-42e6-8bc5-0d03f68cd376	\N	reset-otp	d4586994-289c-4313-8f41-4aa5d69533be	3a325652-4539-420b-8430-fdea869cf559	0	20	f	\N	\N
6f56d757-77da-4e7e-9295-c0b27988ade1	\N	client-secret	d4586994-289c-4313-8f41-4aa5d69533be	35b4aa9a-690d-4f26-914a-4135c66214b4	2	10	f	\N	\N
2ca7eb02-bd96-4a43-890d-8d766e68b684	\N	client-jwt	d4586994-289c-4313-8f41-4aa5d69533be	35b4aa9a-690d-4f26-914a-4135c66214b4	2	20	f	\N	\N
a79ccf32-ae6b-48f6-bf38-86bb0c405c9b	\N	client-secret-jwt	d4586994-289c-4313-8f41-4aa5d69533be	35b4aa9a-690d-4f26-914a-4135c66214b4	2	30	f	\N	\N
559183ed-bd29-49d8-998c-0abd1075242f	\N	client-x509	d4586994-289c-4313-8f41-4aa5d69533be	35b4aa9a-690d-4f26-914a-4135c66214b4	2	40	f	\N	\N
7365c2dd-1806-41fc-ae3b-70790bbca30e	\N	idp-review-profile	d4586994-289c-4313-8f41-4aa5d69533be	0741e4b8-2995-4c23-9b8e-62fdcf0ce68a	0	10	f	\N	cbe6c36d-006b-4196-9b26-896ca0bba979
05174fc7-91a0-402b-a170-26103bb736f4	\N	\N	d4586994-289c-4313-8f41-4aa5d69533be	0741e4b8-2995-4c23-9b8e-62fdcf0ce68a	0	20	t	8994dcc5-46aa-48d0-9a71-5a97fdd22050	\N
c4311b4c-8621-459f-be69-8fd7e8b1b342	\N	idp-create-user-if-unique	d4586994-289c-4313-8f41-4aa5d69533be	8994dcc5-46aa-48d0-9a71-5a97fdd22050	2	10	f	\N	322c485e-45e0-4e9c-9f94-6bb5d7f0ca6a
c0ec2ef7-ddf6-4373-949c-d92ef1db98d2	\N	\N	d4586994-289c-4313-8f41-4aa5d69533be	8994dcc5-46aa-48d0-9a71-5a97fdd22050	2	20	t	4f465287-302c-41f0-bfa7-96dfc6916e7a	\N
521d6828-5ddf-4513-a4f5-eec875244e78	\N	idp-confirm-link	d4586994-289c-4313-8f41-4aa5d69533be	4f465287-302c-41f0-bfa7-96dfc6916e7a	0	10	f	\N	\N
e44155e6-54b2-4938-882a-fb7ff43797d3	\N	\N	d4586994-289c-4313-8f41-4aa5d69533be	4f465287-302c-41f0-bfa7-96dfc6916e7a	0	20	t	ec73fd29-8e80-4846-8c54-0431b2bd7965	\N
3eabd055-4bac-489e-921c-ce9332f18e85	\N	idp-email-verification	d4586994-289c-4313-8f41-4aa5d69533be	ec73fd29-8e80-4846-8c54-0431b2bd7965	2	10	f	\N	\N
03170878-d511-4a9d-a35b-869858c70d76	\N	\N	d4586994-289c-4313-8f41-4aa5d69533be	ec73fd29-8e80-4846-8c54-0431b2bd7965	2	20	t	833881c7-6ae9-4e16-91cc-7908b40357a1	\N
11b92604-4c3f-44d7-bfd6-011408533a0c	\N	idp-username-password-form	d4586994-289c-4313-8f41-4aa5d69533be	833881c7-6ae9-4e16-91cc-7908b40357a1	0	10	f	\N	\N
bc05b38e-2d6b-4015-a2ca-60d7a6a770d1	\N	\N	d4586994-289c-4313-8f41-4aa5d69533be	833881c7-6ae9-4e16-91cc-7908b40357a1	1	20	t	c4344d73-a7e2-41ac-9377-e697b093c794	\N
5d84b1f6-6404-4814-9151-b60f0d852b6c	\N	conditional-user-configured	d4586994-289c-4313-8f41-4aa5d69533be	c4344d73-a7e2-41ac-9377-e697b093c794	0	10	f	\N	\N
ebe095b5-fd0b-492b-965c-8cf2d669483c	\N	auth-otp-form	d4586994-289c-4313-8f41-4aa5d69533be	c4344d73-a7e2-41ac-9377-e697b093c794	0	20	f	\N	\N
1e2cef2b-446d-42ba-98c1-890dd25ee2c5	\N	http-basic-authenticator	d4586994-289c-4313-8f41-4aa5d69533be	2287e906-0170-4508-8cfb-ada01df3a0aa	0	10	f	\N	\N
3bce0442-2f9b-44e6-ad6d-1f403a30cab6	\N	docker-http-basic-authenticator	d4586994-289c-4313-8f41-4aa5d69533be	e651cfca-8901-40fc-88c3-d69af49c53e7	0	10	f	\N	\N
b18b8e40-2fc9-4c38-8b18-8179fe48c003	\N	no-cookie-redirect	d4586994-289c-4313-8f41-4aa5d69533be	19cf1bd8-6ba6-41b0-a4e5-52ec0ab83302	0	10	f	\N	\N
09606ac6-d171-46ae-91dc-d820533f3bb1	\N	\N	d4586994-289c-4313-8f41-4aa5d69533be	19cf1bd8-6ba6-41b0-a4e5-52ec0ab83302	0	20	t	be975d9d-8dfd-4656-9c29-cbee62437703	\N
8168e2c5-5e13-4729-9e68-bcdb4e29ec63	\N	basic-auth	d4586994-289c-4313-8f41-4aa5d69533be	be975d9d-8dfd-4656-9c29-cbee62437703	0	10	f	\N	\N
3a407935-1a9a-43c3-b5e6-923e391d3a80	\N	basic-auth-otp	d4586994-289c-4313-8f41-4aa5d69533be	be975d9d-8dfd-4656-9c29-cbee62437703	3	20	f	\N	\N
3982b75c-d936-4f88-873c-0540ed7bc4b2	\N	auth-spnego	d4586994-289c-4313-8f41-4aa5d69533be	be975d9d-8dfd-4656-9c29-cbee62437703	3	30	f	\N	\N
\.


--
-- TOC entry 4202 (class 0 OID 17059)
-- Dependencies: 258
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
5973d417-62ca-4183-b800-a2b1963ab903	browser	browser based authentication	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	t	t
29909bff-bfa2-4b5c-9cfe-d7f8218673be	forms	Username, password, otp and other auth forms.	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	f	t
5d78d45e-9ad7-4a3a-a0fe-5c191109851e	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	f	t
eefe599b-73a7-41e9-9958-d525cd636eb8	direct grant	OpenID Connect Resource Owner Grant	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	t	t
7c004216-6819-4277-8f92-9cb5d4a127bf	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	f	t
65315acc-ca8d-4924-b4ca-652a4ca31b8e	registration	registration flow	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	t	t
01c5a63a-52b3-4202-a301-0d7368d69423	registration form	registration form	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	form-flow	f	t
02b0ca33-c680-443e-afd2-fb8af5f66144	reset credentials	Reset credentials for a user if they forgot their password or something	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	t	t
54d18b10-307a-4439-911d-e2e158f0e7a3	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	f	t
4bda9bab-b271-406e-9830-954114e9e52c	clients	Base authentication for clients	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	client-flow	t	t
0543bd92-81bb-4d70-93a8-9215c6e1c8bf	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	t	t
4b1abaf8-6055-45e6-a43f-13e9b0160472	User creation or linking	Flow for the existing/non-existing user alternatives	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	f	t
f2a2b560-7c8b-4715-8d4c-9122d793423f	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	f	t
16db66d0-6262-439d-957a-a27f63f9fffb	Account verification options	Method with which to verity the existing account	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	f	t
75a803a5-0a25-4497-9cd3-fcf244d1b8fe	Verify Existing Account by Re-authentication	Reauthentication of existing account	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	f	t
bdbb29c2-58ea-4130-a6fe-283aed3d8ffd	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	f	t
d9b2a870-fb28-4891-a93e-5570352e20fa	saml ecp	SAML ECP Profile Authentication Flow	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	t	t
316291ef-36fb-4d92-a675-fc834014f520	docker auth	Used by Docker clients to authenticate against the IDP	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	t	t
304e9d11-8366-43c9-aba2-1ccffd9a6dc1	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	t	t
6df607e6-5537-4f80-aadd-b558d6151050	Authentication Options	Authentication options.	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	basic-flow	f	t
3911a3e4-12fc-49cd-9688-d5f36f590de2	browser	browser based authentication	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	t	t
bd8ee874-3ad6-4531-a45c-0a1cc7566890	forms	Username, password, otp and other auth forms.	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	f	t
b3837911-bdb3-4e91-8afd-ea6a35d5fea6	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	f	t
3ad587d2-78d8-440a-9082-61fba32fbb04	direct grant	OpenID Connect Resource Owner Grant	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	t	t
123bc0aa-3dde-4e37-99c0-cd9a5f8eaf71	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	f	t
d9b232d5-ca60-4e5c-8591-d603936ca8c2	registration	registration flow	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	t	t
48aedce4-c8f6-449c-824e-a32b385d2ad4	registration form	registration form	d4586994-289c-4313-8f41-4aa5d69533be	form-flow	f	t
57f8c2b6-ce0f-41a3-ad70-3bf1f13fcb85	reset credentials	Reset credentials for a user if they forgot their password or something	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	t	t
3a325652-4539-420b-8430-fdea869cf559	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	f	t
35b4aa9a-690d-4f26-914a-4135c66214b4	clients	Base authentication for clients	d4586994-289c-4313-8f41-4aa5d69533be	client-flow	t	t
0741e4b8-2995-4c23-9b8e-62fdcf0ce68a	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	t	t
8994dcc5-46aa-48d0-9a71-5a97fdd22050	User creation or linking	Flow for the existing/non-existing user alternatives	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	f	t
4f465287-302c-41f0-bfa7-96dfc6916e7a	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	f	t
ec73fd29-8e80-4846-8c54-0431b2bd7965	Account verification options	Method with which to verity the existing account	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	f	t
833881c7-6ae9-4e16-91cc-7908b40357a1	Verify Existing Account by Re-authentication	Reauthentication of existing account	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	f	t
c4344d73-a7e2-41ac-9377-e697b093c794	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	f	t
2287e906-0170-4508-8cfb-ada01df3a0aa	saml ecp	SAML ECP Profile Authentication Flow	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	t	t
e651cfca-8901-40fc-88c3-d69af49c53e7	docker auth	Used by Docker clients to authenticate against the IDP	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	t	t
19cf1bd8-6ba6-41b0-a4e5-52ec0ab83302	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	t	t
be975d9d-8dfd-4656-9c29-cbee62437703	Authentication Options	Authentication options.	d4586994-289c-4313-8f41-4aa5d69533be	basic-flow	f	t
\.


--
-- TOC entry 4201 (class 0 OID 17054)
-- Dependencies: 257
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
479e0cb0-43f4-47be-a88f-c958bdb82925	review profile config	04ff9ad3-2ef2-41cb-be23-7572497fc0d7
69c6b50f-6323-4c54-b81e-4314cfd2efeb	create unique user config	04ff9ad3-2ef2-41cb-be23-7572497fc0d7
cbe6c36d-006b-4196-9b26-896ca0bba979	review profile config	d4586994-289c-4313-8f41-4aa5d69533be
322c485e-45e0-4e9c-9f94-6bb5d7f0ca6a	create unique user config	d4586994-289c-4313-8f41-4aa5d69533be
\.


--
-- TOC entry 4204 (class 0 OID 17069)
-- Dependencies: 260
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
479e0cb0-43f4-47be-a88f-c958bdb82925	missing	update.profile.on.first.login
69c6b50f-6323-4c54-b81e-4314cfd2efeb	false	require.password.update.after.registration
322c485e-45e0-4e9c-9f94-6bb5d7f0ca6a	false	require.password.update.after.registration
cbe6c36d-006b-4196-9b26-896ca0bba979	missing	update.profile.on.first.login
\.


--
-- TOC entry 4230 (class 0 OID 17507)
-- Dependencies: 286
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 4161 (class 0 OID 16430)
-- Dependencies: 217
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	f	master-realm	0	f	\N	\N	t	\N	f	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
c75332da-5ed1-435c-b1d3-7581f2ea7db3	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7af5eb91-e11b-417c-bfb9-92f00598c4e1	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7177855c-bf32-4806-9a88-dc43b8e4ee5d	t	f	broker	0	f	\N	\N	t	\N	f	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d2e52539-218d-4e1d-b335-0713e225274a	t	f	admin-cli	0	t	\N	\N	f	\N	f	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
80e39e74-1dfd-4876-b008-9ddb11aaa585	t	f	CarService-realm	0	f	\N	\N	t	\N	f	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N	0	f	f	CarService Realm	f	client-secret	\N	\N	\N	t	f	f	f
0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	f	realm-management	0	f	\N	\N	t	\N	f	d4586994-289c-4313-8f41-4aa5d69533be	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
d2fa367e-e155-41d8-8392-c6b18eab5c67	t	f	account	0	t	\N	/realms/CarService/account/	f	\N	f	d4586994-289c-4313-8f41-4aa5d69533be	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
4bb9ceb1-bec4-41aa-9da8-e2be43657635	t	f	broker	0	f	\N	\N	t	\N	f	d4586994-289c-4313-8f41-4aa5d69533be	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
15bff922-9d6c-425a-b6e5-a0b17d0e8886	t	f	security-admin-console	0	t	\N	/admin/CarService/console/	f	\N	f	d4586994-289c-4313-8f41-4aa5d69533be	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
43de8d2c-b09c-4f53-9d95-49f0a9196ab3	t	f	admin-cli	0	t	\N	\N	f	\N	f	d4586994-289c-4313-8f41-4aa5d69533be	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	t	f	account-console	0	t	\N	/realms/CarService/account/	f	\N	f	d4586994-289c-4313-8f41-4aa5d69533be	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
fc797aba-a792-4450-9575-d92c74afb436	t	t	MainClient	0	t	\N		f		f	d4586994-289c-4313-8f41-4aa5d69533be	openid-connect	-1	t	f		f	client-secret			\N	t	f	t	f
\.


--
-- TOC entry 4184 (class 0 OID 16788)
-- Dependencies: 240
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
7af5eb91-e11b-417c-bfb9-92f00598c4e1	S256	pkce.code.challenge.method
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	S256	pkce.code.challenge.method
15bff922-9d6c-425a-b6e5-a0b17d0e8886	S256	pkce.code.challenge.method
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	S256	pkce.code.challenge.method
fc797aba-a792-4450-9575-d92c74afb436	false	oidc.ciba.grant.enabled
fc797aba-a792-4450-9575-d92c74afb436	false	display.on.consent.screen
fc797aba-a792-4450-9575-d92c74afb436	false	oauth2.device.authorization.grant.enabled
fc797aba-a792-4450-9575-d92c74afb436	true	backchannel.logout.session.required
fc797aba-a792-4450-9575-d92c74afb436	false	backchannel.logout.revoke.offline.tokens
\.


--
-- TOC entry 4241 (class 0 OID 17756)
-- Dependencies: 297
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- TOC entry 4240 (class 0 OID 17631)
-- Dependencies: 296
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- TOC entry 4186 (class 0 OID 16798)
-- Dependencies: 242
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- TOC entry 4218 (class 0 OID 17297)
-- Dependencies: 274
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
e6d8382e-711e-4358-a793-8d0410f135a6	offline_access	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	OpenID Connect built-in scope: offline_access	openid-connect
cf4be498-ee7b-4bf9-abed-1abc5f92f5b7	role_list	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	SAML role list	saml
80177194-b812-4b51-9849-39eb37680744	profile	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	OpenID Connect built-in scope: profile	openid-connect
37ba9270-2c13-40a6-af18-06d686f8032c	email	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	OpenID Connect built-in scope: email	openid-connect
8b82b699-f981-45c7-9c6c-d9397222e686	address	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	OpenID Connect built-in scope: address	openid-connect
02dcb303-0daa-48a4-8475-c75ad06c91d8	phone	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	OpenID Connect built-in scope: phone	openid-connect
f94047ac-8dad-4148-8005-1668cdaf0444	roles	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	OpenID Connect scope for add user roles to the access token	openid-connect
9c9cafdd-5ef6-4ea0-b213-294583e1262e	web-origins	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	OpenID Connect scope for add allowed web origins to the access token	openid-connect
e7179f97-906b-410c-9858-d914fc615640	microprofile-jwt	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	Microprofile - JWT built-in scope	openid-connect
edf46eac-11c1-41c5-ab5a-327d66e020d1	acr	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
7685c196-96f7-494a-ae77-9efee31e04dc	offline_access	d4586994-289c-4313-8f41-4aa5d69533be	OpenID Connect built-in scope: offline_access	openid-connect
5318f39c-b56c-4f9f-8e97-06e460b61133	role_list	d4586994-289c-4313-8f41-4aa5d69533be	SAML role list	saml
099a15a6-9981-4a44-ac7f-e005aa001921	profile	d4586994-289c-4313-8f41-4aa5d69533be	OpenID Connect built-in scope: profile	openid-connect
07752d66-7fd8-4f5c-8795-292739316af1	email	d4586994-289c-4313-8f41-4aa5d69533be	OpenID Connect built-in scope: email	openid-connect
0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	address	d4586994-289c-4313-8f41-4aa5d69533be	OpenID Connect built-in scope: address	openid-connect
47f023f0-a5b2-44da-b99c-b37beed3d275	phone	d4586994-289c-4313-8f41-4aa5d69533be	OpenID Connect built-in scope: phone	openid-connect
a6827cce-ece1-4723-9965-1dbf77c74a23	roles	d4586994-289c-4313-8f41-4aa5d69533be	OpenID Connect scope for add user roles to the access token	openid-connect
aaed53ea-4c85-4c8f-a4bb-37acafdebce5	web-origins	d4586994-289c-4313-8f41-4aa5d69533be	OpenID Connect scope for add allowed web origins to the access token	openid-connect
5570ac38-49c1-4ae6-bb7a-0196acb085d2	microprofile-jwt	d4586994-289c-4313-8f41-4aa5d69533be	Microprofile - JWT built-in scope	openid-connect
d31b676c-cadd-4f9b-ae8a-76f1f235cf45	acr	d4586994-289c-4313-8f41-4aa5d69533be	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
f3059e34-6775-4cb3-a0ad-5b80647993c3	MainClintRoles	d4586994-289c-4313-8f41-4aa5d69533be		openid-connect
0cbf88f4-3051-45b9-83d0-9c364d0b911a	MainClientAud	d4586994-289c-4313-8f41-4aa5d69533be		openid-connect
c29c4562-fcd5-4c90-b245-8e47647e9fd2	INNscope	d4586994-289c-4313-8f41-4aa5d69533be		openid-connect
\.


--
-- TOC entry 4219 (class 0 OID 17311)
-- Dependencies: 275
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
e6d8382e-711e-4358-a793-8d0410f135a6	true	display.on.consent.screen
e6d8382e-711e-4358-a793-8d0410f135a6	${offlineAccessScopeConsentText}	consent.screen.text
cf4be498-ee7b-4bf9-abed-1abc5f92f5b7	true	display.on.consent.screen
cf4be498-ee7b-4bf9-abed-1abc5f92f5b7	${samlRoleListScopeConsentText}	consent.screen.text
80177194-b812-4b51-9849-39eb37680744	true	display.on.consent.screen
80177194-b812-4b51-9849-39eb37680744	${profileScopeConsentText}	consent.screen.text
80177194-b812-4b51-9849-39eb37680744	true	include.in.token.scope
37ba9270-2c13-40a6-af18-06d686f8032c	true	display.on.consent.screen
37ba9270-2c13-40a6-af18-06d686f8032c	${emailScopeConsentText}	consent.screen.text
37ba9270-2c13-40a6-af18-06d686f8032c	true	include.in.token.scope
8b82b699-f981-45c7-9c6c-d9397222e686	true	display.on.consent.screen
8b82b699-f981-45c7-9c6c-d9397222e686	${addressScopeConsentText}	consent.screen.text
8b82b699-f981-45c7-9c6c-d9397222e686	true	include.in.token.scope
02dcb303-0daa-48a4-8475-c75ad06c91d8	true	display.on.consent.screen
02dcb303-0daa-48a4-8475-c75ad06c91d8	${phoneScopeConsentText}	consent.screen.text
02dcb303-0daa-48a4-8475-c75ad06c91d8	true	include.in.token.scope
f94047ac-8dad-4148-8005-1668cdaf0444	true	display.on.consent.screen
f94047ac-8dad-4148-8005-1668cdaf0444	${rolesScopeConsentText}	consent.screen.text
f94047ac-8dad-4148-8005-1668cdaf0444	false	include.in.token.scope
9c9cafdd-5ef6-4ea0-b213-294583e1262e	false	display.on.consent.screen
9c9cafdd-5ef6-4ea0-b213-294583e1262e		consent.screen.text
9c9cafdd-5ef6-4ea0-b213-294583e1262e	false	include.in.token.scope
e7179f97-906b-410c-9858-d914fc615640	false	display.on.consent.screen
e7179f97-906b-410c-9858-d914fc615640	true	include.in.token.scope
edf46eac-11c1-41c5-ab5a-327d66e020d1	false	display.on.consent.screen
edf46eac-11c1-41c5-ab5a-327d66e020d1	false	include.in.token.scope
7685c196-96f7-494a-ae77-9efee31e04dc	true	display.on.consent.screen
7685c196-96f7-494a-ae77-9efee31e04dc	${offlineAccessScopeConsentText}	consent.screen.text
5318f39c-b56c-4f9f-8e97-06e460b61133	true	display.on.consent.screen
5318f39c-b56c-4f9f-8e97-06e460b61133	${samlRoleListScopeConsentText}	consent.screen.text
099a15a6-9981-4a44-ac7f-e005aa001921	true	display.on.consent.screen
099a15a6-9981-4a44-ac7f-e005aa001921	${profileScopeConsentText}	consent.screen.text
099a15a6-9981-4a44-ac7f-e005aa001921	true	include.in.token.scope
07752d66-7fd8-4f5c-8795-292739316af1	true	display.on.consent.screen
07752d66-7fd8-4f5c-8795-292739316af1	${emailScopeConsentText}	consent.screen.text
07752d66-7fd8-4f5c-8795-292739316af1	true	include.in.token.scope
0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	true	display.on.consent.screen
0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	${addressScopeConsentText}	consent.screen.text
0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	true	include.in.token.scope
47f023f0-a5b2-44da-b99c-b37beed3d275	true	display.on.consent.screen
47f023f0-a5b2-44da-b99c-b37beed3d275	${phoneScopeConsentText}	consent.screen.text
47f023f0-a5b2-44da-b99c-b37beed3d275	true	include.in.token.scope
a6827cce-ece1-4723-9965-1dbf77c74a23	true	display.on.consent.screen
a6827cce-ece1-4723-9965-1dbf77c74a23	${rolesScopeConsentText}	consent.screen.text
a6827cce-ece1-4723-9965-1dbf77c74a23	false	include.in.token.scope
aaed53ea-4c85-4c8f-a4bb-37acafdebce5	false	display.on.consent.screen
aaed53ea-4c85-4c8f-a4bb-37acafdebce5		consent.screen.text
aaed53ea-4c85-4c8f-a4bb-37acafdebce5	false	include.in.token.scope
5570ac38-49c1-4ae6-bb7a-0196acb085d2	false	display.on.consent.screen
5570ac38-49c1-4ae6-bb7a-0196acb085d2	true	include.in.token.scope
d31b676c-cadd-4f9b-ae8a-76f1f235cf45	false	display.on.consent.screen
d31b676c-cadd-4f9b-ae8a-76f1f235cf45	false	include.in.token.scope
f3059e34-6775-4cb3-a0ad-5b80647993c3		consent.screen.text
f3059e34-6775-4cb3-a0ad-5b80647993c3	true	display.on.consent.screen
f3059e34-6775-4cb3-a0ad-5b80647993c3	true	include.in.token.scope
f3059e34-6775-4cb3-a0ad-5b80647993c3		gui.order
0cbf88f4-3051-45b9-83d0-9c364d0b911a		consent.screen.text
0cbf88f4-3051-45b9-83d0-9c364d0b911a	true	display.on.consent.screen
0cbf88f4-3051-45b9-83d0-9c364d0b911a	true	include.in.token.scope
0cbf88f4-3051-45b9-83d0-9c364d0b911a		gui.order
c29c4562-fcd5-4c90-b245-8e47647e9fd2		consent.screen.text
c29c4562-fcd5-4c90-b245-8e47647e9fd2	true	display.on.consent.screen
c29c4562-fcd5-4c90-b245-8e47647e9fd2	true	include.in.token.scope
c29c4562-fcd5-4c90-b245-8e47647e9fd2		gui.order
\.


--
-- TOC entry 4242 (class 0 OID 17797)
-- Dependencies: 298
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
c75332da-5ed1-435c-b1d3-7581f2ea7db3	edf46eac-11c1-41c5-ab5a-327d66e020d1	t
c75332da-5ed1-435c-b1d3-7581f2ea7db3	80177194-b812-4b51-9849-39eb37680744	t
c75332da-5ed1-435c-b1d3-7581f2ea7db3	f94047ac-8dad-4148-8005-1668cdaf0444	t
c75332da-5ed1-435c-b1d3-7581f2ea7db3	37ba9270-2c13-40a6-af18-06d686f8032c	t
c75332da-5ed1-435c-b1d3-7581f2ea7db3	9c9cafdd-5ef6-4ea0-b213-294583e1262e	t
c75332da-5ed1-435c-b1d3-7581f2ea7db3	8b82b699-f981-45c7-9c6c-d9397222e686	f
c75332da-5ed1-435c-b1d3-7581f2ea7db3	e7179f97-906b-410c-9858-d914fc615640	f
c75332da-5ed1-435c-b1d3-7581f2ea7db3	02dcb303-0daa-48a4-8475-c75ad06c91d8	f
c75332da-5ed1-435c-b1d3-7581f2ea7db3	e6d8382e-711e-4358-a793-8d0410f135a6	f
7af5eb91-e11b-417c-bfb9-92f00598c4e1	edf46eac-11c1-41c5-ab5a-327d66e020d1	t
7af5eb91-e11b-417c-bfb9-92f00598c4e1	80177194-b812-4b51-9849-39eb37680744	t
7af5eb91-e11b-417c-bfb9-92f00598c4e1	f94047ac-8dad-4148-8005-1668cdaf0444	t
7af5eb91-e11b-417c-bfb9-92f00598c4e1	37ba9270-2c13-40a6-af18-06d686f8032c	t
7af5eb91-e11b-417c-bfb9-92f00598c4e1	9c9cafdd-5ef6-4ea0-b213-294583e1262e	t
7af5eb91-e11b-417c-bfb9-92f00598c4e1	8b82b699-f981-45c7-9c6c-d9397222e686	f
7af5eb91-e11b-417c-bfb9-92f00598c4e1	e7179f97-906b-410c-9858-d914fc615640	f
7af5eb91-e11b-417c-bfb9-92f00598c4e1	02dcb303-0daa-48a4-8475-c75ad06c91d8	f
7af5eb91-e11b-417c-bfb9-92f00598c4e1	e6d8382e-711e-4358-a793-8d0410f135a6	f
d2e52539-218d-4e1d-b335-0713e225274a	edf46eac-11c1-41c5-ab5a-327d66e020d1	t
d2e52539-218d-4e1d-b335-0713e225274a	80177194-b812-4b51-9849-39eb37680744	t
d2e52539-218d-4e1d-b335-0713e225274a	f94047ac-8dad-4148-8005-1668cdaf0444	t
d2e52539-218d-4e1d-b335-0713e225274a	37ba9270-2c13-40a6-af18-06d686f8032c	t
d2e52539-218d-4e1d-b335-0713e225274a	9c9cafdd-5ef6-4ea0-b213-294583e1262e	t
d2e52539-218d-4e1d-b335-0713e225274a	8b82b699-f981-45c7-9c6c-d9397222e686	f
d2e52539-218d-4e1d-b335-0713e225274a	e7179f97-906b-410c-9858-d914fc615640	f
d2e52539-218d-4e1d-b335-0713e225274a	02dcb303-0daa-48a4-8475-c75ad06c91d8	f
d2e52539-218d-4e1d-b335-0713e225274a	e6d8382e-711e-4358-a793-8d0410f135a6	f
7177855c-bf32-4806-9a88-dc43b8e4ee5d	edf46eac-11c1-41c5-ab5a-327d66e020d1	t
7177855c-bf32-4806-9a88-dc43b8e4ee5d	80177194-b812-4b51-9849-39eb37680744	t
7177855c-bf32-4806-9a88-dc43b8e4ee5d	f94047ac-8dad-4148-8005-1668cdaf0444	t
7177855c-bf32-4806-9a88-dc43b8e4ee5d	37ba9270-2c13-40a6-af18-06d686f8032c	t
7177855c-bf32-4806-9a88-dc43b8e4ee5d	9c9cafdd-5ef6-4ea0-b213-294583e1262e	t
7177855c-bf32-4806-9a88-dc43b8e4ee5d	8b82b699-f981-45c7-9c6c-d9397222e686	f
7177855c-bf32-4806-9a88-dc43b8e4ee5d	e7179f97-906b-410c-9858-d914fc615640	f
7177855c-bf32-4806-9a88-dc43b8e4ee5d	02dcb303-0daa-48a4-8475-c75ad06c91d8	f
7177855c-bf32-4806-9a88-dc43b8e4ee5d	e6d8382e-711e-4358-a793-8d0410f135a6	f
1f1f2692-dc36-47eb-af4c-eb50d1f98572	edf46eac-11c1-41c5-ab5a-327d66e020d1	t
1f1f2692-dc36-47eb-af4c-eb50d1f98572	80177194-b812-4b51-9849-39eb37680744	t
1f1f2692-dc36-47eb-af4c-eb50d1f98572	f94047ac-8dad-4148-8005-1668cdaf0444	t
1f1f2692-dc36-47eb-af4c-eb50d1f98572	37ba9270-2c13-40a6-af18-06d686f8032c	t
1f1f2692-dc36-47eb-af4c-eb50d1f98572	9c9cafdd-5ef6-4ea0-b213-294583e1262e	t
1f1f2692-dc36-47eb-af4c-eb50d1f98572	8b82b699-f981-45c7-9c6c-d9397222e686	f
1f1f2692-dc36-47eb-af4c-eb50d1f98572	e7179f97-906b-410c-9858-d914fc615640	f
1f1f2692-dc36-47eb-af4c-eb50d1f98572	02dcb303-0daa-48a4-8475-c75ad06c91d8	f
1f1f2692-dc36-47eb-af4c-eb50d1f98572	e6d8382e-711e-4358-a793-8d0410f135a6	f
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	edf46eac-11c1-41c5-ab5a-327d66e020d1	t
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	80177194-b812-4b51-9849-39eb37680744	t
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	f94047ac-8dad-4148-8005-1668cdaf0444	t
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	37ba9270-2c13-40a6-af18-06d686f8032c	t
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	9c9cafdd-5ef6-4ea0-b213-294583e1262e	t
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	8b82b699-f981-45c7-9c6c-d9397222e686	f
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	e7179f97-906b-410c-9858-d914fc615640	f
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	02dcb303-0daa-48a4-8475-c75ad06c91d8	f
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	e6d8382e-711e-4358-a793-8d0410f135a6	f
d2fa367e-e155-41d8-8392-c6b18eab5c67	099a15a6-9981-4a44-ac7f-e005aa001921	t
d2fa367e-e155-41d8-8392-c6b18eab5c67	07752d66-7fd8-4f5c-8795-292739316af1	t
d2fa367e-e155-41d8-8392-c6b18eab5c67	a6827cce-ece1-4723-9965-1dbf77c74a23	t
d2fa367e-e155-41d8-8392-c6b18eab5c67	aaed53ea-4c85-4c8f-a4bb-37acafdebce5	t
d2fa367e-e155-41d8-8392-c6b18eab5c67	d31b676c-cadd-4f9b-ae8a-76f1f235cf45	t
d2fa367e-e155-41d8-8392-c6b18eab5c67	7685c196-96f7-494a-ae77-9efee31e04dc	f
d2fa367e-e155-41d8-8392-c6b18eab5c67	47f023f0-a5b2-44da-b99c-b37beed3d275	f
d2fa367e-e155-41d8-8392-c6b18eab5c67	5570ac38-49c1-4ae6-bb7a-0196acb085d2	f
d2fa367e-e155-41d8-8392-c6b18eab5c67	0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	f
fc797aba-a792-4450-9575-d92c74afb436	f3059e34-6775-4cb3-a0ad-5b80647993c3	t
43de8d2c-b09c-4f53-9d95-49f0a9196ab3	099a15a6-9981-4a44-ac7f-e005aa001921	t
43de8d2c-b09c-4f53-9d95-49f0a9196ab3	07752d66-7fd8-4f5c-8795-292739316af1	t
43de8d2c-b09c-4f53-9d95-49f0a9196ab3	a6827cce-ece1-4723-9965-1dbf77c74a23	t
43de8d2c-b09c-4f53-9d95-49f0a9196ab3	aaed53ea-4c85-4c8f-a4bb-37acafdebce5	t
43de8d2c-b09c-4f53-9d95-49f0a9196ab3	d31b676c-cadd-4f9b-ae8a-76f1f235cf45	t
43de8d2c-b09c-4f53-9d95-49f0a9196ab3	7685c196-96f7-494a-ae77-9efee31e04dc	f
43de8d2c-b09c-4f53-9d95-49f0a9196ab3	47f023f0-a5b2-44da-b99c-b37beed3d275	f
43de8d2c-b09c-4f53-9d95-49f0a9196ab3	5570ac38-49c1-4ae6-bb7a-0196acb085d2	f
43de8d2c-b09c-4f53-9d95-49f0a9196ab3	0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	f
4bb9ceb1-bec4-41aa-9da8-e2be43657635	099a15a6-9981-4a44-ac7f-e005aa001921	t
4bb9ceb1-bec4-41aa-9da8-e2be43657635	07752d66-7fd8-4f5c-8795-292739316af1	t
4bb9ceb1-bec4-41aa-9da8-e2be43657635	a6827cce-ece1-4723-9965-1dbf77c74a23	t
4bb9ceb1-bec4-41aa-9da8-e2be43657635	aaed53ea-4c85-4c8f-a4bb-37acafdebce5	t
4bb9ceb1-bec4-41aa-9da8-e2be43657635	d31b676c-cadd-4f9b-ae8a-76f1f235cf45	t
4bb9ceb1-bec4-41aa-9da8-e2be43657635	7685c196-96f7-494a-ae77-9efee31e04dc	f
4bb9ceb1-bec4-41aa-9da8-e2be43657635	47f023f0-a5b2-44da-b99c-b37beed3d275	f
4bb9ceb1-bec4-41aa-9da8-e2be43657635	5570ac38-49c1-4ae6-bb7a-0196acb085d2	f
4bb9ceb1-bec4-41aa-9da8-e2be43657635	0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	f
0cac32e9-fc10-44ab-8066-6f3fdf7824a3	099a15a6-9981-4a44-ac7f-e005aa001921	t
0cac32e9-fc10-44ab-8066-6f3fdf7824a3	07752d66-7fd8-4f5c-8795-292739316af1	t
0cac32e9-fc10-44ab-8066-6f3fdf7824a3	a6827cce-ece1-4723-9965-1dbf77c74a23	t
0cac32e9-fc10-44ab-8066-6f3fdf7824a3	aaed53ea-4c85-4c8f-a4bb-37acafdebce5	t
0cac32e9-fc10-44ab-8066-6f3fdf7824a3	d31b676c-cadd-4f9b-ae8a-76f1f235cf45	t
0cac32e9-fc10-44ab-8066-6f3fdf7824a3	7685c196-96f7-494a-ae77-9efee31e04dc	f
0cac32e9-fc10-44ab-8066-6f3fdf7824a3	47f023f0-a5b2-44da-b99c-b37beed3d275	f
0cac32e9-fc10-44ab-8066-6f3fdf7824a3	5570ac38-49c1-4ae6-bb7a-0196acb085d2	f
0cac32e9-fc10-44ab-8066-6f3fdf7824a3	0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	f
15bff922-9d6c-425a-b6e5-a0b17d0e8886	099a15a6-9981-4a44-ac7f-e005aa001921	t
15bff922-9d6c-425a-b6e5-a0b17d0e8886	07752d66-7fd8-4f5c-8795-292739316af1	t
15bff922-9d6c-425a-b6e5-a0b17d0e8886	a6827cce-ece1-4723-9965-1dbf77c74a23	t
15bff922-9d6c-425a-b6e5-a0b17d0e8886	aaed53ea-4c85-4c8f-a4bb-37acafdebce5	t
15bff922-9d6c-425a-b6e5-a0b17d0e8886	d31b676c-cadd-4f9b-ae8a-76f1f235cf45	t
15bff922-9d6c-425a-b6e5-a0b17d0e8886	7685c196-96f7-494a-ae77-9efee31e04dc	f
15bff922-9d6c-425a-b6e5-a0b17d0e8886	47f023f0-a5b2-44da-b99c-b37beed3d275	f
15bff922-9d6c-425a-b6e5-a0b17d0e8886	5570ac38-49c1-4ae6-bb7a-0196acb085d2	f
15bff922-9d6c-425a-b6e5-a0b17d0e8886	0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	f
fc797aba-a792-4450-9575-d92c74afb436	c29c4562-fcd5-4c90-b245-8e47647e9fd2	t
fc797aba-a792-4450-9575-d92c74afb436	0cbf88f4-3051-45b9-83d0-9c364d0b911a	t
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	aaed53ea-4c85-4c8f-a4bb-37acafdebce5	t
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	d31b676c-cadd-4f9b-ae8a-76f1f235cf45	t
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	099a15a6-9981-4a44-ac7f-e005aa001921	t
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	a6827cce-ece1-4723-9965-1dbf77c74a23	t
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	07752d66-7fd8-4f5c-8795-292739316af1	t
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	f
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	47f023f0-a5b2-44da-b99c-b37beed3d275	f
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	7685c196-96f7-494a-ae77-9efee31e04dc	f
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	5570ac38-49c1-4ae6-bb7a-0196acb085d2	f
fc797aba-a792-4450-9575-d92c74afb436	aaed53ea-4c85-4c8f-a4bb-37acafdebce5	t
fc797aba-a792-4450-9575-d92c74afb436	d31b676c-cadd-4f9b-ae8a-76f1f235cf45	t
fc797aba-a792-4450-9575-d92c74afb436	099a15a6-9981-4a44-ac7f-e005aa001921	t
fc797aba-a792-4450-9575-d92c74afb436	a6827cce-ece1-4723-9965-1dbf77c74a23	t
fc797aba-a792-4450-9575-d92c74afb436	07752d66-7fd8-4f5c-8795-292739316af1	t
fc797aba-a792-4450-9575-d92c74afb436	0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	f
fc797aba-a792-4450-9575-d92c74afb436	47f023f0-a5b2-44da-b99c-b37beed3d275	f
fc797aba-a792-4450-9575-d92c74afb436	7685c196-96f7-494a-ae77-9efee31e04dc	f
fc797aba-a792-4450-9575-d92c74afb436	5570ac38-49c1-4ae6-bb7a-0196acb085d2	f
\.


--
-- TOC entry 4220 (class 0 OID 17316)
-- Dependencies: 276
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
e6d8382e-711e-4358-a793-8d0410f135a6	12b1fec9-7a53-4a4c-b82b-7dcd99006968
7685c196-96f7-494a-ae77-9efee31e04dc	e9fe846e-b978-4e67-b020-ffbfb8a52f03
\.


--
-- TOC entry 4162 (class 0 OID 16441)
-- Dependencies: 218
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- TOC entry 4207 (class 0 OID 17087)
-- Dependencies: 263
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- TOC entry 4185 (class 0 OID 16793)
-- Dependencies: 241
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 4199 (class 0 OID 16971)
-- Dependencies: 255
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- TOC entry 4163 (class 0 OID 16446)
-- Dependencies: 219
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- TOC entry 4208 (class 0 OID 17168)
-- Dependencies: 264
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- TOC entry 4238 (class 0 OID 17552)
-- Dependencies: 294
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
feb1a44d-45c2-4128-a446-b3c27c7b0c08	Trusted Hosts	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	anonymous
1d6c9ec8-6e15-4620-af34-ec42e7a3b38e	Consent Required	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	anonymous
0da14cdc-28ab-4594-b394-bbda9e21a3b0	Full Scope Disabled	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	anonymous
b4f14373-917d-4a86-8064-6f8a4c013375	Max Clients Limit	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	anonymous
cc09839f-e9f3-4983-8b53-efbcdd67b3fc	Allowed Protocol Mapper Types	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	anonymous
c128d606-d7f7-4953-8db1-7f2a2efba5f2	Allowed Client Scopes	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	anonymous
f18d2a31-8425-400a-a17f-dcfa78f2a287	Allowed Protocol Mapper Types	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	authenticated
4640c86c-75a1-4724-9671-bef1b3d5b735	Allowed Client Scopes	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	authenticated
8adae689-9477-4dd2-a2c8-a2478bf6caa1	rsa-generated	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	rsa-generated	org.keycloak.keys.KeyProvider	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N
bed8acc0-ae6e-4d6b-b347-cf8c3d7a0aa4	rsa-enc-generated	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	rsa-enc-generated	org.keycloak.keys.KeyProvider	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N
d612f0a3-4a45-4b96-9fc9-02d07fcb5a94	hmac-generated	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	hmac-generated	org.keycloak.keys.KeyProvider	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N
e31ad624-3c98-4003-b728-c19ab1a826cb	aes-generated	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	aes-generated	org.keycloak.keys.KeyProvider	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N
0f337ab5-5e3a-412a-812f-21507b4fecfa	rsa-generated	d4586994-289c-4313-8f41-4aa5d69533be	rsa-generated	org.keycloak.keys.KeyProvider	d4586994-289c-4313-8f41-4aa5d69533be	\N
161acb41-d2cb-45ff-922b-27e264c53164	rsa-enc-generated	d4586994-289c-4313-8f41-4aa5d69533be	rsa-enc-generated	org.keycloak.keys.KeyProvider	d4586994-289c-4313-8f41-4aa5d69533be	\N
83c30305-1898-46a1-a2ad-ac5cfe1553b4	hmac-generated	d4586994-289c-4313-8f41-4aa5d69533be	hmac-generated	org.keycloak.keys.KeyProvider	d4586994-289c-4313-8f41-4aa5d69533be	\N
9ea85f19-7b66-44cd-af06-3452ae1dfe63	aes-generated	d4586994-289c-4313-8f41-4aa5d69533be	aes-generated	org.keycloak.keys.KeyProvider	d4586994-289c-4313-8f41-4aa5d69533be	\N
df6e7b34-fd4d-4f44-a181-abc6bd6b0b34	Trusted Hosts	d4586994-289c-4313-8f41-4aa5d69533be	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d4586994-289c-4313-8f41-4aa5d69533be	anonymous
39aaea0a-f586-4581-b17b-dad67dbcd410	Consent Required	d4586994-289c-4313-8f41-4aa5d69533be	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d4586994-289c-4313-8f41-4aa5d69533be	anonymous
be1fafd2-d2f3-424a-9979-f27bd28ba774	Full Scope Disabled	d4586994-289c-4313-8f41-4aa5d69533be	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d4586994-289c-4313-8f41-4aa5d69533be	anonymous
ce1408dc-c90a-44e2-bea6-7c63d471c9c4	Max Clients Limit	d4586994-289c-4313-8f41-4aa5d69533be	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d4586994-289c-4313-8f41-4aa5d69533be	anonymous
b4175965-4b3a-4a85-97b9-9f8ba5b8be79	Allowed Protocol Mapper Types	d4586994-289c-4313-8f41-4aa5d69533be	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d4586994-289c-4313-8f41-4aa5d69533be	anonymous
832e3675-aab3-47ca-a427-2074d2eb55f4	Allowed Client Scopes	d4586994-289c-4313-8f41-4aa5d69533be	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d4586994-289c-4313-8f41-4aa5d69533be	anonymous
64bf52af-f6a5-4a59-8ca8-45e4debf36fe	Allowed Protocol Mapper Types	d4586994-289c-4313-8f41-4aa5d69533be	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d4586994-289c-4313-8f41-4aa5d69533be	authenticated
235971b1-bb07-41f0-86b1-9ca3e4b6b2ae	Allowed Client Scopes	d4586994-289c-4313-8f41-4aa5d69533be	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	d4586994-289c-4313-8f41-4aa5d69533be	authenticated
8b5b51bb-73f4-40ad-ab89-894d2d3a2282	\N	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N
dd6dc73b-6fee-42fc-851b-80d6e1ae7add	\N	d4586994-289c-4313-8f41-4aa5d69533be	declarative-user-profile	org.keycloak.userprofile.UserProfileProvider	d4586994-289c-4313-8f41-4aa5d69533be	\N
\.


--
-- TOC entry 4237 (class 0 OID 17547)
-- Dependencies: 293
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
8af59e8d-8c8c-487b-b074-3111e34a477f	4640c86c-75a1-4724-9671-bef1b3d5b735	allow-default-scopes	true
6f150a54-3795-4b0f-a4e1-53552a417e4f	feb1a44d-45c2-4128-a446-b3c27c7b0c08	host-sending-registration-request-must-match	true
8d516367-a589-4a7f-80d4-39507815a17a	feb1a44d-45c2-4128-a446-b3c27c7b0c08	client-uris-must-match	true
1ca5e903-753a-45d6-ae97-5e2449247ca4	cc09839f-e9f3-4983-8b53-efbcdd67b3fc	allowed-protocol-mapper-types	saml-user-attribute-mapper
e9243a39-a59e-442f-bda5-a553b5b1d7c6	cc09839f-e9f3-4983-8b53-efbcdd67b3fc	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
30506a5a-acd2-48c1-ba09-fba413bd79c1	cc09839f-e9f3-4983-8b53-efbcdd67b3fc	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
1eb6f5ee-43a1-4c23-91e3-29ef9eec0bfb	cc09839f-e9f3-4983-8b53-efbcdd67b3fc	allowed-protocol-mapper-types	saml-user-property-mapper
abb4b7da-8bf4-4cf7-bb75-b6906f0270cd	cc09839f-e9f3-4983-8b53-efbcdd67b3fc	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
47edd039-bf68-4397-b3a0-ab9f57341867	cc09839f-e9f3-4983-8b53-efbcdd67b3fc	allowed-protocol-mapper-types	saml-role-list-mapper
dfda05db-931d-4912-8e88-b50f5d28883a	cc09839f-e9f3-4983-8b53-efbcdd67b3fc	allowed-protocol-mapper-types	oidc-address-mapper
80a0165f-8919-4bdf-a403-eabd3fb630f0	cc09839f-e9f3-4983-8b53-efbcdd67b3fc	allowed-protocol-mapper-types	oidc-full-name-mapper
f448150b-dd92-461d-b527-2787e518ca7d	c128d606-d7f7-4953-8db1-7f2a2efba5f2	allow-default-scopes	true
f2c88a0a-c9c7-47f4-918b-49500ca734bf	f18d2a31-8425-400a-a17f-dcfa78f2a287	allowed-protocol-mapper-types	oidc-address-mapper
518b5809-6ffc-4e86-9019-efe0d471c443	f18d2a31-8425-400a-a17f-dcfa78f2a287	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
35c80efc-857f-4aa2-b952-37ae6c2f8904	f18d2a31-8425-400a-a17f-dcfa78f2a287	allowed-protocol-mapper-types	saml-user-property-mapper
be05a348-c8cf-4c13-a598-61509db2e9ff	f18d2a31-8425-400a-a17f-dcfa78f2a287	allowed-protocol-mapper-types	saml-role-list-mapper
538b3c78-73dd-4188-b7ca-4fef168cdc35	f18d2a31-8425-400a-a17f-dcfa78f2a287	allowed-protocol-mapper-types	saml-user-attribute-mapper
c11ddc42-21d1-40a2-bdb1-e2914fcbca30	f18d2a31-8425-400a-a17f-dcfa78f2a287	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
636c6173-fcb0-47ca-8e8d-4d9ad30b4329	f18d2a31-8425-400a-a17f-dcfa78f2a287	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
f35005da-c0a2-4209-9a96-916de0162d4d	f18d2a31-8425-400a-a17f-dcfa78f2a287	allowed-protocol-mapper-types	oidc-full-name-mapper
189f8c21-2d4b-4d41-8c53-5888223b2b9e	b4f14373-917d-4a86-8064-6f8a4c013375	max-clients	200
bdff422b-7de6-4698-8565-7b4d4538e33f	d612f0a3-4a45-4b96-9fc9-02d07fcb5a94	priority	100
794530d2-bed9-46e7-b720-886f6ed86c49	d612f0a3-4a45-4b96-9fc9-02d07fcb5a94	secret	TfvAfrQlQMefm7TyjVYukmRLW41cCQGPqgdmKxGEkzdxdnGjS0m6ylBQZzgPpiIRGT8NH5T0mp5m8eAOUZ2Hxw
a3eaa1d5-4311-4736-b83e-bd10bcb875e3	d612f0a3-4a45-4b96-9fc9-02d07fcb5a94	algorithm	HS256
45b0e9ad-f57a-4dfa-aae3-3ecebd57a474	d612f0a3-4a45-4b96-9fc9-02d07fcb5a94	kid	c877a950-f588-4e79-b488-31f332e81955
b8274ca0-a96e-4071-bbc4-03355a936202	e31ad624-3c98-4003-b728-c19ab1a826cb	kid	aebed57e-3560-4fa3-b9f6-e7ca94cf6d11
6e54ec00-26b4-4918-b46a-07acc0c98f0d	e31ad624-3c98-4003-b728-c19ab1a826cb	priority	100
ed70d5ad-9b0f-4a82-a195-9d880ee6e974	e31ad624-3c98-4003-b728-c19ab1a826cb	secret	wXZywUOQsOgvP6tXdrpnTA
c782e666-8b00-4a02-b579-f7f3ce21e92f	8adae689-9477-4dd2-a2c8-a2478bf6caa1	privateKey	MIIEpQIBAAKCAQEAnmkbwZADYSLiFsDKZzYrj46HEdbwdJ581QSwjj1/mzMzTngP4BIpI+/pJnAv/W5Kr6UhfSPvJJzUKnv+uTORvx5oXTxAi2HDagd/+vU2hOuL1S9YWSspA0tWdqurkfDA+S19tFsRe7TK514hJb4q72zsUuxlQSr9okOqSjAa5irsF2XswAXCGd7Vzgz+ftdO5GA0xPovA8C8S277P28YzEI3Ou031Tf38lUuy4/GRQtmfcM72qcuExO06MybiMszbjFcbtWmCyfEVnaHYFPE12sqYZ7uyiGmupyfLFSNyhnbyrq5971/rsZSmnlc6bKuWUFwych/eaU2JTlJGMBheQIDAQABAoIBAQCERtazkhMQWLWcNE6PUu+bB3QIVIgjiXhJ1ImtrPLSYTW1j5IKFIAgDySMQWABasiY1PYa7heyZfbQpwu0ELjic3zIZhiriu5Hqo2WvI5S/fGdCdTnWJ/9rTo9C+rPic9KA0+Ve/okZ3qLKtHZF2v40+ae8+E1QrXaelBHdNXxXZK4xG0EPqOc0MKwdHQCSKY5xNehmfvkn+BqQmuNUuPHUqZ8hcU0V6UrpbvdMpbRlgq+uCamY5V5jSQsE2i4mswxl1ACKZljTwWXGFvCBvJYxfPJSYsn0mTqRh0CssUsIXSSGymlEXq6x6BOzZRjw7r2jJRFo0r/X/kmDemm0F0BAoGBANoHZvqHWE2rDaCjmxEZrl068XR10vF4IOjx17zccHRkAyse/0PcIP+mVCIGWy5t4hwu6NVOOyaswuegUfCqPAj3cri+4ApN/hwkqy6msYV7kRF+nG1FAif9KxLusNT5gg+D4gqKK6yUHccY6IAKsWJKVC91n+vnG7BH/ACH2e4ZAoGBALn/ruhgOfd0fWQIdFkr3IvXBzQHpe48zo7XSaWhQrhAATJQH+yLPj+Fkjtc5j867tVPLlqPpg8wE6c48Oc5WdHUReAuIAoRhc7hZ3zFgMoGAXk0TltJGQ4G1xhYh4KJhdhunDD9373DHlbxXUc9tsdkCNsYnESnC5+JXk+hh7phAoGBAJH3irYHjtLQxhrZ7aMRMm8wWx7BEyyeZEoQP4MtggwqOQTRh8yCv4TockMlRj5bSpnbvf2wlmFaIFK6PqGFFxRZtfCBubSsaoek9QYSi572DzVLMqblIIBtOj0+mBy9vplsjhTIVF0B/L2iq2WtwvwvDxWHBj4FR8BJMSmZyglhAoGBAJM4Jpg1egw8fvdLndPq3LEu7LupBhRQuuniy582ydmOh6PsOah/+jBLKBiminQn0Fy0RKtXogfJdPTaJAvQoCBuVTSBLcjqX7AFR2VB6pN9N3NZDGBCtnscvOm/QNr4wSEzQ5ufhpXrt7r3Zm56EY82xa+thhrs4U1QbH65CvZhAoGAZf/C4GRaD71NtVvxgR/ss3LRQlNtCTf0Ai+RN3KBEZal3apSF2oGfxVFgslcUsjEL+BRky4axjOMzyKIi0cJkWTTuqOUJC2buOLZbWVk3Gif2pGRl9NBINQ6u3PL7rHX2mBn9SAHKGN3LISt5TiJDfyuZlYRRYfvLGny211YXx4=
0876c763-6720-4b11-8368-1910c0e593d1	8adae689-9477-4dd2-a2c8-a2478bf6caa1	priority	100
5f608b82-50f9-4ab1-8519-9a1188847b0e	8adae689-9477-4dd2-a2c8-a2478bf6caa1	keyUse	SIG
0be93c33-44a6-41e2-81c5-e45f80bd7af5	8adae689-9477-4dd2-a2c8-a2478bf6caa1	certificate	MIICmzCCAYMCBgGCAeHuGjANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwNzE1MTI0MTAwWhcNMzIwNzE1MTI0MjQwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCeaRvBkANhIuIWwMpnNiuPjocR1vB0nnzVBLCOPX+bMzNOeA/gEikj7+kmcC/9bkqvpSF9I+8knNQqe/65M5G/HmhdPECLYcNqB3/69TaE64vVL1hZKykDS1Z2q6uR8MD5LX20WxF7tMrnXiElvirvbOxS7GVBKv2iQ6pKMBrmKuwXZezABcIZ3tXODP5+107kYDTE+i8DwLxLbvs/bxjMQjc67TfVN/fyVS7Lj8ZFC2Z9wzvapy4TE7TozJuIyzNuMVxu1aYLJ8RWdodgU8TXayphnu7KIaa6nJ8sVI3KGdvKurn3vX+uxlKaeVzpsq5ZQXDJyH95pTYlOUkYwGF5AgMBAAEwDQYJKoZIhvcNAQELBQADggEBAHx7cEpyi4PoQwlBLkhFrre77kNOpIrYNlLH8cYlBeFsRfPXsTHJ8nbdQwdfDCgcCjmcVMhnp+PLGyR198kIAY3k7I7FHKbP/3eT7NXgz+C+7kltJJ+Eh8w9kJCy/XzkfiXggBLr4QNfv3AA5UE9Ft18ZgxSORsZ83FLlUZ5UDHMxP9ITCZrsKdlGXIZeD/aWiRYwK3y0KD+QwSGRoRe3Bi2Xc3t5+leT1hVtGmq6yd0IMiK8N4GYpCm13JRQKLNc8gLjej66Xz2VIYkovUxn7MTNbJIi5hAnIc+ctR9U/Zt2InMcRXLD0QcJYA3RTFOFs2EID4+djVEuhL/PO10NEU=
3ebc76b2-ea1a-4b11-8a4c-da7fa10c772d	bed8acc0-ae6e-4d6b-b347-cf8c3d7a0aa4	privateKey	MIIEowIBAAKCAQEAtLdIBad9k7ioGazG8NC2E4AerrN9Jq1VuNbvZ+UceiMFVY1OOUT5GBPhutJwNsXV4MHb2MfYRionoRo5eq/nfQZcREw2LAF7DcMP5q5zBn+/MK9wI05EmVVr1qVo7kTXYX2tdTPjyjSam4bWA0RdIwIMGMrToXDxYkJJycK3OZFW5KkTqq5aemxq1YSH8YAmExhme5MNTq4fbAEWQFgUAgIqmBKOQSPsFT4avkxwyvurWA/B7TnWbBvRqzv7Xr7Nj+ClF0+0Hwf2Pp+YK175h6Aq5z66TT+1aTjrBgtDOJNQtxcypPPuIMjzjnPl0JopZ3ZYCS2Ah8eh5Spj+RpJIQIDAQABAoIBAHIal5saWiv/mAQ+F47N+WjuqHDeW9Mj9tAyxg7vlr93hVKzWgTHDBCr3Qc9ACVVXOoA/XMvG9uRmlwaVtikYKGMdo2ZIUs/1BaoZ03cMDyWRH3VCBUCwkWerexlnI91YBjqZa9vCBEQjd5NkKuXasdD76dnyaBR09eay0RdcZsinRLXYm5cdHfN5GadcFN+Ej0E2PPBj9eAUtoY/6nCzobeWAPbF16CQ9FM2i97IVjUGO/BCyHc8qqtseVhSd22GwQGpQaN+xsubmRI30Fg1gOSEbkTbN9JPv0BmmZey1scBD4ZQqkvgzH2Dz2UMTtf8hANwh0zSzGE0re+Wb5IY5ECgYEA6aCS+i547NNwc9+wwYN2CnrSzM97W3VernNRzGxok2Z2X+TWtrBfKf/lFegpFmd1yGA5VKF21u6tc/dyRiU5Tm7XrWcGLKIO9qlWUdbOiMVpstoRHTm1eHi0KfeBpOG/JOx3+UY2K0Nd2znPLmPEduc3vksqHHepXQh+A7Gi4M8CgYEAxgWTD21q1oZ6UVrt1ueztTml2dw7s/hwqTRl+qXEvTNoj16oFkM6fIY8alfy5REolRFdDa7lC6rc7cGG8npVA6HN5Ee3OBhR85B9cVNNNWoj7Q6bOjkXecB7gLEjSDXe4+P6QsiEnqbrWPICJBavje0OD0sbkMZAJSiWlxaUUw8CgYBjNIlU7SjyP7KvsZwIAD++oXsj9zLFmmhTIarpaFtbxBWeELlQKEKwvfXUQJo55kLwjFOr6UhiakWDSd7fhGz6Lj0tZ+MKTuKVwUBjThizoUiJ5ul/hILXnkG61Fvb3PRixHsJgdP8uQWA0uJ0K29AolxcVOST5Agp9jI0dVjZpwKBgQCSXy58Gdn+JrslhbwGvZBVpf4VErjC6CKGwCedZYkOfYCNcV93zUvfHe5sgQQXFF7WCVaqNZwyyqKxz/prI8fRfnnNgsFI4pk5G5XN/dA1anaR1Nki6W6T3Zas4sL8rm1KMIsdcFCvYRzXy1OPz4EGvLJG1bLTieeCUAU4O0V6OwKBgEjiRe8sf50YO2l3/vgQBzrgURDmQP7vrqL7dBq5rRlxxpjYvirb96MukpxEG1Vyzy3bsWEv38xSndAlyie4JlOy0YVQoioMTOUodUROK9Oy+M+6AsjbxzdT9+j1gpT0xsECcwb+invhquJiI/geGCCYLuPNz7zcPp9gY+tNOemw
21cfb054-c3f8-4aed-8643-00150ff6e7a9	bed8acc0-ae6e-4d6b-b347-cf8c3d7a0aa4	priority	100
10352536-8abd-4cd2-ad1b-1d94a086aff2	bed8acc0-ae6e-4d6b-b347-cf8c3d7a0aa4	algorithm	RSA-OAEP
bde58b1e-8d1e-477c-b7e3-63dcedc35901	bed8acc0-ae6e-4d6b-b347-cf8c3d7a0aa4	certificate	MIICmzCCAYMCBgGCAeHu4zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjIwNzE1MTI0MTAwWhcNMzIwNzE1MTI0MjQwWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC0t0gFp32TuKgZrMbw0LYTgB6us30mrVW41u9n5Rx6IwVVjU45RPkYE+G60nA2xdXgwdvYx9hGKiehGjl6r+d9BlxETDYsAXsNww/mrnMGf78wr3AjTkSZVWvWpWjuRNdhfa11M+PKNJqbhtYDRF0jAgwYytOhcPFiQknJwrc5kVbkqROqrlp6bGrVhIfxgCYTGGZ7kw1Orh9sARZAWBQCAiqYEo5BI+wVPhq+THDK+6tYD8HtOdZsG9GrO/tevs2P4KUXT7QfB/Y+n5grXvmHoCrnPrpNP7VpOOsGC0M4k1C3FzKk8+4gyPOOc+XQmilndlgJLYCHx6HlKmP5GkkhAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAIJ+gPKlAAwCMNRIoaWBb3UmsX4HaoFsLwGymHPV8O7f8XBQyJ0T2I4Pn4/lT0gWbFw7gint+LTUHFJngQBgemQQfGc68Ys0VObGJG9aGuxT9TrAAiN7wCS1+HIVZNSfZYOdA9QykJSKOSU0B6EwcMniK6JQk3y3QCb0LCVYn4cKD64M4mC6y/i4H6ACTydWBcNiDLogvyw7vCFk4/dd7Rm3oZs/Rd1jSGgtT8Km+pOIZaPF/Ni+kn6EK42TrbHCMR78t5BD2h4NOVT+f7jx6OEv+9byQ0TUVAzp+xzeRgsH6HjcPIYx9p5wtR/+sfKWIq8lvQ7xCAoLVynNExU8aEU=
bc7c5b0f-a5c5-4662-a02f-d392c6c00e29	bed8acc0-ae6e-4d6b-b347-cf8c3d7a0aa4	keyUse	ENC
60f618a7-996c-4a76-8a79-12a492d3a8e1	83c30305-1898-46a1-a2ad-ac5cfe1553b4	secret	RFnQkUQKMrn5yJXiwJlbEwqt8Seif9DVpafrqOLYfYTUt6P1N_euhX_3Tg-9X_uPlib50PRiQGfxdbFS-OPTzw
7ace29ac-2740-41eb-8781-462509ec3529	83c30305-1898-46a1-a2ad-ac5cfe1553b4	priority	100
c1932ef9-d34a-49e6-bf5c-38989e21ebf1	83c30305-1898-46a1-a2ad-ac5cfe1553b4	kid	e7985932-bc15-448d-bc22-fa5ce85cd5ca
124c84c3-2093-4876-a8dd-54221ab369b8	83c30305-1898-46a1-a2ad-ac5cfe1553b4	algorithm	HS256
ea065b65-d65b-47df-b921-785d8ea1eb29	0f337ab5-5e3a-412a-812f-21507b4fecfa	certificate	MIICozCCAYsCBgGCAeKfUzANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDApDYXJTZXJ2aWNlMB4XDTIyMDcxNTEyNDE0NVoXDTMyMDcxNTEyNDMyNVowFTETMBEGA1UEAwwKQ2FyU2VydmljZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIX7U9sQks9JRP4YudzhhAIIyGXVnzkFXI82xy2MuDhIqtAXfM1yVz6zer3nEBCB2Y38wGZeOY4YgSUeF4MnjPea+lZzL4vZPHL6HSBw2zbSX5P4bfnaxGavlUOeLj1gIRAa7jM6LV6magBqGrWPmuhWjw4HhJUHlVVsN3hkFXcWpgAcVCcOqGa2nzFO3rQGQ6SYqYez5Q9vjVnIzAtEZz4EK1VmZ7YhOy74LeN5DzG1L7K3pZaG7Ex4gmK66hzif8DK9qPZlp4kqiV7sRysxjMRcNV/LpR0O+MKtVu3lnVNwa62YaNpaBemuD1QTvRob9iyNh+dRDchyxbxJpxgH1ECAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAa1YcyUpVnDQGquiaT2fl+dZdWwmbv8c7WsDTxJueu0lkEfu+hu96QJelXkTDA8ngYl1CpQ1ustXzO0Fy/y+k2zUla3XT8PwW1cuGchVhWxwdnKGTRyIKRxzE6o12UcyB6hVKKbb7LB6QEsQu2wpWEuKAwo7P3PcFFUf9K9fm+puvwZh7Br2H5isM/TnXqdxBhUxoJhOxMP/3yP1N5WgBi/jVTnzjpNAZvyq5IrzW1Ks43bncNbiDMQW/RR2E06qU8Ix1j7EobX4yrfmdrdzbGSW1IfmIfkvgxiz5HXeuK68UQwUO33eZGCnWW7qFdAdclwEzZ0oprqEDiSPPDYPRvQ==
fa4c05a4-9a47-44d4-8490-c908b71a2fc3	0f337ab5-5e3a-412a-812f-21507b4fecfa	privateKey	MIIEowIBAAKCAQEAhftT2xCSz0lE/hi53OGEAgjIZdWfOQVcjzbHLYy4OEiq0Bd8zXJXPrN6vecQEIHZjfzAZl45jhiBJR4XgyeM95r6VnMvi9k8cvodIHDbNtJfk/ht+drEZq+VQ54uPWAhEBruMzotXqZqAGoatY+a6FaPDgeElQeVVWw3eGQVdxamABxUJw6oZrafMU7etAZDpJiph7PlD2+NWcjMC0RnPgQrVWZntiE7Lvgt43kPMbUvsrellobsTHiCYrrqHOJ/wMr2o9mWniSqJXuxHKzGMxFw1X8ulHQ74wq1W7eWdU3BrrZho2loF6a4PVBO9Ghv2LI2H51ENyHLFvEmnGAfUQIDAQABAoIBAELvy3c4koApFOT1qXXm3TK+/I+T6FZujU2nil8BXNARzfTkpx9lLp1OwdW6aNY2aWB8lAsQrCSHrY3DuO93hP/3V3Z1WZ2+zGqM9pxMhdifxcyBY0BewZyjwCjmECftrNcE/VhuilgtP+wxFmL6+eN1y0axDtX90ee5hwUIy4iQ+KJbLvzYmJXv52SjAbuRAG+/hAIXKr4ZylKLpucLb7EIDuEnsAuopliR48qkPCO4x9wmbe/fSAn0z93uf1HIvzC0j3X0m5yJfdAT7WuXF9cpWv59CCfwV5bzaXzYjNecp7F7Y3ehX8zmVSknjpKx2AYgmxK+mBLuOyPyTMadT9kCgYEAxoH33PTSHCMh9X4zxr1ww2tenqy+s/yjCQA/qEXwqUyvod/qAfPbQ9RAUDhCp8jpXJqeQOBTrerSTLHPvabJ33omWt0ybvodG1moCV0O45BKqupGWHxc1Aynn22Eb5FLIK1nLXV/t79YinCEHO1APHhgD1DuXKv0KO4d8FZ1kQcCgYEArMkwEt3MOpXsaNzaxijSPI37WpvyCsR7iw455McjbqhKM4mbWaUep1wHqSd7l+a7kKC8ka67SjGSvhcjNVdWPtfyn0pVw/l+tky2WszzkS24mrrC8NuWHoToiCji/zuhbqbOqCtvgKoShY+mVuIj2Q4ILWFRWuePyfSNtrYtLucCgYAxB4rr9UAsGPVbSEeLj+DZM5zUPkB//idaosgWTOgLONisd7y5rLx8fWFBLxQvku0opTvvNDkW3MgCj2yLIDX+T5JHoRjC1l34EmXxoh16UXpPyruDQXxAF7wTIZ6zW8SdlpbEYKAiB03cK7xF1Men5+d6APhOxV3x+hZE9WXmYwKBgQCfbUtUPR7R97+Yyh96s/O4N/Fym21rjfvIRKoac7w3wEQm5ZNX1clA9uOCqpGZiSYLvqP/b9AUF0Wk68hq0Vkcxzhwza/xEWZfYsznXzBmBl/NNQHmJ1aOdmfwKnm4sxay+Gq6NMm/WC2a2v7KMAKPpijZZnAghoTf/Sw9KD7shQKBgFcuepGQKJ1Bukb0k1CdnZgOfp4TmvK65Vs5Pv52HGB6IYZSm3CPF8lu4+2ol+brkCT57/OeAkbJhppDVjWeAAqcNTKaFTzRRF216EVlVo4au3FGYuVa7mEFZLmvA29TDeBVpW67PTGF0npOh7BzBH6rfw5uJhynoWY8zQIFVLFs
81bccc72-20ad-4452-915a-f271b82a50c3	0f337ab5-5e3a-412a-812f-21507b4fecfa	priority	100
ca821b58-1a9b-45a2-81d1-f38e5626f2e7	0f337ab5-5e3a-412a-812f-21507b4fecfa	keyUse	SIG
43e65da0-bf34-4ac7-8fed-e0c18c3a730d	9ea85f19-7b66-44cd-af06-3452ae1dfe63	kid	747d6c97-9d61-49df-9347-7e382969e678
45b4631c-3683-489a-8bf1-f851192e890e	9ea85f19-7b66-44cd-af06-3452ae1dfe63	secret	gnSQmHDqFXnLyY-drLzkAw
7aeb8c90-b2b5-4c3c-b864-66c717b971bb	9ea85f19-7b66-44cd-af06-3452ae1dfe63	priority	100
eba158c2-f578-43ca-a36e-a7b8ab673070	161acb41-d2cb-45ff-922b-27e264c53164	algorithm	RSA-OAEP
d11be1ef-e76c-47f4-bd12-ce05f67aca15	161acb41-d2cb-45ff-922b-27e264c53164	privateKey	MIIEpQIBAAKCAQEAlOVJx7NXKPS7t2/HCPiUB98FbqnFCaAWW/N0V/o2OIZNbhl1ourLPSLLcUFUz5X7LVpnUL8X+XZbL3xDMwfMztdyyWrDyIJ0G/h21PaLOqcqnbbWegBXm/bwH6OfVMoceMSjqii3cyF1/MFOLG3UDC6rk6gk8kjK3rXv8jMHA2eE2NYugFeAScWbYTdPYN6KEp79qpG6aJVcgAu8Kjox3vtsOBUy0t4SZ79j6rbwjmHQ71cB8toF3zx/icEA7TCp5EYM/eHEJNRfcQAmJ99EiSO/8L5FDBAPRuf8f/dJjWBZylNwfengUGUVPLx3DXPxL4LG7RoEI3oiaOGNT+AmdwIDAQABAoIBAHT9q/kTevqdQRmi5DqyRm3g2H3ZOw6TEL5zDglKemvzaseFjZ7S6ZpByqRUdvUcnV1HWUJiw82pJ4CqHIruKAil1HVaRDc5+U047vXqOf999cgyL1dxCWVso8PYZorSu4hQyWAb2fjGY9STdn8GVMS1ru64AT+13mEbh0tAuNP8wVLTanQZxGF98t7tXyObKRw3WzB+aTdSNhv5H6TpZ0GR6RKf6cugmB09SvjASLNWGXnNuG1bBw4hN6rI4k79rjXNts93IdDge7NWbdYIb9MVov19ZpWRQADYnU3bpFagVBAFFVSJigSOPCaoA39N1mcDSJf25CvwEw8ZjzPcEMECgYEAz054jKokHx8ZhPIHmAn8aOzVuAUEJQrbXKRTrI3cIMsvh4wWcyBSIqsptMwg294rR7f7ae64P5q10TFnC3u0B3wktKHnt5U0Z0mbfBRO+k0M2VPYrSH4FL2meW3n8/jjJrYQQfGw2TqCRJonwITbdUF54hlSrxgKPJfuCbYwC6cCgYEAt96E0hynsHSBsHSdL+6Zwu6Fbz+hXIEES7EgnM9R037+vPKBW1N7Bl4XHB0HZyB5cp3SzFSSn9o8Lgq25k0Gubcqssi+E7hKNXuMoQatIAeLO4J/GgCqNgtBnuDlwIjXtNUUWp3Y4w/W5l2n5u3Y+angr8uoaLo9+rhmLJU6KLECgYEAuMJeLDfjM517GALBg966iCU0IOrPk9gGQ53tOSfBnbSZKrxOsdKHgYB9DjazvmFWv3eY6gOpUH6pNsVJ6nEYtWcOK7L0mqiu6LMwkThkXy5WmkbhIQTaXlncSfMLPGSAxlqTSMKIdEJyIYQmk62VDf8KCtm42HabgP+DVkJ6tZcCgYEArgkhDv+weYTNfIfkgIoHYEsEYdiIk1ZLCpoNlF9nxBhgZdfkON07hTtqBGI1r5c9XQ+lh2JFpqiabboWhMZDp2WINNFtmJzHIPhgk8oN9FMvppROWf5nHeBprEiTLzpXcgJ90Ye20rUbY9EiK6LVzPrOgZbzQK2IHNiNXYWiFwECgYEAucEUWy68Amqm3RMmWCPmmC9l9x/7hZZfSZyMCENXb2vj7Jf1bbJnPmxIXxy/afi1Co66CiVDgv9RH2n+tJ56p8jIRsmBDHHfQosw4IiewoFGUSowYD5ufHVIUwklRIexA59X+bfD/27qUupOh/bbiPssLjgsY6whlLapErctQBo=
30e740e9-234b-41c4-86dd-79deca04de96	161acb41-d2cb-45ff-922b-27e264c53164	certificate	MIICozCCAYsCBgGCAeKgBTANBgkqhkiG9w0BAQsFADAVMRMwEQYDVQQDDApDYXJTZXJ2aWNlMB4XDTIyMDcxNTEyNDE0NVoXDTMyMDcxNTEyNDMyNVowFTETMBEGA1UEAwwKQ2FyU2VydmljZTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAJTlScezVyj0u7dvxwj4lAffBW6pxQmgFlvzdFf6NjiGTW4ZdaLqyz0iy3FBVM+V+y1aZ1C/F/l2Wy98QzMHzM7Xcslqw8iCdBv4dtT2izqnKp221noAV5v28B+jn1TKHHjEo6oot3MhdfzBTixt1Awuq5OoJPJIyt617/IzBwNnhNjWLoBXgEnFm2E3T2DeihKe/aqRumiVXIALvCo6Md77bDgVMtLeEme/Y+q28I5h0O9XAfLaBd88f4nBAO0wqeRGDP3hxCTUX3EAJiffRIkjv/C+RQwQD0bn/H/3SY1gWcpTcH3p4FBlFTy8dw1z8S+Cxu0aBCN6ImjhjU/gJncCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAYACbEYleed/+4udijt62oIAPE27aK0PKx8ERaLLwJTaTWj/YqUYfoF7Wh6wglz6VTAc7P8CaYoBTUjUUS/saLMnptq3UFltYPAxsKbqvt2qGljrB0SKkjwbA2rxv4aJQr4fSDvJLYx6hNxjdMM86YJV0x2U7UJKSV0gR8anZyAFg/wk+WlFdbIfcK/tfjZ5oP8EsLThl7zL/Lzr1GrabkTBOjQ7p2iCqVjkloA4wXGjnMV/mqCaX+/4lp3OFxsahujJE++PDiBPIEwcludVVjYuWaUiwgCQeTiiwYZOWf2wqv3wasul3SwWQxHK2jGDtpk7fQ+kU2cCBVC+74s3uFA==
9f54b845-ddd2-48e0-b471-f486c57e75e3	161acb41-d2cb-45ff-922b-27e264c53164	priority	100
7259a473-921b-4d0d-aeae-6a40349747ee	161acb41-d2cb-45ff-922b-27e264c53164	keyUse	ENC
a90e626a-0eea-4293-8275-20c5566d31f8	235971b1-bb07-41f0-86b1-9ca3e4b6b2ae	allow-default-scopes	true
42824384-11e0-4ceb-b75f-1062298ddb08	832e3675-aab3-47ca-a427-2074d2eb55f4	allow-default-scopes	true
4d5c8fcd-6f14-41da-aacc-17c9c976c13e	ce1408dc-c90a-44e2-bea6-7c63d471c9c4	max-clients	200
beabdabc-7311-412c-8cfc-00a209e586bb	64bf52af-f6a5-4a59-8ca8-45e4debf36fe	allowed-protocol-mapper-types	oidc-full-name-mapper
e8362854-1e8c-4198-9181-c92cd3cca323	64bf52af-f6a5-4a59-8ca8-45e4debf36fe	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
43eed769-d5b7-491c-9433-9fa7d59d2501	64bf52af-f6a5-4a59-8ca8-45e4debf36fe	allowed-protocol-mapper-types	oidc-address-mapper
1875b9d4-f1ac-4bb9-9bab-19e4c5a01322	64bf52af-f6a5-4a59-8ca8-45e4debf36fe	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
5537f0e3-f80e-461d-88d8-1f32f3d1c883	64bf52af-f6a5-4a59-8ca8-45e4debf36fe	allowed-protocol-mapper-types	saml-user-attribute-mapper
5dd9f13b-81c3-4bb4-89c5-180330ca2edc	64bf52af-f6a5-4a59-8ca8-45e4debf36fe	allowed-protocol-mapper-types	saml-user-property-mapper
1167f7c0-7dc0-43b7-a6c0-f7e28bddd40a	64bf52af-f6a5-4a59-8ca8-45e4debf36fe	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
4aec0116-d3c0-4340-8c22-2f2e4fb0a410	64bf52af-f6a5-4a59-8ca8-45e4debf36fe	allowed-protocol-mapper-types	saml-role-list-mapper
6ed04bd7-453b-4efc-8f48-991548025408	b4175965-4b3a-4a85-97b9-9f8ba5b8be79	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6acb5358-276e-47b5-80f8-9f6410048364	b4175965-4b3a-4a85-97b9-9f8ba5b8be79	allowed-protocol-mapper-types	oidc-full-name-mapper
e916e9c9-6bba-4a99-aa5f-462c92759e00	b4175965-4b3a-4a85-97b9-9f8ba5b8be79	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
72edce3c-9b2b-48ae-b7e7-6f780460c3eb	b4175965-4b3a-4a85-97b9-9f8ba5b8be79	allowed-protocol-mapper-types	saml-role-list-mapper
6b786055-b173-4393-a5fe-4f1f4bb0e481	b4175965-4b3a-4a85-97b9-9f8ba5b8be79	allowed-protocol-mapper-types	saml-user-property-mapper
1dee903e-79a0-40b9-bb86-b43c7bf2aa79	b4175965-4b3a-4a85-97b9-9f8ba5b8be79	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
0beae5fd-99e5-4a59-a347-40cb0d22a42c	b4175965-4b3a-4a85-97b9-9f8ba5b8be79	allowed-protocol-mapper-types	oidc-address-mapper
4201c4b7-994b-4220-a657-137925d945cd	b4175965-4b3a-4a85-97b9-9f8ba5b8be79	allowed-protocol-mapper-types	saml-user-attribute-mapper
593c03c9-764c-4794-be3b-78978228466d	df6e7b34-fd4d-4f44-a181-abc6bd6b0b34	host-sending-registration-request-must-match	true
038187d5-8422-4a98-a7ba-2820314146eb	df6e7b34-fd4d-4f44-a181-abc6bd6b0b34	client-uris-must-match	true
3b43356a-565c-45e4-9765-9ea183ab6fe4	dd6dc73b-6fee-42fc-851b-80d6e1ae7add	config-pieces-count	1
1c27b05f-08c6-4988-9675-3527c5609429	dd6dc73b-6fee-42fc-851b-80d6e1ae7add	config-piece-0	{"attributes":[{"name":"username","displayName":"${username}","validations":{"length":{"min":3,"max":255},"username-prohibited-characters":{}}},{"name":"email","displayName":"${email}","validations":{"email":{},"length":{"max":255}}},{"name":"firstName","displayName":"${firstName}","required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"validations":{"length":{"max":255},"person-name-prohibited-characters":{}}},{"name":"lastName","displayName":"${lastName}","required":{"roles":["user"]},"permissions":{"view":["admin","user"],"edit":["admin","user"]},"validations":{"length":{"max":255},"person-name-prohibited-characters":{}}},{"name":"INN","displayName":"ИНН","required":{"roles":["user"],"scopes":["offline_access","phone","microprofile-jwt","MainClintRoles","profile","MainClientAud","address","email","roles","web-origins","acr","role_list"]},"validations":{"pattern":{"pattern":"^(\\\\d{10}|\\\\d{12})$","error-message":"Длина ИНН должна быть 10 или 12"}},"selector":{"scopes":["offline_access","phone","microprofile-jwt","MainClintRoles","profile","MainClientAud","address","email","roles","web-origins","acr","role_list"]},"permissions":{"edit":["user","admin"],"view":["user","admin"]},"annotations":{"":""}}]}
\.


--
-- TOC entry 4164 (class 0 OID 16449)
-- Dependencies: 220
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.composite_role (composite, child_role) FROM stdin;
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	451caffc-65bc-4658-99a7-7287dabfb6c5
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	5054b2b7-a0ed-423e-9bcc-b41915c7f45e
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	2ff46b02-015a-4aaa-ab04-9dd1d16ee1d4
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	5a3cf46a-3d19-40c7-96e7-c1381fdb3db4
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	2e53381c-1a14-4a03-b7e8-2442e54d4900
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	863e1394-a14b-4f23-816d-a10ecf0af313
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	fc2d2abd-afb7-483b-85b3-14279e3036aa
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	260bcd22-94d4-4df9-96e5-0fb1b2e2db40
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	21f4387c-5967-4024-bc57-760e802817ff
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	f12944ac-1766-41c3-bd8b-562c7809baed
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	5fc627fe-b403-41a4-83d9-cbcfbef97b81
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	2f99522f-b0f2-4512-ad9e-1c4b4120dbfc
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	b69821ba-9ed7-488f-b3e4-87effa404c31
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	dbb1356a-0bdd-40d9-9b00-b00e836ac1a3
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	663029b0-c86a-481d-b0cb-c433aa1ca81a
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	eefbeedc-4079-483e-a6e6-056a28e48f16
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	be619438-766e-4881-bdb6-42c428ad1ac4
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	327315ef-d51b-4ea1-928c-5989d57478a8
2e53381c-1a14-4a03-b7e8-2442e54d4900	eefbeedc-4079-483e-a6e6-056a28e48f16
5a3cf46a-3d19-40c7-96e7-c1381fdb3db4	327315ef-d51b-4ea1-928c-5989d57478a8
5a3cf46a-3d19-40c7-96e7-c1381fdb3db4	663029b0-c86a-481d-b0cb-c433aa1ca81a
dea08c49-9aca-4b31-9f11-f16052e6b683	c4300ad2-429b-4527-9f27-33391d8add4f
dea08c49-9aca-4b31-9f11-f16052e6b683	51112b22-585e-469c-b65e-f0512b16ed3e
51112b22-585e-469c-b65e-f0512b16ed3e	3314f8f1-60c3-4766-87b4-d225ac868c11
3620cd51-ed1c-4b43-a051-0d66d9c23075	6bc1a5d2-e1ab-400f-83a3-4df142a52aef
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	3f449110-92b2-4d6b-bc9a-6b666172c73e
dea08c49-9aca-4b31-9f11-f16052e6b683	12b1fec9-7a53-4a4c-b82b-7dcd99006968
dea08c49-9aca-4b31-9f11-f16052e6b683	d6cd864b-704c-49c9-afe0-d6abd14aca90
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	f277f946-fac8-4e6d-b559-cd5e1c585132
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	d67210f2-7e45-424c-aed7-37b8e631de85
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	87218da1-e4f1-4325-86d6-2d887293a78b
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	1c91e2cf-2ba5-4f36-8129-61fc54e0eb6b
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	229ef37a-10bd-42d9-9678-9b187a928480
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	0fa98490-cd28-4ba3-ab92-e2dd38aa7757
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	9af20fe9-25d2-4ac4-8261-186eb9c77129
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	a88175b9-a697-4e34-b7eb-788f5c6ed633
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	8492f585-0ff7-43e8-96c6-1e1609368605
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	bd0bdbed-47bb-4b4b-9e9f-59029ccfaad8
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	e38b7681-f653-4e77-b040-ef9c1927cee4
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	4292efd1-c906-430e-8b2e-2c2ce5dfe921
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	3e0c04c0-bdd0-475b-a9dc-a64c32eda7f6
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	5c8fab78-338e-43d6-b411-60089a36d62e
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	52799593-858e-42c2-91a7-02d1ec9de718
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	ec77644f-6394-45eb-992f-d4c454d1f443
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	1e60fadd-42ac-485a-adbb-95e64701aa23
1c91e2cf-2ba5-4f36-8129-61fc54e0eb6b	52799593-858e-42c2-91a7-02d1ec9de718
87218da1-e4f1-4325-86d6-2d887293a78b	5c8fab78-338e-43d6-b411-60089a36d62e
87218da1-e4f1-4325-86d6-2d887293a78b	1e60fadd-42ac-485a-adbb-95e64701aa23
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	528dada2-22c5-45a3-b610-a4bbf67320d3
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	e9fe846e-b978-4e67-b020-ffbfb8a52f03
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	0675ab5e-d77c-4ce1-a467-fd8d500faa84
2ae3e32f-a4e4-4320-ac7c-818ee71e6321	e291a5f2-3f3a-423e-985a-e4416f0362e9
2ae3e32f-a4e4-4320-ac7c-818ee71e6321	b206c88a-6454-440f-8c09-c5f1eefcc571
3510146a-bc2f-4377-92d4-e0eaa4e9ba7b	5eaa85d1-6a27-4f9b-8686-fb1eb4b9be1c
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	503e9b9d-f963-4276-8630-66460373333b
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	baedcf0e-2b6b-4c4c-b625-e07e6528aeab
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	51fa5a9b-fa89-473c-a39b-bd6db6c195e7
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	2ae3e32f-a4e4-4320-ac7c-818ee71e6321
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	e291a5f2-3f3a-423e-985a-e4416f0362e9
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	187779f4-d45d-4d62-a6ce-8d11f7534dbe
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	e6beb34a-7229-49e6-86a2-41c7dc6c1e21
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	5b35440d-8734-4764-9ec8-62155f1650ff
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	a15955d1-79bb-41f2-816a-dd5645ade738
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	87c4f5b1-5057-4e45-90bc-36b181ad3718
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	93385fec-31af-4829-bf7e-489682346b37
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	76cf96dc-10d8-4660-82ff-a8811d49ef8a
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	7c940e5e-80a7-4cfc-8034-95d2b36c4b2e
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	cc14f478-ce21-4b0a-a68a-0b1c90e2a521
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	dc3fbbd6-6bbd-47ee-94bc-6dce2d364964
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	b206c88a-6454-440f-8c09-c5f1eefcc571
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	5806c85a-bc9a-462b-89c1-13265db2219f
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	ef023afe-7bf9-49a6-8eea-6e9f84a35fa3
ee423b17-fda2-4717-a934-71e6c1989199	99471276-3373-4058-9ca7-6fa711ee287f
ef023afe-7bf9-49a6-8eea-6e9f84a35fa3	76cf96dc-10d8-4660-82ff-a8811d49ef8a
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	59e0372b-a763-4105-9b3d-cae24327352f
\.


--
-- TOC entry 4165 (class 0 OID 16452)
-- Dependencies: 221
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
00164299-2f6c-4dd0-8be8-68cc99991a99	\N	password	9c9ca5de-c0e8-486f-8149-af5111b1d844	1657888960697	\N	{"value":"4gkE/nFd3qHX0Tl0rXSFZi/TYsVMMTJpwI/cGUvNxaJ2YSqXqTVEznm0f0i70GME6dal9pjB1XvYkyNyyARzfw==","salt":"GiJJkPKMa7vl2pCK/iTjzg==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
a3510afd-e879-489a-92bc-37975026af85	\N	password	de1ce17c-8db0-4795-9c38-e00352ff9a76	1658173683027	\N	{"value":"g6FKIXEMElSdtxl+snphxQbm4nReFJp+pT47QHrPTY8Jed7BmmX30Uk5RR7+bZDqeSDsUrFZsAu8SN24DxLQoQ==","salt":"DbeGMlhE7s+oWyISs6S27w==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
1f11c391-fc6b-49a6-b746-9147581a732c	\N	password	43416877-cb87-43ae-8ec8-7cc5c2be949d	1658173721076	\N	{"value":"yi/qKkNIbt93M6/edRJGvXR5/lPpfcEcBvj7lnAlj/5/offWwTXlEBP3yJZLZIh/dEd3KGY0wAdOvb1A5m1L8Q==","salt":"rmEYFKfD34tWAuiHyV7opQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
6e30ab0e-d8dd-49c4-ba3c-eb9e236e4b82	\N	password	6b82d6df-1171-4e29-9fce-c59f5c7e26e2	1658173775632	\N	{"value":"i/zdR6NH2nTCFRPYQYwpW4vggFn46GA7OaFeNpJ6HgGeTObLV39//qJJt7ErT5u3lcuabhOtWP2ygM9NqdxqCw==","salt":"8H8jYxqSCrapGuPd5ln7aQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
4aa36219-5f81-4799-a49f-6f6064f2d3a9	\N	password	6f599df7-ef8f-4b77-9cb9-eff7a38594df	1658173821749	\N	{"value":"urRaDNoRm8rte3hN/3A5MyfWFUGWjwAEb1QGNEQcdbpHuSUgkyDwCTjhjVe+fb7QYG+hUr/suBo3d3nii6gC7w==","salt":"5d7Wnqt79mKrqEnv5nroZw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
238e4ee7-a8f0-4300-b9a1-ff9c3ef28797	\N	password	2457a46a-df3a-41db-aa7a-35cce6b6e246	1658173864179	\N	{"value":"J8ZUa0vAzhVX44lQGH7g1/8cWBACqSn6Gi/MFT7V8eH/85Gv3Q62HQ91jijcrlZLvAVnjVi/dOwJCJfcPnjThg==","salt":"+zGmtleblveDFRvG5xNkVA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
4662f49a-9340-496f-8a71-f5ea1a477bf8	\N	password	c63afc70-54d5-4755-9570-62713302162d	1658173910304	\N	{"value":"X7/LA+iNIo24DglvfugomJDgvpI7qQ26oaQrdVec+mtzO54oLzzj6mrLlFN1SFZpSIi3QZiKn9fDd7LVgZqChg==","salt":"k1vf3DZ+x7h1WBQnzjZP+g==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
f9131d82-5bd2-498f-96fc-2a48bf4373b2	\N	password	8fb67229-c0dd-411e-8c61-40c9972b2d9c	1658173946238	\N	{"value":"Fk7U6yZHNaww2LMiVtughtaXfQOLKADiAfwXSoxA46HP2MoqKUWQny3tDRdGwp2WJmbk7FsgZowkMFFI3ECqOg==","salt":"GXG+8amSn4YEqlrvx4igmA==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
00b8f0af-b6d0-4bc2-b6dc-b821c4a915cd	\N	password	65d91c84-f89d-4ca3-bebe-1f1f3df25c06	1658175445917	\N	{"value":"Ez5TdMgNBcYBeFXiU/sw8peQG2uRYQfITM1+8+l+6K/UBbBmwMQtoIBruZYNXzQJd5/iO6D8I4yruq7I9hGdbA==","salt":"c8s4WJLpdrhJyV8aaZWOfw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- TOC entry 4160 (class 0 OID 16422)
-- Dependencies: 216
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2022-07-15 12:42:35.793444	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	7888955123
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2022-07-15 12:42:35.804554	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	7888955123
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2022-07-15 12:42:35.872483	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	7888955123
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2022-07-15 12:42:35.87888	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	7888955123
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2022-07-15 12:42:36.027225	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	7888955123
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2022-07-15 12:42:36.031364	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	7888955123
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2022-07-15 12:42:36.163376	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	7888955123
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2022-07-15 12:42:36.167438	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	7888955123
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2022-07-15 12:42:36.17459	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	7888955123
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2022-07-15 12:42:36.322393	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	7888955123
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2022-07-15 12:42:36.399634	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	7888955123
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2022-07-15 12:42:36.403118	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	7888955123
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2022-07-15 12:42:36.424751	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	7888955123
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-07-15 12:42:36.469798	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	7888955123
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-07-15 12:42:36.472748	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	7888955123
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-07-15 12:42:36.475832	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	7888955123
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2022-07-15 12:42:36.478633	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	7888955123
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2022-07-15 12:42:36.556237	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	7888955123
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2022-07-15 12:42:36.63082	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	7888955123
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2022-07-15 12:42:36.637758	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	7888955123
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-07-15 12:42:37.379867	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	7888955123
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2022-07-15 12:42:36.640808	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	7888955123
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2022-07-15 12:42:36.644368	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	7888955123
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2022-07-15 12:42:36.679314	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	7888955123
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2022-07-15 12:42:36.686426	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	7888955123
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2022-07-15 12:42:36.689142	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	7888955123
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2022-07-15 12:42:36.747085	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	7888955123
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2022-07-15 12:42:36.872867	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	7888955123
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2022-07-15 12:42:36.877009	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	7888955123
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2022-07-15 12:42:36.980277	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	7888955123
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2022-07-15 12:42:37.00377	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	7888955123
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2022-07-15 12:42:37.030564	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	7888955123
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2022-07-15 12:42:37.036662	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	7888955123
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-07-15 12:42:37.043993	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	7888955123
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-07-15 12:42:37.046765	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	7888955123
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-07-15 12:42:37.084877	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	7888955123
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2022-07-15 12:42:37.09164	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	7888955123
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2022-07-15 12:42:37.101683	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	7888955123
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2022-07-15 12:42:37.10734	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	7888955123
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2022-07-15 12:42:37.112859	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	7888955123
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-07-15 12:42:37.11577	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	7888955123
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-07-15 12:42:37.118659	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	7888955123
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2022-07-15 12:42:37.124093	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	7888955123
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2022-07-15 12:42:37.367839	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	7888955123
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2022-07-15 12:42:37.373716	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	7888955123
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-07-15 12:42:37.385853	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	7888955123
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-07-15 12:42:37.388444	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	7888955123
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-07-15 12:42:37.457056	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	7888955123
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2022-07-15 12:42:37.463037	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	7888955123
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2022-07-15 12:42:37.561507	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	7888955123
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2022-07-15 12:42:37.617866	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	7888955123
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2022-07-15 12:42:37.623418	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	7888955123
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2022-07-15 12:42:37.62736	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	7888955123
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2022-07-15 12:42:37.630765	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	7888955123
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-07-15 12:42:37.640682	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	7888955123
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-07-15 12:42:37.64858	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	7888955123
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-07-15 12:42:37.679504	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	7888955123
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2022-07-15 12:42:37.857758	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	7888955123
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2022-07-15 12:42:37.899014	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	7888955123
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2022-07-15 12:42:37.907885	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	7888955123
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-07-15 12:42:37.920187	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	7888955123
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2022-07-15 12:42:37.929829	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	7888955123
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2022-07-15 12:42:37.935034	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	7888955123
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2022-07-15 12:42:37.938491	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	7888955123
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2022-07-15 12:42:37.942498	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	7888955123
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2022-07-15 12:42:37.965779	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	7888955123
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2022-07-15 12:42:37.974637	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	7888955123
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2022-07-15 12:42:37.980515	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	7888955123
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2022-07-15 12:42:37.99433	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	7888955123
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2022-07-15 12:42:38.001147	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	7888955123
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2022-07-15 12:42:38.006184	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	7888955123
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-07-15 12:42:38.014528	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	7888955123
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-07-15 12:42:38.021008	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	7888955123
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-07-15 12:42:38.023544	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	7888955123
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-07-15 12:42:38.044528	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	7888955123
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2022-07-15 12:42:38.055156	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	7888955123
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-07-15 12:42:38.060385	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	7888955123
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-07-15 12:42:38.063186	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	7888955123
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-07-15 12:42:38.089894	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	7888955123
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2022-07-15 12:42:38.092521	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	7888955123
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-07-15 12:42:38.102074	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	7888955123
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-07-15 12:42:38.104945	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	7888955123
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-07-15 12:42:38.110503	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	7888955123
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-07-15 12:42:38.113169	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	7888955123
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2022-07-15 12:42:38.124473	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	7888955123
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2022-07-15 12:42:38.131944	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	7888955123
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-07-15 12:42:38.143213	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	7888955123
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2022-07-15 12:42:38.162512	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	7888955123
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-07-15 12:42:38.170336	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	7888955123
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-07-15 12:42:38.180248	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	7888955123
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-07-15 12:42:38.190108	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	7888955123
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-07-15 12:42:38.203289	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	7888955123
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-07-15 12:42:38.206141	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	7888955123
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-07-15 12:42:38.220062	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	7888955123
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-07-15 12:42:38.222716	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	7888955123
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2022-07-15 12:42:38.229402	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	7888955123
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-07-15 12:42:38.248241	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	7888955123
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-07-15 12:42:38.250957	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	7888955123
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-07-15 12:42:38.264377	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	7888955123
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-07-15 12:42:38.274376	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	7888955123
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-07-15 12:42:38.277069	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	7888955123
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-07-15 12:42:38.286596	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	7888955123
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2022-07-15 12:42:38.292123	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	7888955123
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2022-07-15 12:42:38.298998	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	7888955123
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2022-07-15 12:42:38.308273	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	7888955123
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2022-07-15 12:42:38.317638	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	7888955123
\.


--
-- TOC entry 4159 (class 0 OID 16417)
-- Dependencies: 215
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- TOC entry 4243 (class 0 OID 17813)
-- Dependencies: 299
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	e6d8382e-711e-4358-a793-8d0410f135a6	f
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	cf4be498-ee7b-4bf9-abed-1abc5f92f5b7	t
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80177194-b812-4b51-9849-39eb37680744	t
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	37ba9270-2c13-40a6-af18-06d686f8032c	t
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	8b82b699-f981-45c7-9c6c-d9397222e686	f
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	02dcb303-0daa-48a4-8475-c75ad06c91d8	f
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	f94047ac-8dad-4148-8005-1668cdaf0444	t
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	9c9cafdd-5ef6-4ea0-b213-294583e1262e	t
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	e7179f97-906b-410c-9858-d914fc615640	f
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	edf46eac-11c1-41c5-ab5a-327d66e020d1	t
d4586994-289c-4313-8f41-4aa5d69533be	7685c196-96f7-494a-ae77-9efee31e04dc	f
d4586994-289c-4313-8f41-4aa5d69533be	5318f39c-b56c-4f9f-8e97-06e460b61133	t
d4586994-289c-4313-8f41-4aa5d69533be	099a15a6-9981-4a44-ac7f-e005aa001921	t
d4586994-289c-4313-8f41-4aa5d69533be	07752d66-7fd8-4f5c-8795-292739316af1	t
d4586994-289c-4313-8f41-4aa5d69533be	0bb04aa7-2b18-4a1b-abcc-9e7bd6867610	f
d4586994-289c-4313-8f41-4aa5d69533be	47f023f0-a5b2-44da-b99c-b37beed3d275	f
d4586994-289c-4313-8f41-4aa5d69533be	a6827cce-ece1-4723-9965-1dbf77c74a23	t
d4586994-289c-4313-8f41-4aa5d69533be	aaed53ea-4c85-4c8f-a4bb-37acafdebce5	t
d4586994-289c-4313-8f41-4aa5d69533be	5570ac38-49c1-4ae6-bb7a-0196acb085d2	f
d4586994-289c-4313-8f41-4aa5d69533be	d31b676c-cadd-4f9b-ae8a-76f1f235cf45	t
d4586994-289c-4313-8f41-4aa5d69533be	f3059e34-6775-4cb3-a0ad-5b80647993c3	t
\.


--
-- TOC entry 4166 (class 0 OID 16457)
-- Dependencies: 222
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- TOC entry 4231 (class 0 OID 17512)
-- Dependencies: 287
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- TOC entry 4232 (class 0 OID 17517)
-- Dependencies: 288
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 4245 (class 0 OID 17839)
-- Dependencies: 301
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4233 (class 0 OID 17526)
-- Dependencies: 289
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- TOC entry 4234 (class 0 OID 17535)
-- Dependencies: 290
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4235 (class 0 OID 17538)
-- Dependencies: 291
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4236 (class 0 OID 17544)
-- Dependencies: 292
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- TOC entry 4189 (class 0 OID 16834)
-- Dependencies: 245
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- TOC entry 4239 (class 0 OID 17609)
-- Dependencies: 295
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- TOC entry 4215 (class 0 OID 17236)
-- Dependencies: 271
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- TOC entry 4214 (class 0 OID 17233)
-- Dependencies: 270
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- TOC entry 4190 (class 0 OID 16839)
-- Dependencies: 246
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- TOC entry 4191 (class 0 OID 16848)
-- Dependencies: 247
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 4196 (class 0 OID 16952)
-- Dependencies: 252
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- TOC entry 4197 (class 0 OID 16957)
-- Dependencies: 253
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 4213 (class 0 OID 17230)
-- Dependencies: 269
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
c8582b70-5a00-4f36-ada1-2fed0ae2b8d7	Default	 	04ff9ad3-2ef2-41cb-be23-7572497fc0d7
\.


--
-- TOC entry 4167 (class 0 OID 16465)
-- Dependencies: 223
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
dea08c49-9aca-4b31-9f11-f16052e6b683	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	f	${role_default-roles}	default-roles-master	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N	\N
451caffc-65bc-4658-99a7-7287dabfb6c5	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	f	${role_create-realm}	create-realm	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N	\N
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	f	${role_admin}	admin	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N	\N
5054b2b7-a0ed-423e-9bcc-b41915c7f45e	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_create-client}	create-client	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
2ff46b02-015a-4aaa-ab04-9dd1d16ee1d4	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_view-realm}	view-realm	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
5a3cf46a-3d19-40c7-96e7-c1381fdb3db4	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_view-users}	view-users	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
2e53381c-1a14-4a03-b7e8-2442e54d4900	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_view-clients}	view-clients	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
863e1394-a14b-4f23-816d-a10ecf0af313	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_view-events}	view-events	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
fc2d2abd-afb7-483b-85b3-14279e3036aa	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_view-identity-providers}	view-identity-providers	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
260bcd22-94d4-4df9-96e5-0fb1b2e2db40	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_view-authorization}	view-authorization	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
21f4387c-5967-4024-bc57-760e802817ff	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_manage-realm}	manage-realm	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
f12944ac-1766-41c3-bd8b-562c7809baed	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_manage-users}	manage-users	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
5fc627fe-b403-41a4-83d9-cbcfbef97b81	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_manage-clients}	manage-clients	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
2f99522f-b0f2-4512-ad9e-1c4b4120dbfc	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_manage-events}	manage-events	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
b69821ba-9ed7-488f-b3e4-87effa404c31	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_manage-identity-providers}	manage-identity-providers	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
dbb1356a-0bdd-40d9-9b00-b00e836ac1a3	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_manage-authorization}	manage-authorization	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
663029b0-c86a-481d-b0cb-c433aa1ca81a	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_query-users}	query-users	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
eefbeedc-4079-483e-a6e6-056a28e48f16	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_query-clients}	query-clients	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
be619438-766e-4881-bdb6-42c428ad1ac4	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_query-realms}	query-realms	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
327315ef-d51b-4ea1-928c-5989d57478a8	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_query-groups}	query-groups	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
c4300ad2-429b-4527-9f27-33391d8add4f	c75332da-5ed1-435c-b1d3-7581f2ea7db3	t	${role_view-profile}	view-profile	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	c75332da-5ed1-435c-b1d3-7581f2ea7db3	\N
51112b22-585e-469c-b65e-f0512b16ed3e	c75332da-5ed1-435c-b1d3-7581f2ea7db3	t	${role_manage-account}	manage-account	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	c75332da-5ed1-435c-b1d3-7581f2ea7db3	\N
3314f8f1-60c3-4766-87b4-d225ac868c11	c75332da-5ed1-435c-b1d3-7581f2ea7db3	t	${role_manage-account-links}	manage-account-links	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	c75332da-5ed1-435c-b1d3-7581f2ea7db3	\N
70a4fa5e-3203-4c06-8870-db821d61e127	c75332da-5ed1-435c-b1d3-7581f2ea7db3	t	${role_view-applications}	view-applications	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	c75332da-5ed1-435c-b1d3-7581f2ea7db3	\N
6bc1a5d2-e1ab-400f-83a3-4df142a52aef	c75332da-5ed1-435c-b1d3-7581f2ea7db3	t	${role_view-consent}	view-consent	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	c75332da-5ed1-435c-b1d3-7581f2ea7db3	\N
3620cd51-ed1c-4b43-a051-0d66d9c23075	c75332da-5ed1-435c-b1d3-7581f2ea7db3	t	${role_manage-consent}	manage-consent	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	c75332da-5ed1-435c-b1d3-7581f2ea7db3	\N
b53a9b1a-8219-4553-bfc0-d101960925a7	c75332da-5ed1-435c-b1d3-7581f2ea7db3	t	${role_delete-account}	delete-account	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	c75332da-5ed1-435c-b1d3-7581f2ea7db3	\N
6fdc7b31-06ab-4972-ac9a-829608c2416b	7177855c-bf32-4806-9a88-dc43b8e4ee5d	t	${role_read-token}	read-token	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	7177855c-bf32-4806-9a88-dc43b8e4ee5d	\N
3f449110-92b2-4d6b-bc9a-6b666172c73e	1f1f2692-dc36-47eb-af4c-eb50d1f98572	t	${role_impersonation}	impersonation	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1f1f2692-dc36-47eb-af4c-eb50d1f98572	\N
12b1fec9-7a53-4a4c-b82b-7dcd99006968	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	f	${role_offline-access}	offline_access	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N	\N
d6cd864b-704c-49c9-afe0-d6abd14aca90	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	f	${role_uma_authorization}	uma_authorization	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	\N	\N
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	d4586994-289c-4313-8f41-4aa5d69533be	f	${role_default-roles}	default-roles-carservice	d4586994-289c-4313-8f41-4aa5d69533be	\N	\N
f277f946-fac8-4e6d-b559-cd5e1c585132	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_create-client}	create-client	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
d67210f2-7e45-424c-aed7-37b8e631de85	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_view-realm}	view-realm	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
87218da1-e4f1-4325-86d6-2d887293a78b	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_view-users}	view-users	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
1c91e2cf-2ba5-4f36-8129-61fc54e0eb6b	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_view-clients}	view-clients	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
229ef37a-10bd-42d9-9678-9b187a928480	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_view-events}	view-events	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
0fa98490-cd28-4ba3-ab92-e2dd38aa7757	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_view-identity-providers}	view-identity-providers	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
9af20fe9-25d2-4ac4-8261-186eb9c77129	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_view-authorization}	view-authorization	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
a88175b9-a697-4e34-b7eb-788f5c6ed633	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_manage-realm}	manage-realm	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
8492f585-0ff7-43e8-96c6-1e1609368605	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_manage-users}	manage-users	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
bd0bdbed-47bb-4b4b-9e9f-59029ccfaad8	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_manage-clients}	manage-clients	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
e38b7681-f653-4e77-b040-ef9c1927cee4	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_manage-events}	manage-events	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
4292efd1-c906-430e-8b2e-2c2ce5dfe921	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_manage-identity-providers}	manage-identity-providers	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
3e0c04c0-bdd0-475b-a9dc-a64c32eda7f6	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_manage-authorization}	manage-authorization	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
5c8fab78-338e-43d6-b411-60089a36d62e	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_query-users}	query-users	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
52799593-858e-42c2-91a7-02d1ec9de718	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_query-clients}	query-clients	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
ec77644f-6394-45eb-992f-d4c454d1f443	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_query-realms}	query-realms	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
1e60fadd-42ac-485a-adbb-95e64701aa23	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_query-groups}	query-groups	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
528dada2-22c5-45a3-b610-a4bbf67320d3	80e39e74-1dfd-4876-b008-9ddb11aaa585	t	${role_impersonation}	impersonation	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	80e39e74-1dfd-4876-b008-9ddb11aaa585	\N
e9fe846e-b978-4e67-b020-ffbfb8a52f03	d4586994-289c-4313-8f41-4aa5d69533be	f	${role_offline-access}	offline_access	d4586994-289c-4313-8f41-4aa5d69533be	\N	\N
0675ab5e-d77c-4ce1-a467-fd8d500faa84	d4586994-289c-4313-8f41-4aa5d69533be	f	${role_uma_authorization}	uma_authorization	d4586994-289c-4313-8f41-4aa5d69533be	\N	\N
ca619e5e-ff35-4de9-802d-a69303297b88	fc797aba-a792-4450-9575-d92c74afb436	t	\N	customer	d4586994-289c-4313-8f41-4aa5d69533be	fc797aba-a792-4450-9575-d92c74afb436	\N
76cf96dc-10d8-4660-82ff-a8811d49ef8a	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_query-clients}	query-clients	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
93385fec-31af-4829-bf7e-489682346b37	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_manage-clients}	manage-clients	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
7c940e5e-80a7-4cfc-8034-95d2b36c4b2e	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_view-realm}	view-realm	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
5b35440d-8734-4764-9ec8-62155f1650ff	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_manage-authorization}	manage-authorization	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
cc14f478-ce21-4b0a-a68a-0b1c90e2a521	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_manage-realm}	manage-realm	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
e291a5f2-3f3a-423e-985a-e4416f0362e9	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_query-users}	query-users	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
5806c85a-bc9a-462b-89c1-13265db2219f	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_view-identity-providers}	view-identity-providers	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
2ae3e32f-a4e4-4320-ac7c-818ee71e6321	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_view-users}	view-users	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
a15955d1-79bb-41f2-816a-dd5645ade738	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_view-authorization}	view-authorization	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
4c3197ce-0c0a-46b7-8af6-9c4142a6530b	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_realm-admin}	realm-admin	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
51fa5a9b-fa89-473c-a39b-bd6db6c195e7	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_manage-events}	manage-events	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
b206c88a-6454-440f-8c09-c5f1eefcc571	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_query-groups}	query-groups	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
e6beb34a-7229-49e6-86a2-41c7dc6c1e21	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_query-realms}	query-realms	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
87c4f5b1-5057-4e45-90bc-36b181ad3718	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_manage-identity-providers}	manage-identity-providers	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
503e9b9d-f963-4276-8630-66460373333b	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_view-events}	view-events	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
187779f4-d45d-4d62-a6ce-8d11f7534dbe	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_manage-users}	manage-users	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
dc3fbbd6-6bbd-47ee-94bc-6dce2d364964	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_create-client}	create-client	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
ef023afe-7bf9-49a6-8eea-6e9f84a35fa3	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_view-clients}	view-clients	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
baedcf0e-2b6b-4c4c-b625-e07e6528aeab	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	t	${role_impersonation}	impersonation	d4586994-289c-4313-8f41-4aa5d69533be	0cac32e9-fc10-44ab-8066-6f3fdf7824a3	\N
b534fd89-f578-4894-9bff-55c66cbaee3a	4bb9ceb1-bec4-41aa-9da8-e2be43657635	t	${role_read-token}	read-token	d4586994-289c-4313-8f41-4aa5d69533be	4bb9ceb1-bec4-41aa-9da8-e2be43657635	\N
99471276-3373-4058-9ca7-6fa711ee287f	d2fa367e-e155-41d8-8392-c6b18eab5c67	t	${role_manage-account-links}	manage-account-links	d4586994-289c-4313-8f41-4aa5d69533be	d2fa367e-e155-41d8-8392-c6b18eab5c67	\N
5eaa85d1-6a27-4f9b-8686-fb1eb4b9be1c	d2fa367e-e155-41d8-8392-c6b18eab5c67	t	${role_view-consent}	view-consent	d4586994-289c-4313-8f41-4aa5d69533be	d2fa367e-e155-41d8-8392-c6b18eab5c67	\N
a9d64732-7f7a-4b24-a2ff-1f94459fe711	d2fa367e-e155-41d8-8392-c6b18eab5c67	t	${role_delete-account}	delete-account	d4586994-289c-4313-8f41-4aa5d69533be	d2fa367e-e155-41d8-8392-c6b18eab5c67	\N
3510146a-bc2f-4377-92d4-e0eaa4e9ba7b	d2fa367e-e155-41d8-8392-c6b18eab5c67	t	${role_manage-consent}	manage-consent	d4586994-289c-4313-8f41-4aa5d69533be	d2fa367e-e155-41d8-8392-c6b18eab5c67	\N
425b7ee5-21c1-4239-bba8-acdffd175b16	d2fa367e-e155-41d8-8392-c6b18eab5c67	t	${role_view-applications}	view-applications	d4586994-289c-4313-8f41-4aa5d69533be	d2fa367e-e155-41d8-8392-c6b18eab5c67	\N
e9a922b9-9304-434b-a460-b74ec929b8e6	d2fa367e-e155-41d8-8392-c6b18eab5c67	t	${role_view-profile}	view-profile	d4586994-289c-4313-8f41-4aa5d69533be	d2fa367e-e155-41d8-8392-c6b18eab5c67	\N
ee423b17-fda2-4717-a934-71e6c1989199	d2fa367e-e155-41d8-8392-c6b18eab5c67	t	${role_manage-account}	manage-account	d4586994-289c-4313-8f41-4aa5d69533be	d2fa367e-e155-41d8-8392-c6b18eab5c67	\N
a065f7b7-2aa9-4278-ab5a-833693f543d9	fc797aba-a792-4450-9575-d92c74afb436	t	\N	admin	d4586994-289c-4313-8f41-4aa5d69533be	fc797aba-a792-4450-9575-d92c74afb436	\N
eb0ad1c3-45fb-41da-8b88-4f5756664839	fc797aba-a792-4450-9575-d92c74afb436	t	\N	executor	d4586994-289c-4313-8f41-4aa5d69533be	fc797aba-a792-4450-9575-d92c74afb436	\N
59e0372b-a763-4105-9b3d-cae24327352f	d4586994-289c-4313-8f41-4aa5d69533be	f		customer	d4586994-289c-4313-8f41-4aa5d69533be	\N	\N
\.


--
-- TOC entry 4154 (class 0 OID 16386)
-- Dependencies: 210
-- Data for Name: logs; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.logs (id, date, thread, level, logger, log_user, message, error) FROM stdin;
\.


--
-- TOC entry 4195 (class 0 OID 16949)
-- Dependencies: 251
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.migration_model (id, version, update_time) FROM stdin;
737g9	18.0.2	1657888958
\.


--
-- TOC entry 4212 (class 0 OID 17221)
-- Dependencies: 268
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 4211 (class 0 OID 17216)
-- Dependencies: 267
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- TOC entry 4225 (class 0 OID 17435)
-- Dependencies: 281
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
\.


--
-- TOC entry 4187 (class 0 OID 16823)
-- Dependencies: 243
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
43a8f0a6-a180-4c9e-b81b-460fc26f4102	audience resolve	openid-connect	oidc-audience-resolve-mapper	7af5eb91-e11b-417c-bfb9-92f00598c4e1	\N
0e5207e3-926f-411b-8428-84cc8f9ac430	locale	openid-connect	oidc-usermodel-attribute-mapper	f1e904a5-65c9-4c8d-902d-d56dc02a86c8	\N
7489b703-b886-4d9a-8db0-4d7a27cd0ca1	role list	saml	saml-role-list-mapper	\N	cf4be498-ee7b-4bf9-abed-1abc5f92f5b7
399cf4d2-5a34-4b33-8d2b-5388436d44a1	full name	openid-connect	oidc-full-name-mapper	\N	80177194-b812-4b51-9849-39eb37680744
afc3c160-d8fe-49c9-98fd-0998399cb5da	family name	openid-connect	oidc-usermodel-property-mapper	\N	80177194-b812-4b51-9849-39eb37680744
00f7747d-53b4-428e-a067-8c73b8331670	given name	openid-connect	oidc-usermodel-property-mapper	\N	80177194-b812-4b51-9849-39eb37680744
24558c89-8f91-4ef2-a313-f94a26459e2b	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	80177194-b812-4b51-9849-39eb37680744
414538d4-900c-4023-a467-d427ead24f39	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	80177194-b812-4b51-9849-39eb37680744
cc49dc9a-cc11-4873-b7e4-4dcfdace4889	username	openid-connect	oidc-usermodel-property-mapper	\N	80177194-b812-4b51-9849-39eb37680744
ea6d27de-15fa-4e36-8ae5-46613af1060a	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	80177194-b812-4b51-9849-39eb37680744
e8cb2598-91db-492b-bd31-f7c4c6329990	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	80177194-b812-4b51-9849-39eb37680744
e55e731e-73bf-47e0-a9f1-b2b9fb90a6c3	website	openid-connect	oidc-usermodel-attribute-mapper	\N	80177194-b812-4b51-9849-39eb37680744
dcc58e94-718a-404d-8b4e-877c99453229	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	80177194-b812-4b51-9849-39eb37680744
4d9bc276-b28d-4edc-9e15-15896a77374c	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	80177194-b812-4b51-9849-39eb37680744
e6c536b8-3b97-456a-9c50-b82f5afe5323	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	80177194-b812-4b51-9849-39eb37680744
14a15138-bf1d-45ee-91ac-7a90c8a8406b	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	80177194-b812-4b51-9849-39eb37680744
d553aad5-948f-411a-94db-85bf6d5723b5	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	80177194-b812-4b51-9849-39eb37680744
417f6209-7801-4f48-9812-36a42f51fc6e	email	openid-connect	oidc-usermodel-property-mapper	\N	37ba9270-2c13-40a6-af18-06d686f8032c
ceac68b7-aff8-43b2-94dd-ffab71c679c3	email verified	openid-connect	oidc-usermodel-property-mapper	\N	37ba9270-2c13-40a6-af18-06d686f8032c
bd6df7d0-fa9f-4f99-b83c-42d819a6389e	address	openid-connect	oidc-address-mapper	\N	8b82b699-f981-45c7-9c6c-d9397222e686
7cb6ccd6-7ff1-4167-ab12-a501909a4016	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	02dcb303-0daa-48a4-8475-c75ad06c91d8
e7b8c546-206a-4da7-9c17-ba6a7205a147	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	02dcb303-0daa-48a4-8475-c75ad06c91d8
c9e21d2a-16b1-42d4-aa0c-70ae00b12fe9	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	f94047ac-8dad-4148-8005-1668cdaf0444
865c7b50-65ea-4893-b9e1-f671e65cb2b7	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	f94047ac-8dad-4148-8005-1668cdaf0444
d8dba50c-62e4-4824-a075-0b45915a2265	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	f94047ac-8dad-4148-8005-1668cdaf0444
fb9da6ae-52eb-4c55-bbb1-475bc298deb5	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	9c9cafdd-5ef6-4ea0-b213-294583e1262e
a436ebb4-881d-42d7-b25f-4633ae95a077	upn	openid-connect	oidc-usermodel-property-mapper	\N	e7179f97-906b-410c-9858-d914fc615640
c44773b1-544e-484d-8a92-c67c5ae5075a	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	e7179f97-906b-410c-9858-d914fc615640
fb1c336a-fa6e-4a0f-8282-93a04f935eae	acr loa level	openid-connect	oidc-acr-mapper	\N	edf46eac-11c1-41c5-ab5a-327d66e020d1
674defc1-0edb-4032-a43d-cd23ca0887f7	role list	saml	saml-role-list-mapper	\N	5318f39c-b56c-4f9f-8e97-06e460b61133
7962823f-7d59-4444-b36a-194a5f1f5ae5	full name	openid-connect	oidc-full-name-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
5fdeb90e-86fe-4a41-bcea-63b3b0e22daa	family name	openid-connect	oidc-usermodel-property-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
7251013a-d2d5-49ac-b0ec-2443c7e3a9ea	given name	openid-connect	oidc-usermodel-property-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
b48883d1-365b-4635-bae3-7dcacb2aac93	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
44a79078-8c7d-495a-98f6-4d921bf95c4d	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
7ce9f967-0d89-4b91-ba66-9d309de1af0e	username	openid-connect	oidc-usermodel-property-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
b9ec9298-c39b-4642-9e19-5bc16643db9a	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
14b391e7-eea0-472e-90f8-159837391210	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
f53d81e6-29de-4281-bde9-5fa1528bbce7	website	openid-connect	oidc-usermodel-attribute-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
176b7ca2-a3a5-444c-ba35-13a5ad8b46bc	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
9a9138f5-d5c1-4984-9de4-6bea568ccf8c	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
c9956d3a-5120-4927-9b3c-d26d85cab945	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
5ad6fcec-453c-44f1-81e0-a19ac713c36f	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
e9ea1e2e-9969-45ff-b5e7-216333c885ba	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	099a15a6-9981-4a44-ac7f-e005aa001921
e23457c8-c594-42e9-9ddd-c11f1144a530	email	openid-connect	oidc-usermodel-property-mapper	\N	07752d66-7fd8-4f5c-8795-292739316af1
c9af2c92-a373-4897-9ba0-fa04623aa6af	email verified	openid-connect	oidc-usermodel-property-mapper	\N	07752d66-7fd8-4f5c-8795-292739316af1
ad734b9a-d5d9-4c2e-bee2-9fb21756781b	address	openid-connect	oidc-address-mapper	\N	0bb04aa7-2b18-4a1b-abcc-9e7bd6867610
d2015d21-6e32-4f54-a9b3-2c819fcdf1a1	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	47f023f0-a5b2-44da-b99c-b37beed3d275
68b9276a-72a0-4cfd-8956-7361c6a81101	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	47f023f0-a5b2-44da-b99c-b37beed3d275
ac48d9a2-98b9-4d48-a6c1-85480ae8b04b	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	a6827cce-ece1-4723-9965-1dbf77c74a23
0ec95d77-f2b1-47df-b7fe-0ae963e5c805	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	a6827cce-ece1-4723-9965-1dbf77c74a23
85ff6a63-6b5e-47f7-abb9-833d7c83cffe	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	a6827cce-ece1-4723-9965-1dbf77c74a23
f54ea56a-ffc5-4a66-bf49-0bf37df8831d	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	aaed53ea-4c85-4c8f-a4bb-37acafdebce5
71da6765-7c94-4705-818f-a12481ac04b1	upn	openid-connect	oidc-usermodel-property-mapper	\N	5570ac38-49c1-4ae6-bb7a-0196acb085d2
95cb6039-db28-4013-b8a5-dd56daada82f	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	5570ac38-49c1-4ae6-bb7a-0196acb085d2
cb49f80f-43f3-4b6c-af36-571233dd6846	acr loa level	openid-connect	oidc-acr-mapper	\N	d31b676c-cadd-4f9b-ae8a-76f1f235cf45
cbdf190f-2b39-44d6-8465-ad30f0ab8ebe	locale	openid-connect	oidc-usermodel-attribute-mapper	15bff922-9d6c-425a-b6e5-a0b17d0e8886	\N
b554016d-dbac-4fcb-b282-cf3f2a1dfe7a	audience resolve	openid-connect	oidc-audience-resolve-mapper	04266c67-e910-4d4c-b09e-fcc5f63cf3e2	\N
b1fe4871-aad5-4b87-885e-2f4c413cb16e	roles	openid-connect	oidc-usermodel-client-role-mapper	\N	f3059e34-6775-4cb3-a0ad-5b80647993c3
30db5973-0712-4feb-a579-bd4aa3a596bf	aud	openid-connect	oidc-audience-mapper	\N	0cbf88f4-3051-45b9-83d0-9c364d0b911a
5d22de32-3bb8-480d-bba9-94ab246c4637	INN	openid-connect	oidc-usermodel-attribute-mapper	\N	c29c4562-fcd5-4c90-b245-8e47647e9fd2
b1305659-e3e2-4e34-99b6-92ae64bcba4c	RealmRoles	openid-connect	oidc-usermodel-realm-role-mapper	\N	f3059e34-6775-4cb3-a0ad-5b80647993c3
\.


--
-- TOC entry 4188 (class 0 OID 16829)
-- Dependencies: 244
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
0e5207e3-926f-411b-8428-84cc8f9ac430	true	userinfo.token.claim
0e5207e3-926f-411b-8428-84cc8f9ac430	locale	user.attribute
0e5207e3-926f-411b-8428-84cc8f9ac430	true	id.token.claim
0e5207e3-926f-411b-8428-84cc8f9ac430	true	access.token.claim
0e5207e3-926f-411b-8428-84cc8f9ac430	locale	claim.name
0e5207e3-926f-411b-8428-84cc8f9ac430	String	jsonType.label
7489b703-b886-4d9a-8db0-4d7a27cd0ca1	false	single
7489b703-b886-4d9a-8db0-4d7a27cd0ca1	Basic	attribute.nameformat
7489b703-b886-4d9a-8db0-4d7a27cd0ca1	Role	attribute.name
00f7747d-53b4-428e-a067-8c73b8331670	true	userinfo.token.claim
00f7747d-53b4-428e-a067-8c73b8331670	firstName	user.attribute
00f7747d-53b4-428e-a067-8c73b8331670	true	id.token.claim
00f7747d-53b4-428e-a067-8c73b8331670	true	access.token.claim
00f7747d-53b4-428e-a067-8c73b8331670	given_name	claim.name
00f7747d-53b4-428e-a067-8c73b8331670	String	jsonType.label
14a15138-bf1d-45ee-91ac-7a90c8a8406b	true	userinfo.token.claim
14a15138-bf1d-45ee-91ac-7a90c8a8406b	locale	user.attribute
14a15138-bf1d-45ee-91ac-7a90c8a8406b	true	id.token.claim
14a15138-bf1d-45ee-91ac-7a90c8a8406b	true	access.token.claim
14a15138-bf1d-45ee-91ac-7a90c8a8406b	locale	claim.name
14a15138-bf1d-45ee-91ac-7a90c8a8406b	String	jsonType.label
24558c89-8f91-4ef2-a313-f94a26459e2b	true	userinfo.token.claim
24558c89-8f91-4ef2-a313-f94a26459e2b	middleName	user.attribute
24558c89-8f91-4ef2-a313-f94a26459e2b	true	id.token.claim
24558c89-8f91-4ef2-a313-f94a26459e2b	true	access.token.claim
24558c89-8f91-4ef2-a313-f94a26459e2b	middle_name	claim.name
24558c89-8f91-4ef2-a313-f94a26459e2b	String	jsonType.label
399cf4d2-5a34-4b33-8d2b-5388436d44a1	true	userinfo.token.claim
399cf4d2-5a34-4b33-8d2b-5388436d44a1	true	id.token.claim
399cf4d2-5a34-4b33-8d2b-5388436d44a1	true	access.token.claim
414538d4-900c-4023-a467-d427ead24f39	true	userinfo.token.claim
414538d4-900c-4023-a467-d427ead24f39	nickname	user.attribute
414538d4-900c-4023-a467-d427ead24f39	true	id.token.claim
414538d4-900c-4023-a467-d427ead24f39	true	access.token.claim
414538d4-900c-4023-a467-d427ead24f39	nickname	claim.name
414538d4-900c-4023-a467-d427ead24f39	String	jsonType.label
4d9bc276-b28d-4edc-9e15-15896a77374c	true	userinfo.token.claim
4d9bc276-b28d-4edc-9e15-15896a77374c	birthdate	user.attribute
4d9bc276-b28d-4edc-9e15-15896a77374c	true	id.token.claim
4d9bc276-b28d-4edc-9e15-15896a77374c	true	access.token.claim
4d9bc276-b28d-4edc-9e15-15896a77374c	birthdate	claim.name
4d9bc276-b28d-4edc-9e15-15896a77374c	String	jsonType.label
afc3c160-d8fe-49c9-98fd-0998399cb5da	true	userinfo.token.claim
afc3c160-d8fe-49c9-98fd-0998399cb5da	lastName	user.attribute
afc3c160-d8fe-49c9-98fd-0998399cb5da	true	id.token.claim
afc3c160-d8fe-49c9-98fd-0998399cb5da	true	access.token.claim
afc3c160-d8fe-49c9-98fd-0998399cb5da	family_name	claim.name
afc3c160-d8fe-49c9-98fd-0998399cb5da	String	jsonType.label
cc49dc9a-cc11-4873-b7e4-4dcfdace4889	true	userinfo.token.claim
cc49dc9a-cc11-4873-b7e4-4dcfdace4889	username	user.attribute
cc49dc9a-cc11-4873-b7e4-4dcfdace4889	true	id.token.claim
cc49dc9a-cc11-4873-b7e4-4dcfdace4889	true	access.token.claim
cc49dc9a-cc11-4873-b7e4-4dcfdace4889	preferred_username	claim.name
cc49dc9a-cc11-4873-b7e4-4dcfdace4889	String	jsonType.label
d553aad5-948f-411a-94db-85bf6d5723b5	true	userinfo.token.claim
d553aad5-948f-411a-94db-85bf6d5723b5	updatedAt	user.attribute
d553aad5-948f-411a-94db-85bf6d5723b5	true	id.token.claim
d553aad5-948f-411a-94db-85bf6d5723b5	true	access.token.claim
d553aad5-948f-411a-94db-85bf6d5723b5	updated_at	claim.name
d553aad5-948f-411a-94db-85bf6d5723b5	long	jsonType.label
dcc58e94-718a-404d-8b4e-877c99453229	true	userinfo.token.claim
dcc58e94-718a-404d-8b4e-877c99453229	gender	user.attribute
dcc58e94-718a-404d-8b4e-877c99453229	true	id.token.claim
dcc58e94-718a-404d-8b4e-877c99453229	true	access.token.claim
dcc58e94-718a-404d-8b4e-877c99453229	gender	claim.name
dcc58e94-718a-404d-8b4e-877c99453229	String	jsonType.label
e55e731e-73bf-47e0-a9f1-b2b9fb90a6c3	true	userinfo.token.claim
e55e731e-73bf-47e0-a9f1-b2b9fb90a6c3	website	user.attribute
e55e731e-73bf-47e0-a9f1-b2b9fb90a6c3	true	id.token.claim
e55e731e-73bf-47e0-a9f1-b2b9fb90a6c3	true	access.token.claim
e55e731e-73bf-47e0-a9f1-b2b9fb90a6c3	website	claim.name
e55e731e-73bf-47e0-a9f1-b2b9fb90a6c3	String	jsonType.label
e6c536b8-3b97-456a-9c50-b82f5afe5323	true	userinfo.token.claim
e6c536b8-3b97-456a-9c50-b82f5afe5323	zoneinfo	user.attribute
e6c536b8-3b97-456a-9c50-b82f5afe5323	true	id.token.claim
e6c536b8-3b97-456a-9c50-b82f5afe5323	true	access.token.claim
e6c536b8-3b97-456a-9c50-b82f5afe5323	zoneinfo	claim.name
e6c536b8-3b97-456a-9c50-b82f5afe5323	String	jsonType.label
e8cb2598-91db-492b-bd31-f7c4c6329990	true	userinfo.token.claim
e8cb2598-91db-492b-bd31-f7c4c6329990	picture	user.attribute
e8cb2598-91db-492b-bd31-f7c4c6329990	true	id.token.claim
e8cb2598-91db-492b-bd31-f7c4c6329990	true	access.token.claim
e8cb2598-91db-492b-bd31-f7c4c6329990	picture	claim.name
e8cb2598-91db-492b-bd31-f7c4c6329990	String	jsonType.label
ea6d27de-15fa-4e36-8ae5-46613af1060a	true	userinfo.token.claim
ea6d27de-15fa-4e36-8ae5-46613af1060a	profile	user.attribute
ea6d27de-15fa-4e36-8ae5-46613af1060a	true	id.token.claim
ea6d27de-15fa-4e36-8ae5-46613af1060a	true	access.token.claim
ea6d27de-15fa-4e36-8ae5-46613af1060a	profile	claim.name
ea6d27de-15fa-4e36-8ae5-46613af1060a	String	jsonType.label
417f6209-7801-4f48-9812-36a42f51fc6e	true	userinfo.token.claim
417f6209-7801-4f48-9812-36a42f51fc6e	email	user.attribute
417f6209-7801-4f48-9812-36a42f51fc6e	true	id.token.claim
417f6209-7801-4f48-9812-36a42f51fc6e	true	access.token.claim
417f6209-7801-4f48-9812-36a42f51fc6e	email	claim.name
417f6209-7801-4f48-9812-36a42f51fc6e	String	jsonType.label
ceac68b7-aff8-43b2-94dd-ffab71c679c3	true	userinfo.token.claim
ceac68b7-aff8-43b2-94dd-ffab71c679c3	emailVerified	user.attribute
ceac68b7-aff8-43b2-94dd-ffab71c679c3	true	id.token.claim
ceac68b7-aff8-43b2-94dd-ffab71c679c3	true	access.token.claim
ceac68b7-aff8-43b2-94dd-ffab71c679c3	email_verified	claim.name
ceac68b7-aff8-43b2-94dd-ffab71c679c3	boolean	jsonType.label
bd6df7d0-fa9f-4f99-b83c-42d819a6389e	formatted	user.attribute.formatted
bd6df7d0-fa9f-4f99-b83c-42d819a6389e	country	user.attribute.country
bd6df7d0-fa9f-4f99-b83c-42d819a6389e	postal_code	user.attribute.postal_code
bd6df7d0-fa9f-4f99-b83c-42d819a6389e	true	userinfo.token.claim
bd6df7d0-fa9f-4f99-b83c-42d819a6389e	street	user.attribute.street
bd6df7d0-fa9f-4f99-b83c-42d819a6389e	true	id.token.claim
bd6df7d0-fa9f-4f99-b83c-42d819a6389e	region	user.attribute.region
bd6df7d0-fa9f-4f99-b83c-42d819a6389e	true	access.token.claim
bd6df7d0-fa9f-4f99-b83c-42d819a6389e	locality	user.attribute.locality
7cb6ccd6-7ff1-4167-ab12-a501909a4016	true	userinfo.token.claim
7cb6ccd6-7ff1-4167-ab12-a501909a4016	phoneNumber	user.attribute
7cb6ccd6-7ff1-4167-ab12-a501909a4016	true	id.token.claim
7cb6ccd6-7ff1-4167-ab12-a501909a4016	true	access.token.claim
7cb6ccd6-7ff1-4167-ab12-a501909a4016	phone_number	claim.name
7cb6ccd6-7ff1-4167-ab12-a501909a4016	String	jsonType.label
e7b8c546-206a-4da7-9c17-ba6a7205a147	true	userinfo.token.claim
e7b8c546-206a-4da7-9c17-ba6a7205a147	phoneNumberVerified	user.attribute
e7b8c546-206a-4da7-9c17-ba6a7205a147	true	id.token.claim
e7b8c546-206a-4da7-9c17-ba6a7205a147	true	access.token.claim
e7b8c546-206a-4da7-9c17-ba6a7205a147	phone_number_verified	claim.name
e7b8c546-206a-4da7-9c17-ba6a7205a147	boolean	jsonType.label
865c7b50-65ea-4893-b9e1-f671e65cb2b7	true	multivalued
865c7b50-65ea-4893-b9e1-f671e65cb2b7	foo	user.attribute
865c7b50-65ea-4893-b9e1-f671e65cb2b7	true	access.token.claim
865c7b50-65ea-4893-b9e1-f671e65cb2b7	resource_access.${client_id}.roles	claim.name
865c7b50-65ea-4893-b9e1-f671e65cb2b7	String	jsonType.label
c9e21d2a-16b1-42d4-aa0c-70ae00b12fe9	true	multivalued
c9e21d2a-16b1-42d4-aa0c-70ae00b12fe9	foo	user.attribute
c9e21d2a-16b1-42d4-aa0c-70ae00b12fe9	true	access.token.claim
c9e21d2a-16b1-42d4-aa0c-70ae00b12fe9	realm_access.roles	claim.name
c9e21d2a-16b1-42d4-aa0c-70ae00b12fe9	String	jsonType.label
a436ebb4-881d-42d7-b25f-4633ae95a077	true	userinfo.token.claim
a436ebb4-881d-42d7-b25f-4633ae95a077	username	user.attribute
a436ebb4-881d-42d7-b25f-4633ae95a077	true	id.token.claim
a436ebb4-881d-42d7-b25f-4633ae95a077	true	access.token.claim
a436ebb4-881d-42d7-b25f-4633ae95a077	upn	claim.name
a436ebb4-881d-42d7-b25f-4633ae95a077	String	jsonType.label
c44773b1-544e-484d-8a92-c67c5ae5075a	true	multivalued
c44773b1-544e-484d-8a92-c67c5ae5075a	foo	user.attribute
c44773b1-544e-484d-8a92-c67c5ae5075a	true	id.token.claim
c44773b1-544e-484d-8a92-c67c5ae5075a	true	access.token.claim
c44773b1-544e-484d-8a92-c67c5ae5075a	groups	claim.name
c44773b1-544e-484d-8a92-c67c5ae5075a	String	jsonType.label
fb1c336a-fa6e-4a0f-8282-93a04f935eae	true	id.token.claim
fb1c336a-fa6e-4a0f-8282-93a04f935eae	true	access.token.claim
674defc1-0edb-4032-a43d-cd23ca0887f7	false	single
674defc1-0edb-4032-a43d-cd23ca0887f7	Basic	attribute.nameformat
674defc1-0edb-4032-a43d-cd23ca0887f7	Role	attribute.name
14b391e7-eea0-472e-90f8-159837391210	true	userinfo.token.claim
14b391e7-eea0-472e-90f8-159837391210	picture	user.attribute
14b391e7-eea0-472e-90f8-159837391210	true	id.token.claim
14b391e7-eea0-472e-90f8-159837391210	true	access.token.claim
14b391e7-eea0-472e-90f8-159837391210	picture	claim.name
14b391e7-eea0-472e-90f8-159837391210	String	jsonType.label
176b7ca2-a3a5-444c-ba35-13a5ad8b46bc	true	userinfo.token.claim
176b7ca2-a3a5-444c-ba35-13a5ad8b46bc	gender	user.attribute
176b7ca2-a3a5-444c-ba35-13a5ad8b46bc	true	id.token.claim
176b7ca2-a3a5-444c-ba35-13a5ad8b46bc	true	access.token.claim
176b7ca2-a3a5-444c-ba35-13a5ad8b46bc	gender	claim.name
176b7ca2-a3a5-444c-ba35-13a5ad8b46bc	String	jsonType.label
44a79078-8c7d-495a-98f6-4d921bf95c4d	true	userinfo.token.claim
44a79078-8c7d-495a-98f6-4d921bf95c4d	nickname	user.attribute
44a79078-8c7d-495a-98f6-4d921bf95c4d	true	id.token.claim
44a79078-8c7d-495a-98f6-4d921bf95c4d	true	access.token.claim
44a79078-8c7d-495a-98f6-4d921bf95c4d	nickname	claim.name
44a79078-8c7d-495a-98f6-4d921bf95c4d	String	jsonType.label
5ad6fcec-453c-44f1-81e0-a19ac713c36f	true	userinfo.token.claim
5ad6fcec-453c-44f1-81e0-a19ac713c36f	locale	user.attribute
5ad6fcec-453c-44f1-81e0-a19ac713c36f	true	id.token.claim
5ad6fcec-453c-44f1-81e0-a19ac713c36f	true	access.token.claim
5ad6fcec-453c-44f1-81e0-a19ac713c36f	locale	claim.name
5ad6fcec-453c-44f1-81e0-a19ac713c36f	String	jsonType.label
5fdeb90e-86fe-4a41-bcea-63b3b0e22daa	true	userinfo.token.claim
5fdeb90e-86fe-4a41-bcea-63b3b0e22daa	lastName	user.attribute
5fdeb90e-86fe-4a41-bcea-63b3b0e22daa	true	id.token.claim
5fdeb90e-86fe-4a41-bcea-63b3b0e22daa	true	access.token.claim
5fdeb90e-86fe-4a41-bcea-63b3b0e22daa	family_name	claim.name
5fdeb90e-86fe-4a41-bcea-63b3b0e22daa	String	jsonType.label
7251013a-d2d5-49ac-b0ec-2443c7e3a9ea	true	userinfo.token.claim
7251013a-d2d5-49ac-b0ec-2443c7e3a9ea	firstName	user.attribute
7251013a-d2d5-49ac-b0ec-2443c7e3a9ea	true	id.token.claim
7251013a-d2d5-49ac-b0ec-2443c7e3a9ea	true	access.token.claim
7251013a-d2d5-49ac-b0ec-2443c7e3a9ea	given_name	claim.name
7251013a-d2d5-49ac-b0ec-2443c7e3a9ea	String	jsonType.label
7962823f-7d59-4444-b36a-194a5f1f5ae5	true	userinfo.token.claim
7962823f-7d59-4444-b36a-194a5f1f5ae5	true	id.token.claim
7962823f-7d59-4444-b36a-194a5f1f5ae5	true	access.token.claim
7ce9f967-0d89-4b91-ba66-9d309de1af0e	true	userinfo.token.claim
7ce9f967-0d89-4b91-ba66-9d309de1af0e	username	user.attribute
7ce9f967-0d89-4b91-ba66-9d309de1af0e	true	id.token.claim
7ce9f967-0d89-4b91-ba66-9d309de1af0e	true	access.token.claim
7ce9f967-0d89-4b91-ba66-9d309de1af0e	preferred_username	claim.name
7ce9f967-0d89-4b91-ba66-9d309de1af0e	String	jsonType.label
9a9138f5-d5c1-4984-9de4-6bea568ccf8c	true	userinfo.token.claim
9a9138f5-d5c1-4984-9de4-6bea568ccf8c	birthdate	user.attribute
9a9138f5-d5c1-4984-9de4-6bea568ccf8c	true	id.token.claim
9a9138f5-d5c1-4984-9de4-6bea568ccf8c	true	access.token.claim
9a9138f5-d5c1-4984-9de4-6bea568ccf8c	birthdate	claim.name
9a9138f5-d5c1-4984-9de4-6bea568ccf8c	String	jsonType.label
b48883d1-365b-4635-bae3-7dcacb2aac93	true	userinfo.token.claim
b48883d1-365b-4635-bae3-7dcacb2aac93	middleName	user.attribute
b48883d1-365b-4635-bae3-7dcacb2aac93	true	id.token.claim
b48883d1-365b-4635-bae3-7dcacb2aac93	true	access.token.claim
b48883d1-365b-4635-bae3-7dcacb2aac93	middle_name	claim.name
b48883d1-365b-4635-bae3-7dcacb2aac93	String	jsonType.label
b9ec9298-c39b-4642-9e19-5bc16643db9a	true	userinfo.token.claim
b9ec9298-c39b-4642-9e19-5bc16643db9a	profile	user.attribute
b9ec9298-c39b-4642-9e19-5bc16643db9a	true	id.token.claim
b9ec9298-c39b-4642-9e19-5bc16643db9a	true	access.token.claim
b9ec9298-c39b-4642-9e19-5bc16643db9a	profile	claim.name
b9ec9298-c39b-4642-9e19-5bc16643db9a	String	jsonType.label
c9956d3a-5120-4927-9b3c-d26d85cab945	true	userinfo.token.claim
c9956d3a-5120-4927-9b3c-d26d85cab945	zoneinfo	user.attribute
c9956d3a-5120-4927-9b3c-d26d85cab945	true	id.token.claim
c9956d3a-5120-4927-9b3c-d26d85cab945	true	access.token.claim
c9956d3a-5120-4927-9b3c-d26d85cab945	zoneinfo	claim.name
c9956d3a-5120-4927-9b3c-d26d85cab945	String	jsonType.label
e9ea1e2e-9969-45ff-b5e7-216333c885ba	true	userinfo.token.claim
e9ea1e2e-9969-45ff-b5e7-216333c885ba	updatedAt	user.attribute
e9ea1e2e-9969-45ff-b5e7-216333c885ba	true	id.token.claim
e9ea1e2e-9969-45ff-b5e7-216333c885ba	true	access.token.claim
e9ea1e2e-9969-45ff-b5e7-216333c885ba	updated_at	claim.name
e9ea1e2e-9969-45ff-b5e7-216333c885ba	long	jsonType.label
f53d81e6-29de-4281-bde9-5fa1528bbce7	true	userinfo.token.claim
f53d81e6-29de-4281-bde9-5fa1528bbce7	website	user.attribute
f53d81e6-29de-4281-bde9-5fa1528bbce7	true	id.token.claim
f53d81e6-29de-4281-bde9-5fa1528bbce7	true	access.token.claim
f53d81e6-29de-4281-bde9-5fa1528bbce7	website	claim.name
f53d81e6-29de-4281-bde9-5fa1528bbce7	String	jsonType.label
c9af2c92-a373-4897-9ba0-fa04623aa6af	true	userinfo.token.claim
c9af2c92-a373-4897-9ba0-fa04623aa6af	emailVerified	user.attribute
c9af2c92-a373-4897-9ba0-fa04623aa6af	true	id.token.claim
c9af2c92-a373-4897-9ba0-fa04623aa6af	true	access.token.claim
c9af2c92-a373-4897-9ba0-fa04623aa6af	email_verified	claim.name
c9af2c92-a373-4897-9ba0-fa04623aa6af	boolean	jsonType.label
e23457c8-c594-42e9-9ddd-c11f1144a530	true	userinfo.token.claim
e23457c8-c594-42e9-9ddd-c11f1144a530	email	user.attribute
e23457c8-c594-42e9-9ddd-c11f1144a530	true	id.token.claim
e23457c8-c594-42e9-9ddd-c11f1144a530	true	access.token.claim
e23457c8-c594-42e9-9ddd-c11f1144a530	email	claim.name
e23457c8-c594-42e9-9ddd-c11f1144a530	String	jsonType.label
ad734b9a-d5d9-4c2e-bee2-9fb21756781b	formatted	user.attribute.formatted
ad734b9a-d5d9-4c2e-bee2-9fb21756781b	country	user.attribute.country
ad734b9a-d5d9-4c2e-bee2-9fb21756781b	postal_code	user.attribute.postal_code
ad734b9a-d5d9-4c2e-bee2-9fb21756781b	true	userinfo.token.claim
ad734b9a-d5d9-4c2e-bee2-9fb21756781b	street	user.attribute.street
ad734b9a-d5d9-4c2e-bee2-9fb21756781b	true	id.token.claim
ad734b9a-d5d9-4c2e-bee2-9fb21756781b	region	user.attribute.region
ad734b9a-d5d9-4c2e-bee2-9fb21756781b	true	access.token.claim
ad734b9a-d5d9-4c2e-bee2-9fb21756781b	locality	user.attribute.locality
68b9276a-72a0-4cfd-8956-7361c6a81101	true	userinfo.token.claim
68b9276a-72a0-4cfd-8956-7361c6a81101	phoneNumberVerified	user.attribute
68b9276a-72a0-4cfd-8956-7361c6a81101	true	id.token.claim
68b9276a-72a0-4cfd-8956-7361c6a81101	true	access.token.claim
68b9276a-72a0-4cfd-8956-7361c6a81101	phone_number_verified	claim.name
68b9276a-72a0-4cfd-8956-7361c6a81101	boolean	jsonType.label
d2015d21-6e32-4f54-a9b3-2c819fcdf1a1	true	userinfo.token.claim
d2015d21-6e32-4f54-a9b3-2c819fcdf1a1	phoneNumber	user.attribute
d2015d21-6e32-4f54-a9b3-2c819fcdf1a1	true	id.token.claim
d2015d21-6e32-4f54-a9b3-2c819fcdf1a1	true	access.token.claim
d2015d21-6e32-4f54-a9b3-2c819fcdf1a1	phone_number	claim.name
d2015d21-6e32-4f54-a9b3-2c819fcdf1a1	String	jsonType.label
0ec95d77-f2b1-47df-b7fe-0ae963e5c805	true	multivalued
0ec95d77-f2b1-47df-b7fe-0ae963e5c805	foo	user.attribute
0ec95d77-f2b1-47df-b7fe-0ae963e5c805	true	access.token.claim
0ec95d77-f2b1-47df-b7fe-0ae963e5c805	resource_access.${client_id}.roles	claim.name
0ec95d77-f2b1-47df-b7fe-0ae963e5c805	String	jsonType.label
ac48d9a2-98b9-4d48-a6c1-85480ae8b04b	true	multivalued
ac48d9a2-98b9-4d48-a6c1-85480ae8b04b	foo	user.attribute
ac48d9a2-98b9-4d48-a6c1-85480ae8b04b	true	access.token.claim
ac48d9a2-98b9-4d48-a6c1-85480ae8b04b	realm_access.roles	claim.name
ac48d9a2-98b9-4d48-a6c1-85480ae8b04b	String	jsonType.label
71da6765-7c94-4705-818f-a12481ac04b1	true	userinfo.token.claim
71da6765-7c94-4705-818f-a12481ac04b1	username	user.attribute
71da6765-7c94-4705-818f-a12481ac04b1	true	id.token.claim
71da6765-7c94-4705-818f-a12481ac04b1	true	access.token.claim
71da6765-7c94-4705-818f-a12481ac04b1	upn	claim.name
71da6765-7c94-4705-818f-a12481ac04b1	String	jsonType.label
95cb6039-db28-4013-b8a5-dd56daada82f	true	multivalued
95cb6039-db28-4013-b8a5-dd56daada82f	foo	user.attribute
95cb6039-db28-4013-b8a5-dd56daada82f	true	id.token.claim
95cb6039-db28-4013-b8a5-dd56daada82f	true	access.token.claim
95cb6039-db28-4013-b8a5-dd56daada82f	groups	claim.name
95cb6039-db28-4013-b8a5-dd56daada82f	String	jsonType.label
cb49f80f-43f3-4b6c-af36-571233dd6846	true	id.token.claim
cb49f80f-43f3-4b6c-af36-571233dd6846	true	access.token.claim
cbdf190f-2b39-44d6-8465-ad30f0ab8ebe	true	userinfo.token.claim
cbdf190f-2b39-44d6-8465-ad30f0ab8ebe	locale	user.attribute
cbdf190f-2b39-44d6-8465-ad30f0ab8ebe	true	id.token.claim
cbdf190f-2b39-44d6-8465-ad30f0ab8ebe	true	access.token.claim
cbdf190f-2b39-44d6-8465-ad30f0ab8ebe	locale	claim.name
cbdf190f-2b39-44d6-8465-ad30f0ab8ebe	String	jsonType.label
b1fe4871-aad5-4b87-885e-2f4c413cb16e	true	multivalued
b1fe4871-aad5-4b87-885e-2f4c413cb16e	true	userinfo.token.claim
b1fe4871-aad5-4b87-885e-2f4c413cb16e	true	id.token.claim
b1fe4871-aad5-4b87-885e-2f4c413cb16e	true	access.token.claim
b1fe4871-aad5-4b87-885e-2f4c413cb16e	roles	claim.name
b1fe4871-aad5-4b87-885e-2f4c413cb16e	MainClient	usermodel.clientRoleMapping.clientId
30db5973-0712-4feb-a579-bd4aa3a596bf	MainClient	included.client.audience
30db5973-0712-4feb-a579-bd4aa3a596bf	false	id.token.claim
30db5973-0712-4feb-a579-bd4aa3a596bf	true	access.token.claim
5d22de32-3bb8-480d-bba9-94ab246c4637	false	aggregate.attrs
5d22de32-3bb8-480d-bba9-94ab246c4637	true	userinfo.token.claim
5d22de32-3bb8-480d-bba9-94ab246c4637	false	multivalued
5d22de32-3bb8-480d-bba9-94ab246c4637	INN	user.attribute
5d22de32-3bb8-480d-bba9-94ab246c4637	true	id.token.claim
5d22de32-3bb8-480d-bba9-94ab246c4637	true	access.token.claim
5d22de32-3bb8-480d-bba9-94ab246c4637	inn	claim.name
b1305659-e3e2-4e34-99b6-92ae64bcba4c	true	multivalued
b1305659-e3e2-4e34-99b6-92ae64bcba4c	true	userinfo.token.claim
b1305659-e3e2-4e34-99b6-92ae64bcba4c	true	id.token.claim
b1305659-e3e2-4e34-99b6-92ae64bcba4c	true	access.token.claim
b1305659-e3e2-4e34-99b6-92ae64bcba4c	roles	claim.name
\.


--
-- TOC entry 4168 (class 0 OID 16471)
-- Dependencies: 224
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
d4586994-289c-4313-8f41-4aa5d69533be	60	300	300	\N	\N	\N	t	f	0	\N	CarService	0	\N	t	t	f	f	EXTERNAL	1800	36000	f	f	80e39e74-1dfd-4876-b008-9ddb11aaa585	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	3911a3e4-12fc-49cd-9688-d5f36f590de2	d9b232d5-ca60-4e5c-8591-d603936ca8c2	3ad587d2-78d8-440a-9082-61fba32fbb04	57f8c2b6-ce0f-41a3-ad70-3bf1f13fcb85	35b4aa9a-690d-4f26-914a-4135c66214b4	2592000	f	900	t	f	e651cfca-8901-40fc-88c3-d69af49c53e7	0	f	0	0	6dbac6ce-a160-4e17-bdb7-1bf8673fe00e
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	1f1f2692-dc36-47eb-af4c-eb50d1f98572	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	5973d417-62ca-4183-b800-a2b1963ab903	65315acc-ca8d-4924-b4ca-652a4ca31b8e	eefe599b-73a7-41e9-9958-d525cd636eb8	02b0ca33-c680-443e-afd2-fb8af5f66144	4bda9bab-b271-406e-9830-954114e9e52c	2592000	f	900	f	f	316291ef-36fb-4d92-a675-fc834014f520	0	f	0	0	dea08c49-9aca-4b31-9f11-f16052e6b683
\.


--
-- TOC entry 4169 (class 0 OID 16488)
-- Dependencies: 225
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
oauth2DeviceCodeLifespan	d4586994-289c-4313-8f41-4aa5d69533be	600
oauth2DevicePollingInterval	d4586994-289c-4313-8f41-4aa5d69533be	5
cibaBackchannelTokenDeliveryMode	d4586994-289c-4313-8f41-4aa5d69533be	poll
cibaExpiresIn	d4586994-289c-4313-8f41-4aa5d69533be	120
cibaInterval	d4586994-289c-4313-8f41-4aa5d69533be	5
cibaAuthRequestedUserHint	d4586994-289c-4313-8f41-4aa5d69533be	login_hint
parRequestUriLifespan	d4586994-289c-4313-8f41-4aa5d69533be	60
cibaBackchannelTokenDeliveryMode	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	poll
cibaExpiresIn	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	120
cibaAuthRequestedUserHint	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	login_hint
parRequestUriLifespan	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	60
cibaInterval	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	5
frontendUrl	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	
userProfileEnabled	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	false
webAuthnPolicyCreateTimeout	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	0
webAuthnPolicyAvoidSameAuthenticatorRegister	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	false
webAuthnPolicyRpEntityNamePasswordless	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	ES256
webAuthnPolicyRpIdPasswordless	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	
webAuthnPolicyAttestationConveyancePreferencePasswordless	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	not specified
webAuthnPolicyRequireResidentKeyPasswordless	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	not specified
webAuthnPolicyCreateTimeoutPasswordless	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	false
client-policies.profiles	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	{"profiles":[]}
client-policies.policies	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	
_browser_header.xContentTypeOptions	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	nosniff
_browser_header.xRobotsTag	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	none
_browser_header.xFrameOptions	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	SAMEORIGIN
displayName	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	Keycloak
displayNameHtml	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	<div class="kc-logo-text"><span>Keycloak</span></div>
bruteForceProtected	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	false
permanentLockout	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	false
maxFailureWaitSeconds	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	900
minimumQuickLoginWaitSeconds	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	60
waitIncrementSeconds	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	60
quickLoginCheckMilliSeconds	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1000
maxDeltaTimeSeconds	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	43200
failureFactor	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	30
actionTokenGeneratedByAdminLifespan	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	43200
actionTokenGeneratedByUserLifespan	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	300
oauth2DeviceCodeLifespan	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	600
defaultSignatureAlgorithm	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	RS256
offlineSessionMaxLifespanEnabled	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	false
offlineSessionMaxLifespan	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	5184000
clientSessionIdleTimeout	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	0
clientSessionMaxLifespan	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	0
clientOfflineSessionIdleTimeout	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	0
clientOfflineSessionMaxLifespan	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	0
webAuthnPolicyRpEntityName	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	keycloak
webAuthnPolicySignatureAlgorithms	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	ES256
webAuthnPolicyRpId	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	
webAuthnPolicyAttestationConveyancePreference	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	not specified
webAuthnPolicyAuthenticatorAttachment	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	not specified
webAuthnPolicyRequireResidentKey	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	not specified
webAuthnPolicyUserVerificationRequirement	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	not specified
oauth2DevicePollingInterval	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	5
_browser_header.xXSSProtection	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	1; mode=block
_browser_header.contentSecurityPolicy	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.strictTransportSecurity	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	max-age=31536000; includeSubDomains
frontendUrl	d4586994-289c-4313-8f41-4aa5d69533be	
userProfileEnabled	d4586994-289c-4313-8f41-4aa5d69533be	true
displayName	d4586994-289c-4313-8f41-4aa5d69533be	
displayNameHtml	d4586994-289c-4313-8f41-4aa5d69533be	
bruteForceProtected	d4586994-289c-4313-8f41-4aa5d69533be	false
permanentLockout	d4586994-289c-4313-8f41-4aa5d69533be	false
maxFailureWaitSeconds	d4586994-289c-4313-8f41-4aa5d69533be	900
minimumQuickLoginWaitSeconds	d4586994-289c-4313-8f41-4aa5d69533be	60
waitIncrementSeconds	d4586994-289c-4313-8f41-4aa5d69533be	60
quickLoginCheckMilliSeconds	d4586994-289c-4313-8f41-4aa5d69533be	1000
maxDeltaTimeSeconds	d4586994-289c-4313-8f41-4aa5d69533be	43200
failureFactor	d4586994-289c-4313-8f41-4aa5d69533be	30
actionTokenGeneratedByAdminLifespan	d4586994-289c-4313-8f41-4aa5d69533be	43200
actionTokenGeneratedByUserLifespan	d4586994-289c-4313-8f41-4aa5d69533be	300
defaultSignatureAlgorithm	d4586994-289c-4313-8f41-4aa5d69533be	RS256
offlineSessionMaxLifespanEnabled	d4586994-289c-4313-8f41-4aa5d69533be	false
offlineSessionMaxLifespan	d4586994-289c-4313-8f41-4aa5d69533be	5184000
clientSessionIdleTimeout	d4586994-289c-4313-8f41-4aa5d69533be	0
clientSessionMaxLifespan	d4586994-289c-4313-8f41-4aa5d69533be	0
clientOfflineSessionIdleTimeout	d4586994-289c-4313-8f41-4aa5d69533be	0
clientOfflineSessionMaxLifespan	d4586994-289c-4313-8f41-4aa5d69533be	0
webAuthnPolicyRpEntityName	d4586994-289c-4313-8f41-4aa5d69533be	keycloak
webAuthnPolicySignatureAlgorithms	d4586994-289c-4313-8f41-4aa5d69533be	ES256
webAuthnPolicyRpId	d4586994-289c-4313-8f41-4aa5d69533be	
webAuthnPolicyAttestationConveyancePreference	d4586994-289c-4313-8f41-4aa5d69533be	not specified
webAuthnPolicyAuthenticatorAttachment	d4586994-289c-4313-8f41-4aa5d69533be	not specified
webAuthnPolicyRequireResidentKey	d4586994-289c-4313-8f41-4aa5d69533be	not specified
webAuthnPolicyUserVerificationRequirement	d4586994-289c-4313-8f41-4aa5d69533be	not specified
webAuthnPolicyCreateTimeout	d4586994-289c-4313-8f41-4aa5d69533be	0
webAuthnPolicyAvoidSameAuthenticatorRegister	d4586994-289c-4313-8f41-4aa5d69533be	false
webAuthnPolicyRpEntityNamePasswordless	d4586994-289c-4313-8f41-4aa5d69533be	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	d4586994-289c-4313-8f41-4aa5d69533be	ES256
webAuthnPolicyRpIdPasswordless	d4586994-289c-4313-8f41-4aa5d69533be	
webAuthnPolicyAttestationConveyancePreferencePasswordless	d4586994-289c-4313-8f41-4aa5d69533be	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	d4586994-289c-4313-8f41-4aa5d69533be	not specified
webAuthnPolicyRequireResidentKeyPasswordless	d4586994-289c-4313-8f41-4aa5d69533be	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	d4586994-289c-4313-8f41-4aa5d69533be	not specified
webAuthnPolicyCreateTimeoutPasswordless	d4586994-289c-4313-8f41-4aa5d69533be	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	d4586994-289c-4313-8f41-4aa5d69533be	false
client-policies.profiles	d4586994-289c-4313-8f41-4aa5d69533be	{"profiles":[]}
client-policies.policies	d4586994-289c-4313-8f41-4aa5d69533be	{"policies":[]}
_browser_header.contentSecurityPolicyReportOnly	d4586994-289c-4313-8f41-4aa5d69533be	
_browser_header.xContentTypeOptions	d4586994-289c-4313-8f41-4aa5d69533be	nosniff
_browser_header.xRobotsTag	d4586994-289c-4313-8f41-4aa5d69533be	none
_browser_header.xFrameOptions	d4586994-289c-4313-8f41-4aa5d69533be	SAMEORIGIN
_browser_header.contentSecurityPolicy	d4586994-289c-4313-8f41-4aa5d69533be	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	d4586994-289c-4313-8f41-4aa5d69533be	1; mode=block
_browser_header.strictTransportSecurity	d4586994-289c-4313-8f41-4aa5d69533be	max-age=31536000; includeSubDomains
\.


--
-- TOC entry 4217 (class 0 OID 17245)
-- Dependencies: 273
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- TOC entry 4194 (class 0 OID 16941)
-- Dependencies: 250
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- TOC entry 4170 (class 0 OID 16496)
-- Dependencies: 226
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	jboss-logging
d4586994-289c-4313-8f41-4aa5d69533be	jboss-logging
\.


--
-- TOC entry 4250 (class 0 OID 17947)
-- Dependencies: 306
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- TOC entry 4171 (class 0 OID 16499)
-- Dependencies: 227
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	04ff9ad3-2ef2-41cb-be23-7572497fc0d7
password	password	t	t	d4586994-289c-4313-8f41-4aa5d69533be
\.


--
-- TOC entry 4172 (class 0 OID 16506)
-- Dependencies: 228
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- TOC entry 4192 (class 0 OID 16857)
-- Dependencies: 248
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
04ff9ad3-2ef2-41cb-be23-7572497fc0d7	en
d4586994-289c-4313-8f41-4aa5d69533be	en
\.


--
-- TOC entry 4173 (class 0 OID 16516)
-- Dependencies: 229
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.redirect_uris (client_id, value) FROM stdin;
c75332da-5ed1-435c-b1d3-7581f2ea7db3	/realms/master/account/*
7af5eb91-e11b-417c-bfb9-92f00598c4e1	/realms/master/account/*
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	/admin/master/console/*
d2fa367e-e155-41d8-8392-c6b18eab5c67	/realms/CarService/account/*
15bff922-9d6c-425a-b6e5-a0b17d0e8886	/admin/CarService/console/*
04266c67-e910-4d4c-b09e-fcc5f63cf3e2	/realms/CarService/account/*
fc797aba-a792-4450-9575-d92c74afb436	*
\.


--
-- TOC entry 4210 (class 0 OID 17180)
-- Dependencies: 266
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- TOC entry 4209 (class 0 OID 17173)
-- Dependencies: 265
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
b6ae7c89-05af-4338-afe6-e314776e6a81	VERIFY_EMAIL	Verify Email	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	t	f	VERIFY_EMAIL	50
4d801675-7dc1-415e-8614-d271fee7e8e9	UPDATE_PROFILE	Update Profile	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	t	f	UPDATE_PROFILE	40
253e05cf-f965-46bc-a6e4-5af1586803e4	CONFIGURE_TOTP	Configure OTP	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	t	f	CONFIGURE_TOTP	10
2b664745-7abf-4bdb-8159-949d1b4ea495	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	70
bef6d7a4-2046-4374-8d85-9fcacecd7274	UPDATE_PASSWORD	Update Password	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	t	f	UPDATE_PASSWORD	30
42273f62-f07b-4a8d-b4d6-ba86f0203fe5	terms_and_conditions	Terms and Conditions	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	f	f	terms_and_conditions	20
e9407e4f-b386-4d68-8904-a9c5703cbb9c	update_user_locale	Update User Locale	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	t	f	update_user_locale	1000
6836c0e0-2fd6-4d59-ba54-5201d4873f29	delete_account	Delete Account	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	f	f	delete_account	60
ea961b6b-3c66-4007-91d7-bf63ccbfe659	VERIFY_EMAIL	Verify Email	d4586994-289c-4313-8f41-4aa5d69533be	t	f	VERIFY_EMAIL	50
d1fe2376-f7f6-4b32-8fa9-fb8f1a2f2c9c	UPDATE_PROFILE	Update Profile	d4586994-289c-4313-8f41-4aa5d69533be	t	f	UPDATE_PROFILE	40
ae793b08-4533-4417-ab29-85aba1fdb770	CONFIGURE_TOTP	Configure OTP	d4586994-289c-4313-8f41-4aa5d69533be	t	f	CONFIGURE_TOTP	10
9e1fff83-94a3-4912-9916-c8c4b87eface	CONFIGURE_RECOVERY_AUTHN_CODES	Recovery Authentication Codes	d4586994-289c-4313-8f41-4aa5d69533be	t	f	CONFIGURE_RECOVERY_AUTHN_CODES	70
a6ae7eee-44be-4ddd-be0a-0dfc42136bdc	UPDATE_PASSWORD	Update Password	d4586994-289c-4313-8f41-4aa5d69533be	t	f	UPDATE_PASSWORD	30
d65c3c0f-bf30-4a4e-8972-557b4bf987f4	terms_and_conditions	Terms and Conditions	d4586994-289c-4313-8f41-4aa5d69533be	f	f	terms_and_conditions	20
24840295-c3fb-420e-8d06-d4fe2a2592ad	update_user_locale	Update User Locale	d4586994-289c-4313-8f41-4aa5d69533be	t	f	update_user_locale	1000
c0b12b41-349a-46d4-92e2-d5dba991618e	delete_account	Delete Account	d4586994-289c-4313-8f41-4aa5d69533be	f	f	delete_account	60
\.


--
-- TOC entry 4247 (class 0 OID 17878)
-- Dependencies: 303
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- TOC entry 4227 (class 0 OID 17462)
-- Dependencies: 283
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4226 (class 0 OID 17447)
-- Dependencies: 282
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4221 (class 0 OID 17385)
-- Dependencies: 277
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
\.


--
-- TOC entry 4246 (class 0 OID 17854)
-- Dependencies: 302
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4224 (class 0 OID 17421)
-- Dependencies: 280
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
\.


--
-- TOC entry 4222 (class 0 OID 17393)
-- Dependencies: 278
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
\.


--
-- TOC entry 4223 (class 0 OID 17407)
-- Dependencies: 279
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- TOC entry 4248 (class 0 OID 17896)
-- Dependencies: 304
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.resource_uris (resource_id, value) FROM stdin;
\.


--
-- TOC entry 4249 (class 0 OID 17906)
-- Dependencies: 305
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- TOC entry 4174 (class 0 OID 16519)
-- Dependencies: 230
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
7af5eb91-e11b-417c-bfb9-92f00598c4e1	51112b22-585e-469c-b65e-f0512b16ed3e
\.


--
-- TOC entry 4228 (class 0 OID 17477)
-- Dependencies: 284
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- TOC entry 4156 (class 0 OID 16394)
-- Dependencies: 212
-- Data for Name: transports; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transports (id, number, model, owner_id) FROM stdin;
4	А738ВВ54	BMW	43416877-cb87-43ae-8ec8-7cc5c2be949d
5	С788СС72	Lada	6b82d6df-1171-4e29-9fce-c59f5c7e26e2
6	О111РС78	Nissan	de1ce17c-8db0-4795-9c38-e00352ff9a76
7	О999АО56	Toyota	6b82d6df-1171-4e29-9fce-c59f5c7e26e2
\.


--
-- TOC entry 4176 (class 0 OID 16525)
-- Dependencies: 232
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
INN	1234567890	de1ce17c-8db0-4795-9c38-e00352ff9a76	95f4c4e3-8555-48d5-ac6e-14d6abe353a9
INN	3216540987	43416877-cb87-43ae-8ec8-7cc5c2be949d	e0600c13-9c43-494f-b5ed-978f2983edef
INN	5492348954	6b82d6df-1171-4e29-9fce-c59f5c7e26e2	613c9f44-5d31-4dc3-8ee4-08afe9e22c01
INN	0980980981	6f599df7-ef8f-4b77-9cb9-eff7a38594df	f64eb7e5-5258-48a0-9c9c-c0aeab4bdada
INN	032093094783	2457a46a-df3a-41db-aa7a-35cce6b6e246	6e635d68-a835-44ff-984c-01a38f8a67dc
INN	8778877887	c63afc70-54d5-4755-9570-62713302162d	c05eaa22-f08e-4b7b-80c0-886e79c24e6b
INN	123123123123	8fb67229-c0dd-411e-8c61-40c9972b2d9c	43ed6809-a4ce-4f03-979a-011479c88770
INN	123123123123	65d91c84-f89d-4ca3-bebe-1f1f3df25c06	2a54bdb4-bbc7-41ff-94c8-05f440ad2125
\.


--
-- TOC entry 4198 (class 0 OID 16962)
-- Dependencies: 254
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- TOC entry 4244 (class 0 OID 17829)
-- Dependencies: 300
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- TOC entry 4177 (class 0 OID 16530)
-- Dependencies: 233
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
9c9ca5de-c0e8-486f-8149-af5111b1d844	\N	69908b20-9070-4699-9f29-c9117a3a80d1	f	t	\N	1	1	04ff9ad3-2ef2-41cb-be23-7572497fc0d7	admin	1657888960614	\N	0
de1ce17c-8db0-4795-9c38-e00352ff9a76	customer1@mail.ru	customer1@mail.ru	f	t	\N	Иван	Иванов	d4586994-289c-4313-8f41-4aa5d69533be	customer1	1658173682969	\N	0
43416877-cb87-43ae-8ec8-7cc5c2be949d	customer2@mail.ru	customer2@mail.ru	f	t	\N	Артем	Артемов	d4586994-289c-4313-8f41-4aa5d69533be	customer2	1658173721045	\N	0
6b82d6df-1171-4e29-9fce-c59f5c7e26e2	customer3@mail.ru	customer3@mail.ru	f	t	\N	Павел	Павлов	d4586994-289c-4313-8f41-4aa5d69533be	customer3	1658173775590	\N	0
6f599df7-ef8f-4b77-9cb9-eff7a38594df	executor1@mail.ru	executor1@mail.ru	f	t	\N	Александр	Павлов	d4586994-289c-4313-8f41-4aa5d69533be	executor1	1658173821708	\N	0
2457a46a-df3a-41db-aa7a-35cce6b6e246	executor2@mail.ru	executor2@mail.ru	f	t	\N	Николай	Артемов	d4586994-289c-4313-8f41-4aa5d69533be	executor2	1658173864135	\N	0
c63afc70-54d5-4755-9570-62713302162d	executor3@mail.ru	executor3@mail.ru	f	t	\N	Федор	Иванов	d4586994-289c-4313-8f41-4aa5d69533be	executor3	1658173910255	\N	0
8fb67229-c0dd-411e-8c61-40c9972b2d9c	admin@mail.ru	admin@mail.ru	f	t	\N	Админ	Админов	d4586994-289c-4313-8f41-4aa5d69533be	admin	1658173946208	\N	0
65d91c84-f89d-4ca3-bebe-1f1f3df25c06	123123asd@mail.ru	123123asd@mail.ru	f	t	\N	123123	123123	d4586994-289c-4313-8f41-4aa5d69533be	123123	1658175445860	\N	0
\.


--
-- TOC entry 4178 (class 0 OID 16538)
-- Dependencies: 234
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- TOC entry 4205 (class 0 OID 17074)
-- Dependencies: 261
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- TOC entry 4206 (class 0 OID 17079)
-- Dependencies: 262
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- TOC entry 4179 (class 0 OID 16543)
-- Dependencies: 235
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- TOC entry 4216 (class 0 OID 17242)
-- Dependencies: 272
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- TOC entry 4180 (class 0 OID 16548)
-- Dependencies: 236
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- TOC entry 4181 (class 0 OID 16551)
-- Dependencies: 237
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
dea08c49-9aca-4b31-9f11-f16052e6b683	9c9ca5de-c0e8-486f-8149-af5111b1d844
ab9e8884-d4fb-46c2-aa6b-63199b04cc51	9c9ca5de-c0e8-486f-8149-af5111b1d844
f277f946-fac8-4e6d-b559-cd5e1c585132	9c9ca5de-c0e8-486f-8149-af5111b1d844
d67210f2-7e45-424c-aed7-37b8e631de85	9c9ca5de-c0e8-486f-8149-af5111b1d844
87218da1-e4f1-4325-86d6-2d887293a78b	9c9ca5de-c0e8-486f-8149-af5111b1d844
1c91e2cf-2ba5-4f36-8129-61fc54e0eb6b	9c9ca5de-c0e8-486f-8149-af5111b1d844
229ef37a-10bd-42d9-9678-9b187a928480	9c9ca5de-c0e8-486f-8149-af5111b1d844
0fa98490-cd28-4ba3-ab92-e2dd38aa7757	9c9ca5de-c0e8-486f-8149-af5111b1d844
9af20fe9-25d2-4ac4-8261-186eb9c77129	9c9ca5de-c0e8-486f-8149-af5111b1d844
a88175b9-a697-4e34-b7eb-788f5c6ed633	9c9ca5de-c0e8-486f-8149-af5111b1d844
8492f585-0ff7-43e8-96c6-1e1609368605	9c9ca5de-c0e8-486f-8149-af5111b1d844
bd0bdbed-47bb-4b4b-9e9f-59029ccfaad8	9c9ca5de-c0e8-486f-8149-af5111b1d844
e38b7681-f653-4e77-b040-ef9c1927cee4	9c9ca5de-c0e8-486f-8149-af5111b1d844
4292efd1-c906-430e-8b2e-2c2ce5dfe921	9c9ca5de-c0e8-486f-8149-af5111b1d844
3e0c04c0-bdd0-475b-a9dc-a64c32eda7f6	9c9ca5de-c0e8-486f-8149-af5111b1d844
5c8fab78-338e-43d6-b411-60089a36d62e	9c9ca5de-c0e8-486f-8149-af5111b1d844
52799593-858e-42c2-91a7-02d1ec9de718	9c9ca5de-c0e8-486f-8149-af5111b1d844
ec77644f-6394-45eb-992f-d4c454d1f443	9c9ca5de-c0e8-486f-8149-af5111b1d844
1e60fadd-42ac-485a-adbb-95e64701aa23	9c9ca5de-c0e8-486f-8149-af5111b1d844
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	de1ce17c-8db0-4795-9c38-e00352ff9a76
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	43416877-cb87-43ae-8ec8-7cc5c2be949d
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	6b82d6df-1171-4e29-9fce-c59f5c7e26e2
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	6f599df7-ef8f-4b77-9cb9-eff7a38594df
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	2457a46a-df3a-41db-aa7a-35cce6b6e246
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	c63afc70-54d5-4755-9570-62713302162d
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	8fb67229-c0dd-411e-8c61-40c9972b2d9c
eb0ad1c3-45fb-41da-8b88-4f5756664839	6f599df7-ef8f-4b77-9cb9-eff7a38594df
eb0ad1c3-45fb-41da-8b88-4f5756664839	2457a46a-df3a-41db-aa7a-35cce6b6e246
eb0ad1c3-45fb-41da-8b88-4f5756664839	c63afc70-54d5-4755-9570-62713302162d
a065f7b7-2aa9-4278-ab5a-833693f543d9	8fb67229-c0dd-411e-8c61-40c9972b2d9c
59e0372b-a763-4105-9b3d-cae24327352f	43416877-cb87-43ae-8ec8-7cc5c2be949d
59e0372b-a763-4105-9b3d-cae24327352f	6b82d6df-1171-4e29-9fce-c59f5c7e26e2
6dbac6ce-a160-4e17-bdb7-1bf8673fe00e	65d91c84-f89d-4ca3-bebe-1f1f3df25c06
59e0372b-a763-4105-9b3d-cae24327352f	de1ce17c-8db0-4795-9c38-e00352ff9a76
\.


--
-- TOC entry 4182 (class 0 OID 16554)
-- Dependencies: 238
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- TOC entry 4193 (class 0 OID 16860)
-- Dependencies: 249
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- TOC entry 4175 (class 0 OID 16522)
-- Dependencies: 231
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- TOC entry 4183 (class 0 OID 16565)
-- Dependencies: 239
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.web_origins (client_id, value) FROM stdin;
f1e904a5-65c9-4c8d-902d-d56dc02a86c8	+
15bff922-9d6c-425a-b6e5-a0b17d0e8886	+
fc797aba-a792-4450-9575-d92c74afb436	*
\.


--
-- TOC entry 4158 (class 0 OID 16404)
-- Dependencies: 214
-- Data for Name: works; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.works (id, transport_id, executor_id, perform_date, return_date, price, mileage, task) FROM stdin;
26	4	6f599df7-ef8f-4b77-9cb9-eff7a38594df	2022-07-19 10:50:18	\N	1000	1	Замена шин
27	7	6f599df7-ef8f-4b77-9cb9-eff7a38594df	2022-07-19 08:00:21	\N	1500	20	Уборка салона
28	7	6f599df7-ef8f-4b77-9cb9-eff7a38594df	2022-07-22 08:00:00	\N	2000	400	Покраска кузова
29	4	2457a46a-df3a-41db-aa7a-35cce6b6e246	2022-07-20 12:00:19	\N	800	400	Технический осмотр
30	7	c63afc70-54d5-4755-9570-62713302162d	2022-07-19 02:06:59	\N	5000	1000	Замена лобового стекла
31	6	c63afc70-54d5-4755-9570-62713302162d	2022-07-19 02:07:26	\N	10000	20	Замена кузова
32	5	c63afc70-54d5-4755-9570-62713302162d	2022-07-25 16:00:46	\N	300	2000	Замена масла
\.


--
-- TOC entry 4258 (class 0 OID 0)
-- Dependencies: 209
-- Name: logs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.logs_id_seq', 11352, true);


--
-- TOC entry 4259 (class 0 OID 0)
-- Dependencies: 211
-- Name: transports_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transports_id_seq', 7, true);


--
-- TOC entry 4260 (class 0 OID 0)
-- Dependencies: 213
-- Name: works_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.works_id_seq', 32, true);


--
-- TOC entry 3694 (class 2606 OID 17621)
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- TOC entry 3667 (class 2606 OID 17930)
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- TOC entry 3910 (class 2606 OID 17760)
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- TOC entry 3912 (class 2606 OID 17959)
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- TOC entry 3907 (class 2606 OID 17635)
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- TOC entry 3824 (class 2606 OID 17283)
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- TOC entry 3872 (class 2606 OID 17558)
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3794 (class 2606 OID 17192)
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- TOC entry 3898 (class 2606 OID 17578)
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- TOC entry 3901 (class 2606 OID 17576)
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- TOC entry 3890 (class 2606 OID 17574)
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3874 (class 2606 OID 17560)
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3877 (class 2606 OID 17562)
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- TOC entry 3882 (class 2606 OID 17568)
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- TOC entry 3886 (class 2606 OID 17570)
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3894 (class 2606 OID 17572)
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3905 (class 2606 OID 17615)
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- TOC entry 3826 (class 2606 OID 17719)
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- TOC entry 3753 (class 2606 OID 17736)
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- TOC entry 3681 (class 2606 OID 17738)
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- TOC entry 3748 (class 2606 OID 17740)
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- TOC entry 3741 (class 2606 OID 16869)
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- TOC entry 3724 (class 2606 OID 16803)
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- TOC entry 3664 (class 2606 OID 16577)
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- TOC entry 3737 (class 2606 OID 16871)
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- TOC entry 3673 (class 2606 OID 16579)
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- TOC entry 3655 (class 2606 OID 16581)
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- TOC entry 3719 (class 2606 OID 16583)
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- TOC entry 3710 (class 2606 OID 16585)
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- TOC entry 3727 (class 2606 OID 16805)
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- TOC entry 3647 (class 2606 OID 16589)
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- TOC entry 3652 (class 2606 OID 16591)
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- TOC entry 3691 (class 2606 OID 16593)
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- TOC entry 3729 (class 2606 OID 16807)
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- TOC entry 3678 (class 2606 OID 16595)
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- TOC entry 3684 (class 2606 OID 16597)
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- TOC entry 3669 (class 2606 OID 16599)
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- TOC entry 3771 (class 2606 OID 17723)
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- TOC entry 3784 (class 2606 OID 17100)
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- TOC entry 3780 (class 2606 OID 17098)
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- TOC entry 3777 (class 2606 OID 17096)
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- TOC entry 3774 (class 2606 OID 17094)
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- TOC entry 3792 (class 2606 OID 17104)
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- TOC entry 3716 (class 2606 OID 16601)
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- TOC entry 3657 (class 2606 OID 17717)
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- TOC entry 3769 (class 2606 OID 16987)
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- TOC entry 3746 (class 2606 OID 16873)
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- TOC entry 3858 (class 2606 OID 17441)
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- TOC entry 3686 (class 2606 OID 16603)
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- TOC entry 3661 (class 2606 OID 16605)
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- TOC entry 3708 (class 2606 OID 16607)
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- TOC entry 3925 (class 2606 OID 17858)
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- TOC entry 3843 (class 2606 OID 17399)
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- TOC entry 3853 (class 2606 OID 17427)
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- TOC entry 3869 (class 2606 OID 17496)
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- TOC entry 3863 (class 2606 OID 17466)
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- TOC entry 3848 (class 2606 OID 17413)
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- TOC entry 3860 (class 2606 OID 17451)
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- TOC entry 3866 (class 2606 OID 17481)
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- TOC entry 3700 (class 2606 OID 16609)
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- TOC entry 3790 (class 2606 OID 17108)
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- TOC entry 3786 (class 2606 OID 17106)
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- TOC entry 3923 (class 2606 OID 17843)
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3920 (class 2606 OID 17833)
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- TOC entry 3764 (class 2606 OID 16981)
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- TOC entry 3811 (class 2606 OID 17250)
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- TOC entry 3818 (class 2606 OID 17257)
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3815 (class 2606 OID 17271)
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- TOC entry 3759 (class 2606 OID 16977)
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- TOC entry 3762 (class 2606 OID 17157)
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- TOC entry 3756 (class 2606 OID 16975)
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- TOC entry 3807 (class 2606 OID 17936)
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- TOC entry 3801 (class 2606 OID 17227)
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- TOC entry 3731 (class 2606 OID 16867)
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- TOC entry 3735 (class 2606 OID 17150)
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- TOC entry 3688 (class 2606 OID 17742)
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- TOC entry 3799 (class 2606 OID 17190)
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- TOC entry 3796 (class 2606 OID 17188)
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- TOC entry 3713 (class 2606 OID 17102)
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- TOC entry 3931 (class 2606 OID 17905)
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- TOC entry 3933 (class 2606 OID 17912)
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3696 (class 2606 OID 17186)
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- TOC entry 3821 (class 2606 OID 17264)
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- TOC entry 3751 (class 2606 OID 16877)
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- TOC entry 3721 (class 2606 OID 17744)
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- TOC entry 3645 (class 2606 OID 16421)
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


--
-- TOC entry 3636 (class 2606 OID 16392)
-- Name: logs logs_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.logs
    ADD CONSTRAINT logs_pk PRIMARY KEY (id);


--
-- TOC entry 3835 (class 2606 OID 17367)
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- TOC entry 3830 (class 2606 OID 17326)
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- TOC entry 3841 (class 2606 OID 17697)
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- TOC entry 3839 (class 2606 OID 17355)
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- TOC entry 3918 (class 2606 OID 17818)
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- TOC entry 3936 (class 2606 OID 17953)
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- TOC entry 3929 (class 2606 OID 17885)
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- TOC entry 3813 (class 2606 OID 17627)
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- TOC entry 3640 (class 2606 OID 16400)
-- Name: transports transports_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transports
    ADD CONSTRAINT transports_pk PRIMARY KEY (id);


--
-- TOC entry 3744 (class 2606 OID 16924)
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- TOC entry 3650 (class 2606 OID 16613)
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- TOC entry 3832 (class 2606 OID 17771)
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- TOC entry 3704 (class 2606 OID 16617)
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- TOC entry 3846 (class 2606 OID 17944)
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- TOC entry 3927 (class 2606 OID 17940)
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- TOC entry 3856 (class 2606 OID 17688)
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3851 (class 2606 OID 17692)
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- TOC entry 3767 (class 2606 OID 17932)
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- TOC entry 3676 (class 2606 OID 16625)
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- TOC entry 3706 (class 2606 OID 17617)
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- TOC entry 3643 (class 2606 OID 16410)
-- Name: works works_pk; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT works_pk PRIMARY KEY (id);


--
-- TOC entry 3772 (class 1259 OID 17969)
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


--
-- TOC entry 3870 (class 1259 OID 17641)
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- TOC entry 3775 (class 1259 OID 17645)
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- TOC entry 3781 (class 1259 OID 17643)
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- TOC entry 3782 (class 1259 OID 17642)
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- TOC entry 3778 (class 1259 OID 17644)
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- TOC entry 3913 (class 1259 OID 17960)
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- TOC entry 3725 (class 1259 OID 17966)
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- TOC entry 3648 (class 1259 OID 17945)
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- TOC entry 3908 (class 1259 OID 17685)
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- TOC entry 3653 (class 1259 OID 17649)
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- TOC entry 3833 (class 1259 OID 17848)
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- TOC entry 3914 (class 1259 OID 17957)
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- TOC entry 3732 (class 1259 OID 17845)
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- TOC entry 3836 (class 1259 OID 17846)
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- TOC entry 3899 (class 1259 OID 17651)
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- TOC entry 3902 (class 1259 OID 17919)
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- TOC entry 3903 (class 1259 OID 17650)
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- TOC entry 3658 (class 1259 OID 17652)
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- TOC entry 3659 (class 1259 OID 17653)
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- TOC entry 3915 (class 1259 OID 17851)
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- TOC entry 3916 (class 1259 OID 17852)
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- TOC entry 3665 (class 1259 OID 17946)
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- TOC entry 3738 (class 1259 OID 17384)
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- TOC entry 3739 (class 1259 OID 17383)
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- TOC entry 3875 (class 1259 OID 17745)
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- TOC entry 3878 (class 1259 OID 17765)
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- TOC entry 3879 (class 1259 OID 17928)
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- TOC entry 3880 (class 1259 OID 17747)
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- TOC entry 3883 (class 1259 OID 17748)
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- TOC entry 3884 (class 1259 OID 17749)
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- TOC entry 3887 (class 1259 OID 17750)
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- TOC entry 3888 (class 1259 OID 17751)
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- TOC entry 3891 (class 1259 OID 17752)
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- TOC entry 3892 (class 1259 OID 17753)
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- TOC entry 3895 (class 1259 OID 17754)
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- TOC entry 3896 (class 1259 OID 17755)
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- TOC entry 3819 (class 1259 OID 17656)
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- TOC entry 3816 (class 1259 OID 17657)
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- TOC entry 3760 (class 1259 OID 17659)
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- TOC entry 3742 (class 1259 OID 17658)
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- TOC entry 3670 (class 1259 OID 17660)
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- TOC entry 3671 (class 1259 OID 17661)
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- TOC entry 3808 (class 1259 OID 17963)
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- TOC entry 3802 (class 1259 OID 17964)
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- TOC entry 3803 (class 1259 OID 17965)
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- TOC entry 3804 (class 1259 OID 17923)
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- TOC entry 3805 (class 1259 OID 17954)
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- TOC entry 3733 (class 1259 OID 17662)
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- TOC entry 3679 (class 1259 OID 17665)
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- TOC entry 3828 (class 1259 OID 17844)
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- TOC entry 3827 (class 1259 OID 17666)
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- TOC entry 3682 (class 1259 OID 17669)
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- TOC entry 3754 (class 1259 OID 17668)
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- TOC entry 3674 (class 1259 OID 17664)
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- TOC entry 3749 (class 1259 OID 17670)
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- TOC entry 3689 (class 1259 OID 17671)
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- TOC entry 3797 (class 1259 OID 17672)
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- TOC entry 3864 (class 1259 OID 17673)
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- TOC entry 3861 (class 1259 OID 17674)
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- TOC entry 3854 (class 1259 OID 17693)
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- TOC entry 3844 (class 1259 OID 17694)
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- TOC entry 3849 (class 1259 OID 17695)
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- TOC entry 3934 (class 1259 OID 17918)
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- TOC entry 3837 (class 1259 OID 17847)
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- TOC entry 3692 (class 1259 OID 17678)
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- TOC entry 3867 (class 1259 OID 17679)
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- TOC entry 3757 (class 1259 OID 17926)
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- TOC entry 3809 (class 1259 OID 17373)
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- TOC entry 3921 (class 1259 OID 17853)
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- TOC entry 3697 (class 1259 OID 17380)
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- TOC entry 3698 (class 1259 OID 17967)
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- TOC entry 3765 (class 1259 OID 17377)
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- TOC entry 3662 (class 1259 OID 17381)
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- TOC entry 3701 (class 1259 OID 17374)
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- TOC entry 3822 (class 1259 OID 17376)
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- TOC entry 3714 (class 1259 OID 17382)
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- TOC entry 3717 (class 1259 OID 17375)
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- TOC entry 3702 (class 1259 OID 17968)
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


--
-- TOC entry 3787 (class 1259 OID 17681)
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- TOC entry 3788 (class 1259 OID 17682)
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- TOC entry 3711 (class 1259 OID 17683)
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- TOC entry 3722 (class 1259 OID 17684)
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- TOC entry 3637 (class 1259 OID 16401)
-- Name: transports_number_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX transports_number_idx ON public.transports USING btree (number);


--
-- TOC entry 3638 (class 1259 OID 16402)
-- Name: transports_owner_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX transports_owner_id_idx ON public.transports USING btree (owner_id);


--
-- TOC entry 3641 (class 1259 OID 32826)
-- Name: works_executor_id_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX works_executor_id_idx ON public.works USING btree (executor_id);


--
-- TOC entry 3980 (class 2606 OID 17109)
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3964 (class 2606 OID 16878)
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3957 (class 2606 OID 16808)
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3963 (class 2606 OID 16888)
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3959 (class 2606 OID 17035)
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3958 (class 2606 OID 16813)
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3967 (class 2606 OID 16918)
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- TOC entry 3940 (class 2606 OID 16628)
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3949 (class 2606 OID 16633)
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3953 (class 2606 OID 16638)
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3972 (class 2606 OID 17013)
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3947 (class 2606 OID 16648)
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4010 (class 2606 OID 17886)
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3951 (class 2606 OID 16653)
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3954 (class 2606 OID 16663)
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3944 (class 2606 OID 16668)
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- TOC entry 3948 (class 2606 OID 16673)
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3945 (class 2606 OID 16688)
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3941 (class 2606 OID 16693)
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3976 (class 2606 OID 17129)
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- TOC entry 3975 (class 2606 OID 17124)
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3974 (class 2606 OID 17119)
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3973 (class 2606 OID 17114)
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3939 (class 2606 OID 16698)
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- TOC entry 3955 (class 2606 OID 16703)
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3987 (class 2606 OID 17792)
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3988 (class 2606 OID 17782)
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 3981 (class 2606 OID 17198)
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- TOC entry 3961 (class 2606 OID 17777)
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- TOC entry 4003 (class 2606 OID 17636)
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4001 (class 2606 OID 17584)
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- TOC entry 4002 (class 2606 OID 17579)
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3986 (class 2606 OID 17284)
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3979 (class 2606 OID 17144)
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- TOC entry 3978 (class 2606 OID 17139)
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3977 (class 2606 OID 17134)
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4000 (class 2606 OID 17502)
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3998 (class 2606 OID 17487)
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 4006 (class 2606 OID 17859)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3989 (class 2606 OID 17703)
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 4007 (class 2606 OID 17864)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 4008 (class 2606 OID 17869)
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3999 (class 2606 OID 17497)
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3997 (class 2606 OID 17482)
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 4009 (class 2606 OID 17891)
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3991 (class 2606 OID 17698)
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3993 (class 2606 OID 17452)
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3995 (class 2606 OID 17467)
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 3996 (class 2606 OID 17472)
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3994 (class 2606 OID 17457)
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- TOC entry 3990 (class 2606 OID 17708)
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- TOC entry 3942 (class 2606 OID 16718)
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- TOC entry 4005 (class 2606 OID 17834)
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- TOC entry 3971 (class 2606 OID 16998)
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3984 (class 2606 OID 17258)
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3983 (class 2606 OID 17272)
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- TOC entry 3968 (class 2606 OID 16944)
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3946 (class 2606 OID 16728)
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3969 (class 2606 OID 16988)
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3970 (class 2606 OID 17158)
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- TOC entry 3956 (class 2606 OID 16738)
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3950 (class 2606 OID 16748)
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3960 (class 2606 OID 16883)
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- TOC entry 3943 (class 2606 OID 16763)
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3962 (class 2606 OID 17151)
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- TOC entry 4004 (class 2606 OID 17819)
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3982 (class 2606 OID 17193)
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 4011 (class 2606 OID 17899)
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- TOC entry 4012 (class 2606 OID 17913)
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- TOC entry 3966 (class 2606 OID 16913)
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- TOC entry 3952 (class 2606 OID 16783)
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- TOC entry 3985 (class 2606 OID 17265)
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- TOC entry 3992 (class 2606 OID 17442)
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- TOC entry 3965 (class 2606 OID 16893)
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- TOC entry 3937 (class 2606 OID 16411)
-- Name: works works_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT works_fk FOREIGN KEY (transport_id) REFERENCES public.transports(id) ON DELETE CASCADE;


--
-- TOC entry 3938 (class 2606 OID 32827)
-- Name: works works_user_fk; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.works
    ADD CONSTRAINT works_user_fk FOREIGN KEY (executor_id) REFERENCES public.user_entity(id);


-- Completed on 2022-07-19 02:43:07

--
-- PostgreSQL database dump complete
--


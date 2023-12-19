--
-- PostgreSQL database dump
--

-- Dumped from database version 16.1
-- Dumped by pg_dump version 16.1

-- Started on 2023-12-19 13:11:37 CST

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
-- TOC entry 6 (class 2615 OID 16401)
-- Name: mydb; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA mydb;


ALTER SCHEMA mydb OWNER TO postgres;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 217 (class 1259 OID 16412)
-- Name: authorconceptlkup; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.authorconceptlkup (
    employeeid smallint NOT NULL,
    conceptid bigint NOT NULL
);


ALTER TABLE mydb.authorconceptlkup OWNER TO postgres;

--
-- TOC entry 216 (class 1259 OID 16403)
-- Name: businessimpact_businessimpactid_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.businessimpact_businessimpactid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE mydb.businessimpact_businessimpactid_seq OWNER TO postgres;

--
-- TOC entry 218 (class 1259 OID 16417)
-- Name: businessimpact; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.businessimpact (
    businessimpactid integer DEFAULT nextval('mydb.businessimpact_businessimpactid_seq'::regclass) NOT NULL,
    conceptid bigint NOT NULL,
    businessimpactdescription character varying(256) NOT NULL
);


ALTER TABLE mydb.businessimpact OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16423)
-- Name: concept_conceptid_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.concept_conceptid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mydb.concept_conceptid_seq OWNER TO postgres;

--
-- TOC entry 220 (class 1259 OID 16424)
-- Name: concept; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.concept (
    conceptid bigint DEFAULT nextval('mydb.concept_conceptid_seq'::regclass) NOT NULL,
    title character varying(256) NOT NULL,
    status character varying(64),
    description character varying(512),
    inscope smallint,
    creationdate date,
    modificationdate date
);


ALTER TABLE mydb.concept OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16432)
-- Name: conceptmateriallkup; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.conceptmateriallkup (
    conceptid bigint NOT NULL,
    materialid integer NOT NULL
);


ALTER TABLE mydb.conceptmateriallkup OWNER TO postgres;

--
-- TOC entry 222 (class 1259 OID 16435)
-- Name: conceptsubsystemlkup; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.conceptsubsystemlkup (
    conceptid bigint NOT NULL,
    subsystemid smallint NOT NULL
);


ALTER TABLE mydb.conceptsubsystemlkup OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16438)
-- Name: concepttrllkup; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.concepttrllkup (
    conceptid bigint NOT NULL,
    trlid bigint NOT NULL
);


ALTER TABLE mydb.concepttrllkup OWNER TO postgres;

--
-- TOC entry 224 (class 1259 OID 16443)
-- Name: employee_employeeid_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.employee_employeeid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE mydb.employee_employeeid_seq OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16444)
-- Name: employee; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.employee (
    employeeid integer DEFAULT nextval('mydb.employee_employeeid_seq'::regclass) NOT NULL,
    name character varying(128),
    initial character varying(5)
);


ALTER TABLE mydb.employee OWNER TO postgres;

--
-- TOC entry 226 (class 1259 OID 16450)
-- Name: function_functionid_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.function_functionid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE mydb.function_functionid_seq OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16451)
-- Name: function; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.function (
    functionid smallint DEFAULT nextval('mydb.function_functionid_seq'::regclass) NOT NULL,
    functionname character varying(128) NOT NULL,
    systemfunction character varying(128) NOT NULL,
    functionalgroup character varying(128) NOT NULL
);


ALTER TABLE mydb.function OWNER TO postgres;

--
-- TOC entry 228 (class 1259 OID 16457)
-- Name: module_moduleid_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.module_moduleid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE mydb.module_moduleid_seq OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16458)
-- Name: module; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.module (
    moduleid smallint DEFAULT nextval('mydb.module_moduleid_seq'::regclass) NOT NULL,
    modulename character varying(128) NOT NULL
);


ALTER TABLE mydb.module OWNER TO postgres;

--
-- TOC entry 230 (class 1259 OID 16464)
-- Name: patent_patentid_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.patent_patentid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE mydb.patent_patentid_seq OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16465)
-- Name: patent; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.patent (
    patentid integer DEFAULT nextval('mydb.patent_patentid_seq'::regclass) NOT NULL,
    fileddate date,
    patenteddate date,
    patentdescription character varying(256),
    idfsubmissiondate date,
    idfstatus character varying(50),
    author character varying(180)
);


ALTER TABLE mydb.patent OWNER TO postgres;

--
-- TOC entry 232 (class 1259 OID 16471)
-- Name: patentconceptlkup; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.patentconceptlkup (
    patentid integer NOT NULL,
    conceptid bigint NOT NULL
);


ALTER TABLE mydb.patentconceptlkup OWNER TO postgres;

--
-- TOC entry 233 (class 1259 OID 16476)
-- Name: subsystem_subsystemid_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.subsystem_subsystemid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE mydb.subsystem_subsystemid_seq OWNER TO postgres;

--
-- TOC entry 234 (class 1259 OID 16477)
-- Name: subsystem; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.subsystem (
    subsystemid smallint DEFAULT nextval('mydb.subsystem_subsystemid_seq'::regclass) NOT NULL,
    subsystemname character varying(128) NOT NULL
);


ALTER TABLE mydb.subsystem OWNER TO postgres;

--
-- TOC entry 235 (class 1259 OID 16483)
-- Name: subsystemfunctionlkup; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.subsystemfunctionlkup (
    subsystemid smallint NOT NULL,
    functionid smallint NOT NULL
);


ALTER TABLE mydb.subsystemfunctionlkup OWNER TO postgres;

--
-- TOC entry 236 (class 1259 OID 16486)
-- Name: subsystemmodulelkup; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.subsystemmodulelkup (
    subsystemid smallint NOT NULL,
    moduleid smallint NOT NULL
);


ALTER TABLE mydb.subsystemmodulelkup OWNER TO postgres;

--
-- TOC entry 237 (class 1259 OID 16489)
-- Name: supportmaterial_supportmaterialid_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.supportmaterial_supportmaterialid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    MAXVALUE 2147483647
    CACHE 1;


ALTER SEQUENCE mydb.supportmaterial_supportmaterialid_seq OWNER TO postgres;

--
-- TOC entry 238 (class 1259 OID 16490)
-- Name: supportmaterial; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.supportmaterial (
    supportmaterialid integer DEFAULT nextval('mydb.supportmaterial_supportmaterialid_seq'::regclass) NOT NULL,
    supportmaterialtitle character varying(256) NOT NULL,
    type character varying(64) NOT NULL,
    location character varying(128) NOT NULL
);


ALTER TABLE mydb.supportmaterial OWNER TO postgres;

--
-- TOC entry 239 (class 1259 OID 16496)
-- Name: trladvancement_trlid_seq; Type: SEQUENCE; Schema: mydb; Owner: postgres
--

CREATE SEQUENCE mydb.trladvancement_trlid_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE mydb.trladvancement_trlid_seq OWNER TO postgres;

--
-- TOC entry 240 (class 1259 OID 16497)
-- Name: trladvancement; Type: TABLE; Schema: mydb; Owner: postgres
--

CREATE TABLE mydb.trladvancement (
    trlid bigint DEFAULT nextval('mydb.trladvancement_trlid_seq'::regclass) NOT NULL,
    trltitle character varying(256),
    activitydate date,
    trldescription character varying(512)
);


ALTER TABLE mydb.trladvancement OWNER TO postgres;

--
-- TOC entry 3702 (class 0 OID 16412)
-- Dependencies: 217
-- Data for Name: authorconceptlkup; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.authorconceptlkup VALUES (1, 1);
INSERT INTO mydb.authorconceptlkup VALUES (2, 2);
INSERT INTO mydb.authorconceptlkup VALUES (3, 3);
INSERT INTO mydb.authorconceptlkup VALUES (4, 4);
INSERT INTO mydb.authorconceptlkup VALUES (4, 5);
INSERT INTO mydb.authorconceptlkup VALUES (5, 6);
INSERT INTO mydb.authorconceptlkup VALUES (6, 7);
INSERT INTO mydb.authorconceptlkup VALUES (7, 8);
INSERT INTO mydb.authorconceptlkup VALUES (5, 9);
INSERT INTO mydb.authorconceptlkup VALUES (27, 52);
INSERT INTO mydb.authorconceptlkup VALUES (1, 71);
INSERT INTO mydb.authorconceptlkup VALUES (1, 80);
INSERT INTO mydb.authorconceptlkup VALUES (1, 81);
INSERT INTO mydb.authorconceptlkup VALUES (1, 84);
INSERT INTO mydb.authorconceptlkup VALUES (1, 85);
INSERT INTO mydb.authorconceptlkup VALUES (1, 86);
INSERT INTO mydb.authorconceptlkup VALUES (1, 87);
INSERT INTO mydb.authorconceptlkup VALUES (1, 90);
INSERT INTO mydb.authorconceptlkup VALUES (1, 92);
INSERT INTO mydb.authorconceptlkup VALUES (1, 94);
INSERT INTO mydb.authorconceptlkup VALUES (1, 95);
INSERT INTO mydb.authorconceptlkup VALUES (1, 96);


--
-- TOC entry 3703 (class 0 OID 16417)
-- Dependencies: 218
-- Data for Name: businessimpact; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.businessimpact VALUES (1, 1, 'The advanced droplet dispensing system will improve manufacturing efficiency and accuracy in semiconductor fabrication.');
INSERT INTO mydb.businessimpact VALUES (2, 2, 'Increased accuracy and throughput in lithography');
INSERT INTO mydb.businessimpact VALUES (3, 3, 'Reduced false positives in defect detection');
INSERT INTO mydb.businessimpact VALUES (4, 4, 'available');
INSERT INTO mydb.businessimpact VALUES (10, 52, 'test');
INSERT INTO mydb.businessimpact VALUES (0, 90, 'no impact');
INSERT INTO mydb.businessimpact VALUES (3, 95, 'sdfsd');


--
-- TOC entry 3705 (class 0 OID 16424)
-- Dependencies: 220
-- Data for Name: concept; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.concept VALUES (5, 'EUV Gas Chamber Protection v.2', NULL, 'Study on effects of mixed alloys', NULL, '2016-04-01', NULL);
INSERT INTO mydb.concept VALUES (6, 'EUV Gas Chamber Protection v.3', NULL, 'Test hypothesis on effects of gas on certain alloys', NULL, '2016-07-01', NULL);
INSERT INTO mydb.concept VALUES (7, 'EUV Gas Chamber Protection v.4', NULL, 'Analyze test results', NULL, '2017-01-01', NULL);
INSERT INTO mydb.concept VALUES (8, 'EUV Gas Chamber Protection v.5', NULL, 'Modifications from findings', NULL, '2017-02-01', NULL);
INSERT INTO mydb.concept VALUES (9, 'EUV Gas Chamber Protection v.6', NULL, 'Derive conclusion', NULL, '2018-01-01', NULL);
INSERT INTO mydb.concept VALUES (10, 'EUV Gas Chamber Protection v.7', NULL, 'Final version of alloy', NULL, '2018-12-01', NULL);
INSERT INTO mydb.concept VALUES (12, 'Inert gas cleaning for collector v.2', NULL, 'Study on the effectiveness of certain gases to remove tin contamination', NULL, '2022-06-01', NULL);
INSERT INTO mydb.concept VALUES (13, 'Inert gas cleaning for collector v.3', NULL, 'Testing the concept of gases on removing tin', NULL, '2022-08-01', NULL);
INSERT INTO mydb.concept VALUES (14, 'Inert gascleaning for collector v.4', NULL, 'Conclusions on effectiveness of inert gases', NULL, '2023-01-01', NULL);
INSERT INTO mydb.concept VALUES (15, 'Nanostructured materials', NULL, 'Nanostructured liners', NULL, '2023-06-06', NULL);
INSERT INTO mydb.concept VALUES (2, 'Extreme UV lithography', 'Completed', 'Developing a new light source for lithography', 1, '2023-04-01', NULL);
INSERT INTO mydb.concept VALUES (3, 'Machine learning on optimizing dose target', 'In Progress', 'Using deep learning algorithms to optimizatin of dose target', 1, '2023-04-01', NULL);
INSERT INTO mydb.concept VALUES (4, 'EUV Gas Chamber Protection', 'In Progress', 'Prevent corrosion of gas chambers', 0, '2016-02-01', NULL);
INSERT INTO mydb.concept VALUES (52, 'test', 'Completed', 'test', 1, '2023-08-17', NULL);
INSERT INTO mydb.concept VALUES (55, 'New concept by Harish', 'In Progress', 'New concept', 1, '2024-02-02', NULL);
INSERT INTO mydb.concept VALUES (58, 'New concept by Harish', 'In Progress', 'New concept', 1, '2024-02-02', NULL);
INSERT INTO mydb.concept VALUES (59, 'New concept by Harish', 'In Progress', 'New concept', 1, '2024-02-02', NULL);
INSERT INTO mydb.concept VALUES (60, 'New concept by Harish', 'In Progress', 'New concept', 1, '2024-02-02', NULL);
INSERT INTO mydb.concept VALUES (71, 'New concept by John', 'In Progress', 'New concept', 1, '2024-02-02', NULL);
INSERT INTO mydb.concept VALUES (74, 'Laser Lithography change management', 'Not Started', '  Laser lithography change', 0, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (75, 'Test title 111', 'Not Started', '  Test description', 2, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (76, 'Test Title', 'Completed', '  Descript', 2, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (79, 'Test report 555', 'Not Started', '  TEst', 2, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (80, 'Test concept 444', 'Not Started', '  TEst', 2, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (81, 'Test Concept 888', 'Not Started', '  test', 2, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (84, 'Test as of today', 'Completed', '  ', 2, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (85, 'Test concept 3331', 'Completed', '  TEst desc', 2, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (86, 'Test Concept', 'Completed', '  ', 2, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (87, 'Test 55555', 'Completed', '  ', 2, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (90, 'Test nasa 1', 'Completed', '  test nasa', NULL, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (92, 'test title 4543', 'Completed', '  test', NULL, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (94, 'test time', 'Completed', '  sdf', NULL, '2023-12-26', NULL);
INSERT INTO mydb.concept VALUES (95, 'test conceptllll', 'Completed', '  testlkjs', NULL, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (78, 'Test concept 33345', 'Completed', '   Test concept 333 ', NULL, '2023-12-19', NULL);
INSERT INTO mydb.concept VALUES (11, 'Inert gas on cleaning collector v.1', 'In Progress', ' Radical helium and other inert gases for cleaning collector concept ', NULL, '2022-04-01', NULL);
INSERT INTO mydb.concept VALUES (1, 'Advanced Dispensing for DEMO EDIT', 'Completed', '      Developing a precision dispenser for LAX  ', NULL, '2023-04-01', '2023-08-10');
INSERT INTO mydb.concept VALUES (96, 'UV Laster lithography', 'In Progress', '  Test application', NULL, '2023-12-19', NULL);


--
-- TOC entry 3706 (class 0 OID 16432)
-- Dependencies: 221
-- Data for Name: conceptmateriallkup; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.conceptmateriallkup VALUES (1, 1);
INSERT INTO mydb.conceptmateriallkup VALUES (2, 2);
INSERT INTO mydb.conceptmateriallkup VALUES (2, 3);
INSERT INTO mydb.conceptmateriallkup VALUES (3, 4);


--
-- TOC entry 3707 (class 0 OID 16435)
-- Dependencies: 222
-- Data for Name: conceptsubsystemlkup; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.conceptsubsystemlkup VALUES (1, 1);
INSERT INTO mydb.conceptsubsystemlkup VALUES (2, 2);
INSERT INTO mydb.conceptsubsystemlkup VALUES (3, 3);
INSERT INTO mydb.conceptsubsystemlkup VALUES (4, 4);
INSERT INTO mydb.conceptsubsystemlkup VALUES (95, 5);


--
-- TOC entry 3708 (class 0 OID 16438)
-- Dependencies: 223
-- Data for Name: concepttrllkup; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.concepttrllkup VALUES (1, 1);
INSERT INTO mydb.concepttrllkup VALUES (1, 2);
INSERT INTO mydb.concepttrllkup VALUES (2, 3);
INSERT INTO mydb.concepttrllkup VALUES (3, 4);
INSERT INTO mydb.concepttrllkup VALUES (3, 5);
INSERT INTO mydb.concepttrllkup VALUES (4, 6);
INSERT INTO mydb.concepttrllkup VALUES (5, 7);
INSERT INTO mydb.concepttrllkup VALUES (6, 8);
INSERT INTO mydb.concepttrllkup VALUES (7, 9);
INSERT INTO mydb.concepttrllkup VALUES (8, 10);
INSERT INTO mydb.concepttrllkup VALUES (9, 11);
INSERT INTO mydb.concepttrllkup VALUES (10, 12);
INSERT INTO mydb.concepttrllkup VALUES (11, 13);
INSERT INTO mydb.concepttrllkup VALUES (12, 14);
INSERT INTO mydb.concepttrllkup VALUES (13, 15);
INSERT INTO mydb.concepttrllkup VALUES (14, 16);


--
-- TOC entry 3710 (class 0 OID 16444)
-- Dependencies: 225
-- Data for Name: employee; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.employee VALUES (1, 'John Smith', 'JOSM');
INSERT INTO mydb.employee VALUES (2, 'Elvis Presley', NULL);
INSERT INTO mydb.employee VALUES (3, 'Alice Johnson', NULL);
INSERT INTO mydb.employee VALUES (4, 'Chung Lee', 'CHUN');
INSERT INTO mydb.employee VALUES (5, 'Jason Mason', NULL);
INSERT INTO mydb.employee VALUES (6, 'Christian Beil', NULL);
INSERT INTO mydb.employee VALUES (7, 'Mark Twain', NULL);
INSERT INTO mydb.employee VALUES (27, 'Michelle Samson', 'test');


--
-- TOC entry 3712 (class 0 OID 16451)
-- Dependencies: 227
-- Data for Name: function; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.function VALUES (1, 'Droplet Generation', 'Droplet Generation and Positioning', 'EUV');
INSERT INTO mydb.function VALUES (2, 'Droplet Steering', 'Droplet Generation and Positioning', 'EUV');
INSERT INTO mydb.function VALUES (3, 'Droplet Catching', 'Droplet Generation and Positioning', 'EUV');
INSERT INTO mydb.function VALUES (4, 'Plasma Generation and Control', 'Plasma Control', 'EUV');
INSERT INTO mydb.function VALUES (5, 'Energy Control', 'Plasma Control', 'EUV');
INSERT INTO mydb.function VALUES (6, 'Opt Focussed', 'EUV Collection', 'EUV');
INSERT INTO mydb.function VALUES (7, 'Spectral Purification', 'EUV Collection', 'EUV');
INSERT INTO mydb.function VALUES (8, 'Tin Capture', 'Tin Mitigation', 'EUV');
INSERT INTO mydb.function VALUES (9, 'Tin Tin Removal', 'Tin Mitigation', 'EUV');
INSERT INTO mydb.function VALUES (10, 'Tin and Gas Transport', 'Tin Mitigation', 'EUV');
INSERT INTO mydb.function VALUES (11, 'FC-033', 'M', 'EUV');
INSERT INTO mydb.function VALUES (12, 'FC-019', 'M', 'EUV');
INSERT INTO mydb.function VALUES (13, 'FC-020', 'M', 'EUV');
INSERT INTO mydb.function VALUES (14, 'FC-021', 'E', 'EUV');
INSERT INTO mydb.function VALUES (15, 'FC-022', 'E', 'EUV');
INSERT INTO mydb.function VALUES (16, 'FC-014', 'EC', 'EUV');
INSERT INTO mydb.function VALUES (17, 'FC-057', 'EC', 'EUV');


--
-- TOC entry 3714 (class 0 OID 16458)
-- Dependencies: 229
-- Data for Name: module; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.module VALUES (1, 'Droplet Generator');
INSERT INTO mydb.module VALUES (2, 'Tin Supply System');
INSERT INTO mydb.module VALUES (3, 'Ar booster and controller, RVS');
INSERT INTO mydb.module VALUES (4, 'TEM');
INSERT INTO mydb.module VALUES (5, 'DG Steering System');
INSERT INTO mydb.module VALUES (6, 'Tin Catch');
INSERT INTO mydb.module VALUES (7, 'Tin Catch Heater');
INSERT INTO mydb.module VALUES (8, 'Real Time MP/PP Triggering Controls');
INSERT INTO mydb.module VALUES (9, 'Mke First Light, Speedometer, SLRD');
INSERT INTO mydb.module VALUES (10, 'BLM, DIM/DD, DFC');
INSERT INTO mydb.module VALUES (11, 'Energy Controller EUV-Sensors');
INSERT INTO mydb.module VALUES (12, 'Collector, Collector Assembly');
INSERT INTO mydb.module VALUES (13, 'Plasma Position Camera');
INSERT INTO mydb.module VALUES (14, 'IF Cap');
INSERT INTO mydb.module VALUES (15, 'Vanes ind tin vanes Temperature Control');
INSERT INTO mydb.module VALUES (16, 'Heated Tin Bucket');
INSERT INTO mydb.module VALUES (17, 'Horizontal Obscuration, Lower Cone');
INSERT INTO mydb.module VALUES (18, 'MECL');
INSERT INTO mydb.module VALUES (19, 'COCL');
INSERT INTO mydb.module VALUES (20, 'HP-RGA');
INSERT INTO mydb.module VALUES (21, 'Collecter and Metrology Gas Delivery System');
INSERT INTO mydb.module VALUES (22, 'Shroud');
INSERT INTO mydb.module VALUES (23, 'Vessel, SSF ind Railset, QCM');
INSERT INTO mydb.module VALUES (24, 'Packaging, Transport Tools, Service Tools');
INSERT INTO mydb.module VALUES (25, 'Mechanical System Layout, no hw');
INSERT INTO mydb.module VALUES (26, 'Connector Plates');
INSERT INTO mydb.module VALUES (27, 'Mains Supply Units');
INSERT INTO mydb.module VALUES (28, 'Heat Load Distribution Specification');
INSERT INTO mydb.module VALUES (29, 'F&T Cabs');


--
-- TOC entry 3716 (class 0 OID 16465)
-- Dependencies: 231
-- Data for Name: patent; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.patent VALUES (2, '2019-07-01', '2021-07-01', 'A new light source for lithography', NULL, NULL, NULL);
INSERT INTO mydb.patent VALUES (3, '2020-01-01', '2022-01-01', 'A deep learning algorithm for dose target optimization', NULL, NULL, NULL);
INSERT INTO mydb.patent VALUES (4, '2023-02-15', '2023-07-20', 'This patent describes a deep learning algorithm capable of auto tuning dose target for optimal EUV performance.', NULL, NULL, NULL);
INSERT INTO mydb.patent VALUES (1, '2023-07-10', '2023-07-10', 'Patent for the advanced dispensing for PEZ', '2023-08-10', 'filed', 'John Smith');


--
-- TOC entry 3717 (class 0 OID 16471)
-- Dependencies: 232
-- Data for Name: patentconceptlkup; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.patentconceptlkup VALUES (1, 1);
INSERT INTO mydb.patentconceptlkup VALUES (2, 2);
INSERT INTO mydb.patentconceptlkup VALUES (3, 3);
INSERT INTO mydb.patentconceptlkup VALUES (4, 3);


--
-- TOC entry 3719 (class 0 OID 16477)
-- Dependencies: 234
-- Data for Name: subsystem; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.subsystem VALUES (1, 'Droplet System');
INSERT INTO mydb.subsystem VALUES (2, 'Plasma Control');
INSERT INTO mydb.subsystem VALUES (3, 'Vessel Subassy');
INSERT INTO mydb.subsystem VALUES (4, 'Misc.');
INSERT INTO mydb.subsystem VALUES (5, 'Plasma Control');


--
-- TOC entry 3720 (class 0 OID 16483)
-- Dependencies: 235
-- Data for Name: subsystemfunctionlkup; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.subsystemfunctionlkup VALUES (1, 1);
INSERT INTO mydb.subsystemfunctionlkup VALUES (1, 2);
INSERT INTO mydb.subsystemfunctionlkup VALUES (1, 3);
INSERT INTO mydb.subsystemfunctionlkup VALUES (2, 4);
INSERT INTO mydb.subsystemfunctionlkup VALUES (2, 5);
INSERT INTO mydb.subsystemfunctionlkup VALUES (3, 6);
INSERT INTO mydb.subsystemfunctionlkup VALUES (3, 7);
INSERT INTO mydb.subsystemfunctionlkup VALUES (3, 8);
INSERT INTO mydb.subsystemfunctionlkup VALUES (3, 9);
INSERT INTO mydb.subsystemfunctionlkup VALUES (3, 10);
INSERT INTO mydb.subsystemfunctionlkup VALUES (3, 11);
INSERT INTO mydb.subsystemfunctionlkup VALUES (4, 12);
INSERT INTO mydb.subsystemfunctionlkup VALUES (4, 13);
INSERT INTO mydb.subsystemfunctionlkup VALUES (4, 14);
INSERT INTO mydb.subsystemfunctionlkup VALUES (4, 15);
INSERT INTO mydb.subsystemfunctionlkup VALUES (4, 16);
INSERT INTO mydb.subsystemfunctionlkup VALUES (4, 17);


--
-- TOC entry 3721 (class 0 OID 16486)
-- Dependencies: 236
-- Data for Name: subsystemmodulelkup; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.subsystemmodulelkup VALUES (1, 1);
INSERT INTO mydb.subsystemmodulelkup VALUES (1, 2);
INSERT INTO mydb.subsystemmodulelkup VALUES (1, 3);
INSERT INTO mydb.subsystemmodulelkup VALUES (2, 4);
INSERT INTO mydb.subsystemmodulelkup VALUES (1, 5);
INSERT INTO mydb.subsystemmodulelkup VALUES (1, 6);
INSERT INTO mydb.subsystemmodulelkup VALUES (1, 7);
INSERT INTO mydb.subsystemmodulelkup VALUES (2, 8);
INSERT INTO mydb.subsystemmodulelkup VALUES (2, 9);
INSERT INTO mydb.subsystemmodulelkup VALUES (2, 10);
INSERT INTO mydb.subsystemmodulelkup VALUES (2, 11);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 12);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 13);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 14);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 15);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 16);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 17);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 18);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 19);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 20);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 21);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 22);
INSERT INTO mydb.subsystemmodulelkup VALUES (3, 23);
INSERT INTO mydb.subsystemmodulelkup VALUES (4, 24);
INSERT INTO mydb.subsystemmodulelkup VALUES (4, 25);
INSERT INTO mydb.subsystemmodulelkup VALUES (4, 26);
INSERT INTO mydb.subsystemmodulelkup VALUES (4, 27);
INSERT INTO mydb.subsystemmodulelkup VALUES (4, 28);
INSERT INTO mydb.subsystemmodulelkup VALUES (4, 29);


--
-- TOC entry 3723 (class 0 OID 16490)
-- Dependencies: 238
-- Data for Name: supportmaterial; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.supportmaterial VALUES (1, 'Droplet Dispensing System Overview', 'Presentation', 'https://example.com/presentation.pptx');
INSERT INTO mydb.supportmaterial VALUES (2, 'EUV Lithography Research', 'Document', 'https://example.com/doc1.pdf');
INSERT INTO mydb.supportmaterial VALUES (3, 'Understanding Extreme UV Lithography', 'ebook', 'https://example.com/doc2.pdf');
INSERT INTO mydb.supportmaterial VALUES (4, 'Deep Learning Research', 'Document', 'https://example.com/doc3.pdf');


--
-- TOC entry 3725 (class 0 OID 16497)
-- Dependencies: 240
-- Data for Name: trladvancement; Type: TABLE DATA; Schema: mydb; Owner: postgres
--

INSERT INTO mydb.trladvancement VALUES (1, 'TRL 2', '2023-07-10', 'Researching a functional prototype for the droplet dispensing system.');
INSERT INTO mydb.trladvancement VALUES (2, 'TRL 5', '2023-07-27', 'test');
INSERT INTO mydb.trladvancement VALUES (3, 'TRL 1', '2023-01-01', 'Understanding of basic principles');
INSERT INTO mydb.trladvancement VALUES (4, 'TRL 2', '2023-01-10', 'Conceptualization of technology');
INSERT INTO mydb.trladvancement VALUES (5, 'TRL 5', '2023-01-10', 'Research of technology');
INSERT INTO mydb.trladvancement VALUES (6, 'TRL 1', NULL, NULL);
INSERT INTO mydb.trladvancement VALUES (7, 'TRL 1', NULL, NULL);
INSERT INTO mydb.trladvancement VALUES (8, 'TRL 2', NULL, NULL);
INSERT INTO mydb.trladvancement VALUES (9, 'TRL 2', NULL, NULL);
INSERT INTO mydb.trladvancement VALUES (10, 'TRL 2', NULL, NULL);
INSERT INTO mydb.trladvancement VALUES (11, 'TRL 2', NULL, NULL);
INSERT INTO mydb.trladvancement VALUES (12, 'TRL 3', NULL, NULL);
INSERT INTO mydb.trladvancement VALUES (13, 'TRL 1', NULL, NULL);
INSERT INTO mydb.trladvancement VALUES (14, 'TRL 2', NULL, NULL);
INSERT INTO mydb.trladvancement VALUES (15, 'TRL 3', NULL, NULL);
INSERT INTO mydb.trladvancement VALUES (16, 'TRL 4', NULL, NULL);


--
-- TOC entry 3731 (class 0 OID 0)
-- Dependencies: 216
-- Name: businessimpact_businessimpactid_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.businessimpact_businessimpactid_seq', 3, true);


--
-- TOC entry 3732 (class 0 OID 0)
-- Dependencies: 219
-- Name: concept_conceptid_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.concept_conceptid_seq', 96, true);


--
-- TOC entry 3733 (class 0 OID 0)
-- Dependencies: 224
-- Name: employee_employeeid_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.employee_employeeid_seq', 7, true);


--
-- TOC entry 3734 (class 0 OID 0)
-- Dependencies: 226
-- Name: function_functionid_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.function_functionid_seq', 1, false);


--
-- TOC entry 3735 (class 0 OID 0)
-- Dependencies: 228
-- Name: module_moduleid_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.module_moduleid_seq', 1, false);


--
-- TOC entry 3736 (class 0 OID 0)
-- Dependencies: 230
-- Name: patent_patentid_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.patent_patentid_seq', 1, false);


--
-- TOC entry 3737 (class 0 OID 0)
-- Dependencies: 233
-- Name: subsystem_subsystemid_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.subsystem_subsystemid_seq', 5, true);


--
-- TOC entry 3738 (class 0 OID 0)
-- Dependencies: 237
-- Name: supportmaterial_supportmaterialid_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.supportmaterial_supportmaterialid_seq', 1, false);


--
-- TOC entry 3739 (class 0 OID 0)
-- Dependencies: 239
-- Name: trladvancement_trlid_seq; Type: SEQUENCE SET; Schema: mydb; Owner: postgres
--

SELECT pg_catalog.setval('mydb.trladvancement_trlid_seq', 1, false);


--
-- TOC entry 3522 (class 2606 OID 16416)
-- Name: authorconceptlkup authorconceptlkup_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.authorconceptlkup
    ADD CONSTRAINT authorconceptlkup_pkey PRIMARY KEY (employeeid, conceptid);


--
-- TOC entry 3524 (class 2606 OID 16431)
-- Name: concept conceptid_unique_idx; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.concept
    ADD CONSTRAINT conceptid_unique_idx PRIMARY KEY (conceptid);


--
-- TOC entry 3526 (class 2606 OID 16442)
-- Name: concepttrllkup concepttrllkup_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.concepttrllkup
    ADD CONSTRAINT concepttrllkup_pkey PRIMARY KEY (conceptid, trlid);


--
-- TOC entry 3528 (class 2606 OID 16449)
-- Name: employee employee_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.employee
    ADD CONSTRAINT employee_pkey PRIMARY KEY (employeeid);


--
-- TOC entry 3530 (class 2606 OID 16456)
-- Name: function function_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.function
    ADD CONSTRAINT function_pkey PRIMARY KEY (functionid);


--
-- TOC entry 3532 (class 2606 OID 16463)
-- Name: module module_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.module
    ADD CONSTRAINT module_pkey PRIMARY KEY (moduleid);


--
-- TOC entry 3534 (class 2606 OID 16470)
-- Name: patent patent_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.patent
    ADD CONSTRAINT patent_pkey PRIMARY KEY (patentid);


--
-- TOC entry 3536 (class 2606 OID 16475)
-- Name: patentconceptlkup patentconceptlkup_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.patentconceptlkup
    ADD CONSTRAINT patentconceptlkup_pkey PRIMARY KEY (patentid, conceptid);


--
-- TOC entry 3538 (class 2606 OID 16482)
-- Name: subsystem subsystem_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.subsystem
    ADD CONSTRAINT subsystem_pkey PRIMARY KEY (subsystemid);


--
-- TOC entry 3540 (class 2606 OID 16495)
-- Name: supportmaterial supportmaterial_pkey; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.supportmaterial
    ADD CONSTRAINT supportmaterial_pkey PRIMARY KEY (supportmaterialid);


--
-- TOC entry 3542 (class 2606 OID 16504)
-- Name: trladvancement trlid_unique; Type: CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.trladvancement
    ADD CONSTRAINT trlid_unique PRIMARY KEY (trlid);


--
-- TOC entry 3543 (class 2606 OID 16505)
-- Name: authorconceptlkup fk_authorconcept_idx; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.authorconceptlkup
    ADD CONSTRAINT fk_authorconcept_idx FOREIGN KEY (conceptid) REFERENCES mydb.concept(conceptid);


--
-- TOC entry 3545 (class 2606 OID 16515)
-- Name: businessimpact fk_busimpact_concept_conceptid; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.businessimpact
    ADD CONSTRAINT fk_busimpact_concept_conceptid FOREIGN KEY (conceptid) REFERENCES mydb.concept(conceptid);


--
-- TOC entry 3544 (class 2606 OID 16510)
-- Name: authorconceptlkup fk_conceptauthor_idx; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.authorconceptlkup
    ADD CONSTRAINT fk_conceptauthor_idx FOREIGN KEY (employeeid) REFERENCES mydb.employee(employeeid);


--
-- TOC entry 3546 (class 2606 OID 16520)
-- Name: conceptmateriallkup fk_conceptmaterial_conceptid; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.conceptmateriallkup
    ADD CONSTRAINT fk_conceptmaterial_conceptid FOREIGN KEY (conceptid) REFERENCES mydb.concept(conceptid);


--
-- TOC entry 3547 (class 2606 OID 16525)
-- Name: conceptmateriallkup fk_conceptmaterial_materialid; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.conceptmateriallkup
    ADD CONSTRAINT fk_conceptmaterial_materialid FOREIGN KEY (materialid) REFERENCES mydb.supportmaterial(supportmaterialid);


--
-- TOC entry 3548 (class 2606 OID 16530)
-- Name: conceptsubsystemlkup fk_conceptsubsystem_conceptid_idx; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.conceptsubsystemlkup
    ADD CONSTRAINT fk_conceptsubsystem_conceptid_idx FOREIGN KEY (conceptid) REFERENCES mydb.concept(conceptid);


--
-- TOC entry 3549 (class 2606 OID 16535)
-- Name: conceptsubsystemlkup fk_conceptsubsystem_subsystemid_idx; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.conceptsubsystemlkup
    ADD CONSTRAINT fk_conceptsubsystem_subsystemid_idx FOREIGN KEY (subsystemid) REFERENCES mydb.subsystem(subsystemid);


--
-- TOC entry 3550 (class 2606 OID 16540)
-- Name: concepttrllkup fk_concepttrl_conceptid; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.concepttrllkup
    ADD CONSTRAINT fk_concepttrl_conceptid FOREIGN KEY (conceptid) REFERENCES mydb.concept(conceptid);


--
-- TOC entry 3551 (class 2606 OID 16545)
-- Name: concepttrllkup fk_concepttrl_trlid; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.concepttrllkup
    ADD CONSTRAINT fk_concepttrl_trlid FOREIGN KEY (trlid) REFERENCES mydb.trladvancement(trlid);


--
-- TOC entry 3552 (class 2606 OID 16550)
-- Name: patentconceptlkup fk_patconcept_conceptid; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.patentconceptlkup
    ADD CONSTRAINT fk_patconcept_conceptid FOREIGN KEY (conceptid) REFERENCES mydb.concept(conceptid);


--
-- TOC entry 3553 (class 2606 OID 16555)
-- Name: patentconceptlkup fk_patconcept_patentid; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.patentconceptlkup
    ADD CONSTRAINT fk_patconcept_patentid FOREIGN KEY (patentid) REFERENCES mydb.patent(patentid);


--
-- TOC entry 3554 (class 2606 OID 16560)
-- Name: subsystemfunctionlkup fk_subsystem_functionid_idx; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.subsystemfunctionlkup
    ADD CONSTRAINT fk_subsystem_functionid_idx FOREIGN KEY (functionid) REFERENCES mydb.function(functionid);


--
-- TOC entry 3556 (class 2606 OID 16570)
-- Name: subsystemmodulelkup fk_subsystem_moduleid_idx; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.subsystemmodulelkup
    ADD CONSTRAINT fk_subsystem_moduleid_idx FOREIGN KEY (moduleid) REFERENCES mydb.module(moduleid);


--
-- TOC entry 3555 (class 2606 OID 16565)
-- Name: subsystemfunctionlkup fk_subsystem_subsystemid_idx; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.subsystemfunctionlkup
    ADD CONSTRAINT fk_subsystem_subsystemid_idx FOREIGN KEY (subsystemid) REFERENCES mydb.subsystem(subsystemid);


--
-- TOC entry 3557 (class 2606 OID 16575)
-- Name: subsystemmodulelkup fk_subsystem_subsystemid_idx; Type: FK CONSTRAINT; Schema: mydb; Owner: postgres
--

ALTER TABLE ONLY mydb.subsystemmodulelkup
    ADD CONSTRAINT fk_subsystem_subsystemid_idx FOREIGN KEY (subsystemid) REFERENCES mydb.subsystem(subsystemid);


-- Completed on 2023-12-19 13:11:37 CST

--
-- PostgreSQL database dump complete
--


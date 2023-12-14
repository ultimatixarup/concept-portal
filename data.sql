
DROP TABLE IF EXISTS "authorconceptlkup";
CREATE TABLE "mydb"."authorconceptlkup" (
    "employeeid" smallint NOT NULL,
    "conceptid" bigint NOT NULL,
    CONSTRAINT "authorconceptlkup_pkey" PRIMARY KEY ("employeeid", "conceptid")
) WITH (oids = false);
 
INSERT INTO "mydb"."authorconceptlkup" ("employeeid", "conceptid") VALUES
(1,	1),
(2,	2),
(3,	3),
(4,	4),
(4,	5),
(5,	6),
(6,	7),
(7,	8),
(5,	9),
(27,	52);
 
DROP TABLE IF EXISTS "businessimpact";
DROP SEQUENCE IF EXISTS businessimpact_businessimpactid_seq;
CREATE SEQUENCE businessimpact_businessimpactid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;
 
CREATE TABLE "mydb"."businessimpact" (
    "businessimpactid" integer DEFAULT nextval('businessimpact_businessimpactid_seq') NOT NULL,
    "conceptid" bigint NOT NULL,
    "businessimpactdescription" character varying(256) NOT NULL,
    CONSTRAINT "businessimpact_pkey" PRIMARY KEY ("businessimpactid")
) WITH (oids = false);
 
INSERT INTO "businessimpact" ("businessimpactid", "conceptid", "businessimpactdescription") VALUES
(1,	1,	'The advanced droplet dispensing system will improve manufacturing efficiency and accuracy in semiconductor fabrication.'),
(2,	2,	'Increased accuracy and throughput in lithography'),
(3,	3,	'Reduced false positives in defect detection'),
(4,	4,	'available'),
(10,	52,	'test');
 
DROP TABLE IF EXISTS "concept";
DROP SEQUENCE IF EXISTS concept_conceptid_seq;
CREATE SEQUENCE concept_conceptid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1;
 
CREATE TABLE "mydb"."concept" (
    "conceptid" bigint DEFAULT nextval('concept_conceptid_seq') NOT NULL,
    "title" character varying(256) NOT NULL,
    "status" character varying(64),
    "description" character varying(512),
    "inscope" smallint,
    "creationdate" date,
    "modificationdate" date,
    CONSTRAINT "conceptid_unique_idx" PRIMARY KEY ("conceptid")
) WITH (oids = false);
 
INSERT INTO "concept" ("conceptid", "title", "status", "description", "inscope", "creationdate", "modificationdate") VALUES
(5,	'EUV Gas Chamber Protection v.2',	NULL,	'Study on effects of mixed alloys',	NULL,	'2016-04-01',	NULL),
(6,	'EUV Gas Chamber Protection v.3',	NULL,	'Test hypothesis on effects of gas on certain alloys',	NULL,	'2016-07-01',	NULL),
(7,	'EUV Gas Chamber Protection v.4',	NULL,	'Analyze test results',	NULL,	'2017-01-01',	NULL),
(8,	'EUV Gas Chamber Protection v.5',	NULL,	'Modifications from findings',	NULL,	'2017-02-01',	NULL),
(9,	'EUV Gas Chamber Protection v.6',	NULL,	'Derive conclusion',	NULL,	'2018-01-01',	NULL),
(10,	'EUV Gas Chamber Protection v.7',	NULL,	'Final version of alloy',	NULL,	'2018-12-01',	NULL),
(11,	'Inert gas on cleaning collector v.1',	NULL,	'Radical helium and other inert gases for cleaning collector concept',	NULL,	'2022-04-01',	NULL),
(12,	'Inert gas cleaning for collector v.2',	NULL,	'Study on the effectiveness of certain gases to remove tin contamination',	NULL,	'2022-06-01',	NULL),
(13,	'Inert gas cleaning for collector v.3',	NULL,	'Testing the concept of gases on removing tin',	NULL,	'2022-08-01',	NULL),
(14,	'Inert gascleaning for collector v.4',	NULL,	'Conclusions on effectiveness of inert gases',	NULL,	'2023-01-01',	NULL),
(15,	'Nanostructured materials',	NULL,	'Nanostructured liners',	NULL,	'2023-06-06',	NULL),
(2,	'Extreme UV lithography',	'Completed',	'Developing a new light source for lithography',	1,	'2023-04-01',	NULL),
(3,	'Machine learning on optimizing dose target',	'In Progress',	'Using deep learning algorithms to optimizatin of dose target',	1,	'2023-04-01',	NULL),
(4,	'EUV Gas Chamber Protection',	'In Progress',	'Prevent corrosion of gas chambers',	0,	'2016-02-01',	NULL),
(1,	'Advanced Dispensing for PEZ',	'In Progress',	'Developing a precision dispenser for PEZ',	0,	'2023-04-01',	'2023-08-10'),
(52,	'test',	'Completed',	'test',	1,	'2023-08-17',	NULL);
 
DROP TABLE IF EXISTS "conceptmateriallkup";
CREATE TABLE "mydb"."conceptmateriallkup" (
    "conceptid" bigint NOT NULL,
    "materialid" integer NOT NULL
) WITH (oids = false);
 
INSERT INTO "conceptmateriallkup" ("conceptid", "materialid") VALUES
(1,	1),
(2,	2),
(2,	3),
(3,	4);
 
DROP TABLE IF EXISTS "conceptsubsystemlkup";
CREATE TABLE "mydb"."conceptsubsystemlkup" (
    "conceptid" bigint NOT NULL,
    "subsystemid" smallint NOT NULL
) WITH (oids = false);
 
INSERT INTO "conceptsubsystemlkup" ("conceptid", "subsystemid") VALUES
(1,	1),
(2,	2),
(3,	3),
(4,	4);
 
DROP TABLE IF EXISTS "concepttrllkup";
CREATE TABLE "mydb"."concepttrllkup" (
    "conceptid" bigint NOT NULL,
    "trlid" bigint NOT NULL,
    CONSTRAINT "concepttrllkup_pkey" PRIMARY KEY ("conceptid", "trlid")
) WITH (oids = false);
 
INSERT INTO "concepttrllkup" ("conceptid", "trlid") VALUES
(1,	1),
(1,	2),
(2,	3),
(3,	4),
(3,	5),
(4,	6),
(5,	7),
(6,	8),
(7,	9),
(8,	10),
(9,	11),
(10,	12),
(11,	13),
(12,	14),
(13,	15),
(14,	16);
 
DROP TABLE IF EXISTS "employee";
DROP SEQUENCE IF EXISTS employee_employeeid_seq;
CREATE SEQUENCE employee_employeeid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;
 
CREATE TABLE "mydb"."employee" (
    "employeeid" integer DEFAULT nextval('employee_employeeid_seq') NOT NULL,
    "name" character varying(128),
    "initial" character varying(5),
    CONSTRAINT "employee_pkey" PRIMARY KEY ("employeeid")
) WITH (oids = false);
 
INSERT INTO "employee" ("employeeid", "name", "initial") VALUES
(1,	'John Smith',	'JOSM'),
(2,	'Elvis Presley',	NULL),
(3,	'Alice Johnson',	NULL),
(4,	'Chung Lee',	'CHUN'),
(5,	'Jason Mason',	NULL),
(6,	'Christian Beil',	NULL),
(7,	'Mark Twain',	NULL),
(27,	'Michelle Samson',	'test');
 
DROP TABLE IF EXISTS "function";
DROP SEQUENCE IF EXISTS function_functionid_seq;
CREATE SEQUENCE function_functionid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;
 
CREATE TABLE "mydb"."function" (
    "functionid" smallint DEFAULT nextval('function_functionid_seq') NOT NULL,
    "functionname" character varying(128) NOT NULL,
    "systemfunction" character varying(128) NOT NULL,
    "functionalgroup" character varying(128) NOT NULL,
    CONSTRAINT "function_pkey" PRIMARY KEY ("functionid"),
    CONSTRAINT "functionid_unique_idx" UNIQUE ("functionid")
) WITH (oids = false);
 
INSERT INTO "function" ("functionid", "functionname", "systemfunction", "functionalgroup") VALUES
(1,	'Droplet Generation',	'Droplet Generation and Positioning',	'EUV'),
(2,	'Droplet Steering',	'Droplet Generation and Positioning',	'EUV'),
(3,	'Droplet Catching',	'Droplet Generation and Positioning',	'EUV'),
(4,	'Plasma Generation and Control',	'Plasma Control',	'EUV'),
(5,	'Energy Control',	'Plasma Control',	'EUV'),
(6,	'Opt Focussed',	'EUV Collection',	'EUV'),
(7,	'Spectral Purification',	'EUV Collection',	'EUV'),
(8,	'Tin Capture',	'Tin Mitigation',	'EUV'),
(9,	'Tin Tin Removal',	'Tin Mitigation',	'EUV'),
(10,	'Tin and Gas Transport',	'Tin Mitigation',	'EUV'),
(11,	'FC-033',	'M',	'EUV'),
(12,	'FC-019',	'M',	'EUV'),
(13,	'FC-020',	'M',	'EUV'),
(14,	'FC-021',	'E',	'EUV'),
(15,	'FC-022',	'E',	'EUV'),
(16,	'FC-014',	'EC',	'EUV'),
(17,	'FC-057',	'EC',	'EUV');
 
DROP TABLE IF EXISTS "module";
DROP SEQUENCE IF EXISTS module_moduleid_seq;
CREATE SEQUENCE module_moduleid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;
 
CREATE TABLE "mydb"."module" (
    "moduleid" smallint DEFAULT nextval('module_moduleid_seq') NOT NULL,
    "modulename" character varying(128) NOT NULL,
    CONSTRAINT "module_pkey" PRIMARY KEY ("moduleid"),
    CONSTRAINT "moduleid_unique_idx" UNIQUE ("moduleid")
) WITH (oids = false);
 
INSERT INTO "module" ("moduleid", "modulename") VALUES
(1,	'Droplet Generator'),
(2,	'Tin Supply System'),
(3,	'Ar booster and controller, RVS'),
(4,	'TEM'),
(5,	'DG Steering System'),
(6,	'Tin Catch'),
(7,	'Tin Catch Heater'),
(8,	'Real Time MP/PP Triggering Controls'),
(9,	'Mke First Light, Speedometer, SLRD'),
(10,	'BLM, DIM/DD, DFC'),
(11,	'Energy Controller EUV-Sensors'),
(12,	'Collector, Collector Assembly'),
(13,	'Plasma Position Camera'),
(14,	'IF Cap'),
(15,	'Vanes ind tin vanes Temperature Control'),
(16,	'Heated Tin Bucket'),
(17,	'Horizontal Obscuration, Lower Cone'),
(18,	'MECL'),
(19,	'COCL'),
(20,	'HP-RGA'),
(21,	'Collecter and Metrology Gas Delivery System'),
(22,	'Shroud'),
(23,	'Vessel, SSF ind Railset, QCM'),
(24,	'Packaging, Transport Tools, Service Tools'),
(25,	'Mechanical System Layout, no hw'),
(26,	'Connector Plates'),
(27,	'Mains Supply Units'),
(28,	'Heat Load Distribution Specification'),
(29,	'F&T Cabs');
 
DROP TABLE IF EXISTS "patent";
DROP SEQUENCE IF EXISTS patent_patentid_seq;
CREATE SEQUENCE patent_patentid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;
 
CREATE TABLE "mydb"."patent" (
    "patentid" integer DEFAULT nextval('patent_patentid_seq') NOT NULL,
    "fileddate" date,
    "patenteddate" date,
    "patentdescription" character varying(256),
    "idfsubmissiondate" date,
    "idfstatus" character varying(50),
    "author" character varying(180),
    CONSTRAINT "patent_pkey" PRIMARY KEY ("patentid")
) WITH (oids = false);
 
INSERT INTO "patent" ("patentid", "fileddate", "patenteddate", "patentdescription", "idfsubmissiondate", "idfstatus", "author") VALUES
(2,	'2019-07-01',	'2021-07-01',	'A new light source for lithography',	NULL,	NULL,	NULL),
(3,	'2020-01-01',	'2022-01-01',	'A deep learning algorithm for dose target optimization',	NULL,	NULL,	NULL),
(4,	'2023-02-15',	'2023-07-20',	'This patent describes a deep learning algorithm capable of auto tuning dose target for optimal EUV performance.',	NULL,	NULL,	NULL),
(1,	'2023-07-10',	'2023-07-10',	'Patent for the advanced dispensing for PEZ',	'2023-08-10',	'filed',	'John Smith');
 
DROP TABLE IF EXISTS "patentconceptlkup";
CREATE TABLE "mydb"."patentconceptlkup" (
    "patentid" integer NOT NULL,
    "conceptid" bigint NOT NULL,
    CONSTRAINT "patentconceptlkup_pkey" PRIMARY KEY ("patentid", "conceptid")
) WITH (oids = false);
 
INSERT INTO "patentconceptlkup" ("patentid", "conceptid") VALUES
(1,	1),
(2,	2),
(3,	3),
(4,	3);
 
DROP TABLE IF EXISTS "subsystem";
DROP SEQUENCE IF EXISTS subsystem_subsystemid_seq;
CREATE SEQUENCE subsystem_subsystemid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;
 
CREATE TABLE "mydb"."subsystem" (
    "subsystemid" smallint DEFAULT nextval('subsystem_subsystemid_seq') NOT NULL,
    "subsystemname" character varying(128) NOT NULL,
    CONSTRAINT "subsystem_pkey" PRIMARY KEY ("subsystemid"),
    CONSTRAINT "subsystemid_unique_idx" UNIQUE ("subsystemid")
) WITH (oids = false);
 
INSERT INTO "subsystem" ("subsystemid", "subsystemname") VALUES
(1,	'Droplet System'),
(2,	'Plasma Control'),
(3,	'Vessel Subassy'),
(4,	'Misc.');
 
DROP TABLE IF EXISTS "subsystemfunctionlkup";
CREATE TABLE "mydb"."subsystemfunctionlkup" (
    "subsystemid" smallint NOT NULL,
    "functionid" smallint NOT NULL
) WITH (oids = false);
 
INSERT INTO "subsystemfunctionlkup" ("subsystemid", "functionid") VALUES
(1,	1),
(1,	2),
(1,	3),
(2,	4),
(2,	5),
(3,	6),
(3,	7),
(3,	8),
(3,	9),
(3,	10),
(3,	11),
(4,	12),
(4,	13),
(4,	14),
(4,	15),
(4,	16),
(4,	17);
 
DROP TABLE IF EXISTS "subsystemmodulelkup";
CREATE TABLE "mydb"."subsystemmodulelkup" (
    "subsystemid" smallint NOT NULL,
    "moduleid" smallint NOT NULL
) WITH (oids = false);
 
INSERT INTO "subsystemmodulelkup" ("subsystemid", "moduleid") VALUES
(1,	1),
(1,	2),
(1,	3),
(2,	4),
(1,	5),
(1,	6),
(1,	7),
(2,	8),
(2,	9),
(2,	10),
(2,	11),
(3,	12),
(3,	13),
(3,	14),
(3,	15),
(3,	16),
(3,	17),
(3,	18),
(3,	19),
(3,	20),
(3,	21),
(3,	22),
(3,	23),
(4,	24),
(4,	25),
(4,	26),
(4,	27),
(4,	28),
(4,	29);
 
DROP TABLE IF EXISTS "supportmaterial";
DROP SEQUENCE IF EXISTS supportmaterial_supportmaterialid_seq;
CREATE SEQUENCE supportmaterial_supportmaterialid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 2147483647 CACHE 1;
 
CREATE TABLE "mydb"."supportmaterial" (
    "supportmaterialid" integer DEFAULT nextval('supportmaterial_supportmaterialid_seq') NOT NULL,
    "supportmaterialtitle" character varying(256) NOT NULL,
    "type" character varying(64) NOT NULL,
    "location" character varying(128) NOT NULL,
    CONSTRAINT "supportmaterial_pkey" PRIMARY KEY ("supportmaterialid")
) WITH (oids = false);
 
INSERT INTO "supportmaterial" ("supportmaterialid", "supportmaterialtitle", "type", "location") VALUES
(1,	'Droplet Dispensing System Overview',	'Presentation',	'https://example.com/presentation.pptx'),
(2,	'EUV Lithography Research',	'Document',	'https://example.com/doc1.pdf'),
(3,	'Understanding Extreme UV Lithography',	'ebook',	'https://example.com/doc2.pdf'),
(4,	'Deep Learning Research',	'Document',	'https://example.com/doc3.pdf');
 
DROP TABLE IF EXISTS "trladvancement";
DROP SEQUENCE IF EXISTS trladvancement_trlid_seq;
CREATE SEQUENCE trladvancement_trlid_seq INCREMENT 1 MINVALUE 1 MAXVALUE 9223372036854775807 CACHE 1;
 
CREATE TABLE "mydb"."trladvancement" (
    "trlid" bigint DEFAULT nextval('trladvancement_trlid_seq') NOT NULL,
    "trltitle" character varying(256),
    "activitydate" date,
    "trldescription" character varying(512),
    CONSTRAINT "trlid_unique" PRIMARY KEY ("trlid")
) WITH (oids = false);
 
INSERT INTO "trladvancement" ("trlid", "trltitle", "activitydate", "trldescription") VALUES
(1,	'TRL 2',	'2023-07-10',	'Researching a functional prototype for the droplet dispensing system.'),
(2,	'TRL 5',	'2023-07-27',	'test'),
(3,	'TRL 1',	'2023-01-01',	'Understanding of basic principles'),
(4,	'TRL 2',	'2023-01-10',	'Conceptualization of technology'),
(5,	'TRL 5',	'2023-01-10',	'Research of technology'),
(6,	'TRL 1',	NULL,	NULL),
(7,	'TRL 1',	NULL,	NULL),
(8,	'TRL 2',	NULL,	NULL),
(9,	'TRL 2',	NULL,	NULL),
(10,	'TRL 2',	NULL,	NULL),
(11,	'TRL 2',	NULL,	NULL),
(12,	'TRL 3',	NULL,	NULL),
(13,	'TRL 1',	NULL,	NULL),
(14,	'TRL 2',	NULL,	NULL),
(15,	'TRL 3',	NULL,	NULL),
(16,	'TRL 4',	NULL,	NULL);
 
ALTER TABLE ONLY "mydb"."authorconceptlkup" ADD CONSTRAINT "fk_authorconcept_idx" FOREIGN KEY (conceptid) REFERENCES concept(conceptid) NOT DEFERRABLE;
ALTER TABLE ONLY "mydb"."authorconceptlkup" ADD CONSTRAINT "fk_conceptauthor_idx" FOREIGN KEY (employeeid) REFERENCES employee(employeeid) NOT DEFERRABLE;
 
ALTER TABLE ONLY "mydb"."businessimpact" ADD CONSTRAINT "fk_busimpact_concept_conceptid" FOREIGN KEY (conceptid) REFERENCES concept(conceptid) NOT DEFERRABLE;
 
ALTER TABLE ONLY "mydb"."conceptmateriallkup" ADD CONSTRAINT "fk_conceptmaterial_conceptid" FOREIGN KEY (conceptid) REFERENCES concept(conceptid) NOT DEFERRABLE;
ALTER TABLE ONLY "mydb"."conceptmateriallkup" ADD CONSTRAINT "fk_conceptmaterial_materialid" FOREIGN KEY (materialid) REFERENCES supportmaterial(supportmaterialid) NOT DEFERRABLE;
 
ALTER TABLE ONLY "mydb"."conceptsubsystemlkup" ADD CONSTRAINT "fk_conceptsubsystem_conceptid_idx" FOREIGN KEY (conceptid) REFERENCES concept(conceptid) NOT DEFERRABLE;
ALTER TABLE ONLY "mydb"."conceptsubsystemlkup" ADD CONSTRAINT "fk_conceptsubsystem_subsystemid_idx" FOREIGN KEY (subsystemid) REFERENCES subsystem(subsystemid) NOT DEFERRABLE;
 
ALTER TABLE ONLY "mydb"."concepttrllkup" ADD CONSTRAINT "fk_concepttrl_conceptid" FOREIGN KEY (conceptid) REFERENCES concept(conceptid) NOT DEFERRABLE;
ALTER TABLE ONLY "mydb"."concepttrllkup" ADD CONSTRAINT "fk_concepttrl_trlid" FOREIGN KEY (trlid) REFERENCES trladvancement(trlid) NOT DEFERRABLE;
 
ALTER TABLE ONLY "mydb"."patentconceptlkup" ADD CONSTRAINT "fk_patconcept_conceptid" FOREIGN KEY (conceptid) REFERENCES concept(conceptid) NOT DEFERRABLE;
ALTER TABLE ONLY "mydb"."patentconceptlkup" ADD CONSTRAINT "fk_patconcept_patentid" FOREIGN KEY (patentid) REFERENCES patent(patentid) NOT DEFERRABLE;
 
ALTER TABLE ONLY "mydb"."subsystemfunctionlkup" ADD CONSTRAINT "fk_subsystem_functionid_idx" FOREIGN KEY (functionid) REFERENCES function(functionid) NOT DEFERRABLE;
ALTER TABLE ONLY "mydb"."subsystemfunctionlkup" ADD CONSTRAINT "fk_subsystem_subsystemid_idx" FOREIGN KEY (subsystemid) REFERENCES subsystem(subsystemid) NOT DEFERRABLE;
 
ALTER TABLE ONLY "mydb"."subsystemmodulelkup" ADD CONSTRAINT "fk_subsystem_moduleid_idx" FOREIGN KEY (moduleid) REFERENCES module(moduleid) NOT DEFERRABLE;
ALTER TABLE ONLY "mydb"."subsystemmodulelkup" ADD CONSTRAINT "fk_subsystem_subsystemid_idx" FOREIGN KEY (subsystemid) REFERENCES subsystem(subsystemid) NOT DEFERRABLE;
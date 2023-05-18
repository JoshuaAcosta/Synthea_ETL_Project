DROP TABLE IF EXISTS payers CASCADE;
CREATE TABLE payers (
  id UUID NOT NULL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "address" VARCHAR(255),
  city VARCHAR(255),
  state_headquartered VARCHAR(2),
  zip VARCHAR(10),
  phone VARCHAR(10),
  amount_covered NUMERIC NOT NULL,
  amount_uncovered NUMERIC NOT NULL,
  revenue NUMERIC NOT NULL,
  covered_encounters NUMERIC NOT NULL,
  uncovered_encounters NUMERIC NOT NULL,
  covered_medications NUMERIC NOT NULL,
  uncovered_medications NUMERIC NOT NULL,
  covered_procedures NUMERIC NOT NULL,
  uncovered_procedures NUMERIC NOT NULL,
  covered_immunizations NUMERIC NOT NULL,
  uncovered_immunizations NUMERIC NOT NULL,
  unique_customers NUMERIC NOT NULL,
  qols_avg NUMERIC NOT NULL,
  member_months NUMERIC NOT NULL
);

DROP TABLE IF EXISTS organizations CASCADE;
CREATE TABLE organizations (
  id UUID NOT NULL PRIMARY KEY,
  "name" VARCHAR(255) NOT NULL,
  "address" VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  "state" VARCHAR(2),
  zip VARCHAR(10),
  lat NUMERIC,
  lon NUMERIC,
  phone VARCHAR(10),
  revenue NUMERIC NOT NULL,
  utilization NUMERIC NOT NULL
);

DROP TABLE IF EXISTS providers CASCADE;
CREATE TABLE providers (
  id UUID NOT NULL PRIMARY KEY,
  organization UUID NOT NULL REFERENCES organizations(id),
  "name" VARCHAR(255) NOT NULL,
  gender VARCHAR(1) NOT NULL,
  speciality VARCHAR(255) NOT NULL,
  "address" VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  "state" VARCHAR(2),
  zip VARCHAR(10),
  lat NUMERIC,
  lon NUMERIC,
  utilization NUMERIC NOT NULL
);

DROP TABLE IF EXISTS patients CASCADE;
CREATE TABLE patients (
  id UUID NOT NULL PRIMARY KEY,
  birth_date DATE NOT NULL,
  death_date DATE,
  ssn VARCHAR(11) NOT NULL,
  drivers VARCHAR(15),
  passport VARCHAR(15),
  prefix VARCHAR(10),
  "first" VARCHAR(255) NOT NULL,
  "last" VARCHAR(255) NOT NULL,
  suffix VARCHAR(10),
  maiden VARCHAR(255),
  marital VARCHAR(1),
  race VARCHAR(255) NOT NULL,
  ethnicity VARCHAR(255) NOT NULL,
  gender VARCHAR(1) NOT NULL,
  birth_place VARCHAR(255) NOT NULL,
  "address" VARCHAR(255) NOT NULL,
  city VARCHAR(255) NOT NULL,
  "state" VARCHAR(2),
  county VARCHAR(255),
  zip VARCHAR(10),
  lat NUMERIC,
  lon NUMERIC,
  healthcare_expenses NUMERIC NOT NULL,
  healthcare_coverage NUMERIC NOT NULL,
  income NUMERIC NOT NULL
);

DROP TABLE IF EXISTS payer_transitions CASCADE;
CREATE TABLE payer_transitions (
  patient UUID NOT NULL REFERENCES patients(id),
  member_id UUID,
  start_year DATE NOT NULL,
  end_year DATE NOT NULL,
  payer UUID NOT NULL REFERENCES payers(id),
  secondary_payer UUID REFERENCES payers(id),
  "ownership" VARCHAR(255),
  owner_name VARCHAR(255)
);

DROP TABLE IF EXISTS encounters CASCADE;
CREATE TABLE encounters (
  id UUID NOT NULL PRIMARY KEY,
  "start" TIMESTAMP NOT NULL,
  "stop" TIMESTAMP,
  patient UUID NOT NULL REFERENCES patients(id),
  organization UUID NOT NULL REFERENCES organizations(id),
  "provider" UUID NOT NULL REFERENCES providers(id),
  payer UUID NOT NULL REFERENCES payers(id),
  encounter_class VARCHAR(255) NOT NULL,
  code VARCHAR(255) NOT NULL,
  "description" VARCHAR(255) NOT NULL,
  base_encounter_cost NUMERIC NOT NULL,
  total_claim_cost NUMERIC NOT NULL,
  payer_coverage NUMERIC NOT NULL,
  reason_code VARCHAR(255),
  reason_description VARCHAR(255)
);

DROP TABLE IF EXISTS conditions CASCADE;
CREATE TABLE conditions (
  "start" DATE NOT NULL,
  "stop" DATE,
  patient UUID NOT NULL REFERENCES patients(id),
  encounter UUID NOT NULL REFERENCES encounters(id),
  code VARCHAR(255) NOT NULL,
  description VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS devices CASCADE;
CREATE TABLE devices (
  "start" TIMESTAMP NOT NULL,
  "stop" TIMESTAMP,
  patient uuid NOT NULL REFERENCES patients(id),
  encounter uuid NOT NULL REFERENCES encounters(id),
  code VARCHAR(255) NOT NULL,
  "description" VARCHAR(255) NOT NULL,
  udi VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS imaging_studies CASCADE;
CREATE TABLE imaging_studies (
    id UUID NOT NULL,
    "date" TIMESTAMP WITH TIME ZONE NOT NULL,
    patient uuid NOT NULL REFERENCES patients(id),
    encounter uuid NOT NULL REFERENCES encounters(id),
    series_uid UUID NOT NULL,
    body_site_code VARCHAR(255) NOT NULL,
    body_site_descriptions VARCHAR(255) NOT NULL,
    modality_code VARCHAR(255) NOT NULL,
    modality_description VARCHAR(255) NOT NULL,
    instance_uid UUID NOT NULL,
    sop_code VARCHAR(255) NOT NULL,
    sop_description VARCHAR(255) NOT NULL,
    procedure_code VARCHAR(255) NOT NULL
);

DROP TABLE IF EXISTS immunizations CASCADE;
CREATE TABLE immunizations (
  "date" TIMESTAMP WITH TIME ZONE NOT NULL,
  patient UUID NOT NULL REFERENCES patients(id),
  encounter UUID NOT NULL REFERENCES encounters(id),
  code text NOT NULL,
  "description" text NOT NULL,
  cost numeric NOT NULL
);

DROP TABLE IF EXISTS medications CASCADE;
CREATE TABLE medications (
  "start" TIMESTAMP WITH TIME ZONE NOT NULL,
  "stop" TIMESTAMP WITH TIME ZONE,
  patient UUID NOT NULL REFERENCES patients(id),
  payer uuid NOT NULL REFERENCES payers(id),
  encounter uuid NOT NULL REFERENCES encounters(id),
  code text NOT NULL,
  "description" text NOT NULL,
  base_cost numeric NOT NULL,
  payer_coverage numeric NOT NULL,
  dispenses numeric NOT NULL,
  total_cost numeric NOT NULL,
  reason_code text,
  reason_description text
);

DROP TABLE IF EXISTS observations CASCADE;
CREATE TABLE observations (
  "date" TIMESTAMP WITH TIME ZONE NOT NULL,
  patient UUID NOT NULL REFERENCES patients(id),
  encounter UUID NOT NULL REFERENCES encounters(id),
  category text,
  code text NOT NULL,
  "description" text NOT NULL,
  "value" text NOT NULL,
  units text,
  "type" text NOT NULL
);

DROP TABLE IF EXISTS procedures CASCADE;
CREATE TABLE procedures (
  "start" timestamp with time zone NOT NULL,
  "stop" timestamp with time zone,
  patient UUID NOT NULL REFERENCES patients(id),
  encounter UUID NOT NULL REFERENCES encounters(id),
  code text NOT NULL,
  "description" text NOT NULL,
  base_cost numeric NOT NULL,
  reason_code text,
  reason_description text
);

DROP TABLE IF EXISTS supplies CASCADE;
CREATE TABLE supplies (
  "date" DATE NOT NULL,
  patient UUID NOT NULL REFERENCES patients(id),
  encounter UUID NOT NULL REFERENCES encounters(id),
  code text NOT NULL,
  "description" text NOT NULL,
  quantity numeric NOT NULL
);

DROP TABLE IF EXISTS allergies CASCADE;
CREATE TABLE allergies (
  "start" DATE NOT NULL,
  "stop" DATE,
  patient UUID NOT NULL REFERENCES patients(id),
  encounter UUID NOT NULL REFERENCES encounters(id),
  code text NOT NULL,
  "system" text NOT NULL,
  "description" text NOT NULL,
  "type" text,
  category text,
  reaction1 text,
  description1 text,
  severity1 text,
  reaction2 text,
  description2 text,
  severity2 text
);

DROP TABLE IF EXISTS careplans CASCADE;
CREATE TABLE careplans (
  id UUID NOT NULL PRIMARY KEY,
  "start" date NOT NULL,
  "stop" date,
  patient UUID NOT NULL REFERENCES patients(id),
  encounter UUID NOT NULL REFERENCES encounters(id),
  code text NOT NULL,
  "description" text NOT NULL,
  reason_code text NOT NULL,
  reason_description text NOT NULL
);

DROP TABLE IF EXISTS claims CASCADE;
CREATE TABLE claims (
  id UUID NOT NULL PRIMARY KEY,
  patient_id UUID NOT NULL REFERENCES patients(id),
  provider_id UUID NOT NULL REFERENCES providers(id),
  primary_patient_insurance_id UUID REFERENCES payers(id),
  secondary_patient_insurance_id UUID REFERENCES payers(id),
  department_id numeric NOT NULL,
  patient_department_id numeric NOT NULL,
  diagnosis1 text,
  diagnosis2 text,
  diagnosis3 text,
  diagnosis4 text,
  diagnosis5 text,
  diagnosis6 text,
  diagnosis7 text,
  diagnosis8 text,
  referring_provider_id UUID,
  appointment_id UUID,
  current_illness_date timestamp with time zone NOT NULL,
  service_date timestamp with time zone NOT NULL,
  supervising_provider_id UUID,
  status1 text,
  status2 text,
  status_p text,
  outstanding1 numeric,
  outstanding2 numeric,
  outstanding_p numeric,
  last_billed_date1 timestamp with time zone,
  last_billed_date2 timestamp with time zone,
  last_billed_date_p timestamp with time zone,
  healthcare_claim_type_id1 numeric,
  healthcare_claim_type_id2 numeric
);

DROP TABLE IF EXISTS claims_transactions CASCADE;
CREATE TABLE claims_transactions (
  id UUID NOT NULL PRIMARY KEY,
  claim_id UUID NOT NULL REFERENCES claims(id),
  charge_id numeric NOT NULL,
  patient_id UUID NOT NULL REFERENCES patients(id),
  "type" text NOT NULL,
  amount numeric,
  method text,
  from_date timestamp with time zone,
  to_date timestamp with time zone,
  place_of_service UUID NOT NULL REFERENCES organizations(id),
  procedure_code text NOT NULL,
  modifier1 text,
  modifier2 text,
  diagnosis_ref1 numeric,
  diagnosis_ref2 numeric,
  diagnosis_ref3 numeric,
  diagnosis_ref4 numeric,
  units numeric,
  department_id numeric,
  notes text,
  unit_amount numeric,
  transfer_out_id numeric,
  transfer_type text,
  payments numeric,
  adjustments numeric,
  transfers numeric,
  outstanding numeric,
  appointment_id UUID REFERENCES encounters(id),
  line_note text,
  patient_insurance_id UUID REFERENCES payer_transitions(member_id),
  fee_schedule_id numeric,
  provider_id uuid NOT NULL REFERENCES providers(id),
  supervising_provider_id UUID REFERENCES providers(id)
);
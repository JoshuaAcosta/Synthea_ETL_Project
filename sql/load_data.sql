-- SQL commands to insert data from csv files into Postgres

COPY payers FROM '/data/payers.csv' DELIMITER ',' CSV HEADER;

COPY organizations FROM '/data/organizations.csv' DELIMITER ',' CSV HEADER;
 
COPY providers FROM '/data/providers.csv' DELIMITER ',' CSV HEADER;

COPY patients FROM '/data/patients.csv' DELIMITER ',' CSV HEADER;

COPY payer_transitions FROM '/data/payer_transitions.csv' DELIMITER ',' CSV HEADER;

COPY encounters FROM '/data/encounters.csv' DELIMITER ',' CSV HEADER;

COPY conditions FROM '/data/conditions.csv' DELIMITER ',' CSV HEADER;

COPY devices FROM '/data/devices.csv' DELIMITER ',' CSV HEADER;

COPY imaging_studies FROM '/data/imaging_studies.csv' DELIMITER ',' CSV HEADER;

COPY immunizations FROM '/data/immunizations.csv' DELIMITER ',' CSV HEADER;

COPY medications FROM '/data/medications.csv' DELIMITER ',' CSV HEADER;

COPY observations FROM '/data/observations.csv' DELIMITER ',' CSV HEADER;

COPY procedures FROM '/data/procedures.csv' DELIMITER ',' CSV HEADER;

COPY supplies FROM '/data/supplies.csv' DELIMITER ',' CSV HEADER;

COPY allergies FROM '/data/allergies.csv' DELIMITER ',' CSV HEADER;

COPY careplans FROM '/data/careplans.csv' DELIMITER ',' CSV HEADER;

COPY claims FROM '/data/claims.csv' DELIMITER ',' CSV HEADER;

COPY claims_transactions FROM '/data/claims_transactions.csv' DELIMITER ',' CSV HEADER;

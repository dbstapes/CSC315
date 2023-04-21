import psycopg2
import csv

conn = psycopg2.connect(database='cab12', 
                        user ='lion', password='lion',
                        host='127.0.0.1', port='5432'
)

#conn.autocommit = True
cursor = conn.cursor()

cursor.execute('''
DROP TABLE municipality_code CASCADE;
DROP TABLE municipality;
DROP TABLE energy_efficiency_programs;
DROP TABLE solar_installation_programs CASCADE;
DROP TABLE commercial_solar_customer;

CREATE TABLE municipality_code (
PRIMARY KEY (Municipality_index), Municipality_index int,
Municipality_name varchar,
County varchar);

CREATE TABLE municipality (
Residential_electricity int,
Commercial_electricity int,
Industrial_electricity int,
Street_light_electricity int,
Residential_gas int,
Commercial_gas int,
Industrial_gas int,
Street_light_gas int,
Gas_utility varchar,
Electric_utility varchar, 
County varchar, 
Year int, Municipality_index int,
PRIMARY KEY (Municipality_index, Year),
FOREIGN KEY (Municipality_index) REFERENCES municipality_code (Municipality_index)
MATCH FULL );

CREATE TABLE energy_efficiency_programs (
Municipality_index int,
Num_CI_taxed_parcels int,
Total_completed_projects int,
current_lifetime_rate float,
Num_projects_needed int,
PRIMARY KEY (Municipality_index),
FOREIGN KEY (Municipality_index) REFERENCES municipality_code (Municipality_index)
MATCH FULL );

CREATE TABLE solar_installation_programs (
Application_number text,
Municipality_index int,
Reg_status text,
Third_party_ownership varchar,
Program text, 
PTO_date date,
Calculated_system_size float,
Contractor text, 
Interconnection text,
Utility_name text,
PRIMARY KEY (Application_number),
FOREIGN KEY (Municipality_index) REFERENCES municipality_code (Municipality_index)
MATCH FULL );

CREATE TABLE commercial_solar_customer (
Application_number text,
Premise_company text,
premise_installation_address text,
PRIMARY KEY (Application_number),
FOREIGN KEY (Application_number) REFERENCES solar_installation_programs (Application_number)
MATCH FULL );''')

with open('Aggregate3.csv', 'r') as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
                cursor.execute('''
                INSERT INTO municipality_code ( 
                municipality_name, county, municipality_index) 
                VALUES (%s, %s, %s)
                ''', (row[0], row[1], int(row[17])))

with open('Aggregate5.csv', 'r') as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
                for i in [5,6,7,8,11,12,13,14]:
                        #print(row[i])
                        row[i] = 0 if row[i] == "NULL" else int(row[i])
                        #print(row[i])
                cursor.execute('''
                INSERT INTO municipality ( 
                residential_electricity, commercial_electricity,
                industrial_electricity, street_light_electricity, 
                residential_gas, commercial_gas, 
                industrial_gas, street_light_gas, 
                gas_utility, electric_utility, 
                county, year, 
                municipality_index)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ''', (row[5], row[6], row[7], 
                        row[8], row[11], row[12], 
                        row[13], row[14], row[10], 
                        row[4], row[1], int(row[3]), int(row[16])))

with open('EnergyEfficiency.csv', 'r') as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
                for i in [5]:
                        row[i] = 0 if row[i] =="" else int(row[i])
                cursor.execute('''
                INSERT INTO energy_efficiency_programs (
                Municipality_index, Num_CI_taxed_parcels,
                Total_completed_projects, current_lifetime_rate,
                Num_projects_needed)
                VALUES (%s, %s, %s, %s, %s)
                ''', (int(row[6]), int(row[2]), int(row[3]), float(row[7]),
                        row[5]))

with open('SolarInstallations.csv', 'r') as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
                cursor.execute('''
                INSERT INTO solar_installation_programs (
                Application_number, Program, PTO_date,
                Calculated_system_size, Interconnection,
                Third_party_ownership, Contractor, Utility_name,
                Reg_status, Municipality_index) 
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                ''', (row[0], row[1], row[7], float(row[8]), row[10], row[11],
                         row[12], row[13], row[14], int(row[15])))

with open('Commercial_solar_customer_data.csv', 'r') as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
                cursor.execute('''
                INSERT INTO commercial_solar_customer(
                Application_number, Premise_company,
                premise_installation_address)
                VALUES (%s, %s, %s)
                ''', (row[0], row[2], row[3]))

#cursor.execute(''' updateMunicipality.sql ''')
cursor.execute('''
        UPDATE municipality SET residential_electricity=NULL WHERE residential_electricity=0;
        UPDATE municipality SET commercial_electricity=NULL WHERE commercial_electricity=0;
        UPDATE municipality SET industrial_electricity=NULL WHERE industrial_electricity=0;
        UPDATE municipality SET street_light_electricity=NULL WHERE street_light_electricity=0;

        UPDATE municipality SET residential_gas=NULL WHERE residential_gas=0;
        UPDATE municipality SET commercial_gas=NULL WHERE commercial_gas=0;
        UPDATE municipality SET industrial_gas=NULL WHERE industrial_gas=0;
        UPDATE municipality SET street_light_gas=NULL WHERE street_light_gas=0; ''')


conn.commit()
conn.close()

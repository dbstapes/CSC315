import psycopg2
import csv

conn = psycopg2.connect(database='cab12', 
                        user ='lion', password='lion',
                        host='127.0.0.1', port='5432'
)

#conn.autocommit = True
cursor = conn.cursor()

with open('Aggregate3.csv', 'r') as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
                cursor.execute('''
                INSERT INTO municipality_code ( 
                municipality_name, county, municipality_index) 
                VALUES (%s, %s, %s)
                ''', (row[0], row[1], row[17]))

with open('Aggregate3.csv', 'r') as f:
        reader = csv.reader(f)
        next(reader)
        for row in reader:
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
                ''', (row[5], row[6], row[7], row[8], row[11], row[12], 
                        row[13], row[14], row[10], row[4], row[1], row[3], row[17]))


conn.commit()
conn.close()
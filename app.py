import psycopg2
from config import config
from flask import Flask, render_template, request

# Connect to the PostgreSQL database server
def connect(query):
    conn = None
    rows = ''
    try:
        # read connection parameters
        params = config()
 
        # connect to the PostgreSQL server
        print('Connecting to the %s database...' % (params['database']))
        conn = psycopg2.connect(**params)
        print('Connected.')
      
        # create a cursor
        cur = conn.cursor()
        
        # execute a query using fetchall()
        cur.execute(query)
        rows = cur.fetchall()

        # close the communication with the PostgreSQL
        cur.close()
    except (Exception, psycopg2.DatabaseError) as error:
        print(error)
    finally:
        if conn is not None:
            conn.close()
            print('Database connection closed.')
    # return the query result from fetchall()
    return rows

 
# app.py
app = Flask(__name__)


# serve form web page
@app.route("/")
def form():
    return render_template('my-form.html')

# handle solar programs POST and serve result web page
@app.route('/solar_programs_handler', methods=['POST'])
def solar_programs_handler(): 
    rows = connect('CREATE VIEW mun_elec AS SELECT municipality_index, year, residential_electricity, commercial_electricity, industrial_electricity, street_light_electricity FROM municipality WHERE municipality.municipality_index = ' + request.form['municipality_index'] + '; UPDATE mun_elec SET residential_electricity=0 WHERE residential_electricity IS NULL; UPDATE mun_elec SET commercial_electricity=0 WHERE commercial_electricity IS NULL; UPDATE mun_elec SET industrial_electricity=0 WHERE industrial_electricity IS NULL; UPDATE mun_elec SET street_light_electricity=0 WHERE street_light_electricity IS NULL; SELECT m.year, mc.municipality_name, mc.county, count(s.application_number), (m.residential_electricity + m.commercial_electricity + m.industrial_electricity + m.street_light_electricity) FROM solar_installation_programs s, municipality_code mc, mun_elec m WHERE EXTRACT(year FROM s.pto_date) < m.year+1 AND s.municipality_index = ' + request.form['municipality_index'] + ' AND mc.municipality_index = ' + request.form['municipality_index'] + ' AND m.municipality_index = ' + request.form['municipality_index'] + ' GROUP BY m.year, mc.municipality_name, mc.county, m.residential_electricity, m.commercial_electricity, m.street_light_electricity, m.industrial_electricity ORDER BY m.year;')
    heads = ['Year', 'Municipality', 'County', 'Number of Solar Installations', 'Total Electricity Usage (kWh)']
    return render_template('my-result.html', rows=rows, heads=heads)

# handle energy efficiency program POST and serve result web page
@app.route ('/ee_handler', methods=['POST'])
def ee_handler():
    rows = connect('SELECT mc.municipality_index, mc.municipality_name, mc.county, e.total_completed_projects, g.total_co2 FROM municipality_code mc, energy_efficiency_programs e, ghg_emissions g WHERE e.municipality_index = mc.municipality_index AND g.municipality_index = mc.municipality_index AND g.year =2020;')
    heads = ['Municipality Index', 'Municipality', 'County', 'Number of Completed EE Projects', 'GHG Emissions (MTCO2e)']
    return render_template('my-result.html', rows=rows, heads=heads)

# handle municipality POST and serve result web page
@app.route ('/municipality_handler', methods=['POST'])
def municipality_handler():
    rows = connect('SELECT * FROM municipality_code WHERE municipality_name ILIKE \'%' + request.form['municipality_name'] + '%\';')
    heads = ['Municipality Index', 'Municipality', 'County']
    return render_template('my-result.html', rows=rows, heads=heads)

# handle query POST and serve result web page
@app.route('/query-handler', methods=['POST'])
def query_handler():
    rows = connect(request.form['query'])
    return render_template('my-result.html', rows=rows)

if __name__ == '__main__':
    app.run(debug = True)



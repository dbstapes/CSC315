import psycopg2
from config import config
from flask import Flask, render_template, request

# Connect to the PostgreSQL database server
'''def connect(query):
    conn = None
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
'''
 
# app.py
app = Flask(__name__)


# serve form web page
@app.route("/")
def form():
    return render_template('my-form.html')
'''
# handle venue POST and serve result web page
@app.route('/venue-handler', methods=['POST'])
def venue_handler():
    rows = connect('SELECT venue_id, title FROM events WHERE venue_id = ' + request.form['venue_id'] + ';')
    heads = ['venue_id', 'title']
    return render_template('my-result.html', rows=rows, heads=heads)

# handle query POST and serve result web page
@app.route('/query-handler', methods=['POST'])
def query_handler():
    rows = connect(request.form['query'])
    return render_template('my-result.html', rows=rows)
'''
if __name__ == '__main__':
    app.run(debug = True)

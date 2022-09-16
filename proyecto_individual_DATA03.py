from fastapi import FastAPI
import pymysql

app = FastAPI()
@app.get("/Pregunta 1") #localhost:8000
def read_root():
    conexion = pymysql.connect (host='localhost', database='proyecto', user ='Pia', password='Pixsiempre1')
    cursor = conexion.cursor()
    cursor.execute("SELECT  Year FROM races GROUP BY YEAR ORDER BY COUNT(*) DESC LIMIT 1;")
    for year in cursor:
        print ("Anio con mas carreras", year[0])
    return ("Anio con mas carreras", year[0])

@app.get("/Pregunta 2") #localhost:8000
def read_root():
    conexion = pymysql.connect (host='localhost', database='proyecto', user ='Pia', password='Pixsiempre1')
    cursor = conexion.cursor()
    cursor.execute("SELECT forename, surname FROM drivers where driverId= (SELECT   driverId FROM results where position=1 GROUP BY driverId ORDER BY COUNT(*) DESC LIMIT 1);")
    for forename, surname in cursor:
        print ("Piloto con mayor cantidad de primeros puestos:", forename, surname)
    return ("Piloto con mayor cantidad de primeros puestos:", forename, surname)

@app.get("/Pregunta 3") #localhost:8000
def read_root():
    conexion = pymysql.connect (host='localhost', database='proyecto', user ='Pia', password='Pixsiempre1')
    cursor = conexion.cursor()
    cursor.execute("SELECT name FROM races where circuitId= (SELECT  circuitId FROM races GROUP BY circuitId ORDER BY COUNT(*) DESC LIMIT 1)LIMIT 1;")
    for name in cursor:
        print ("Nombre del circuito más corrido:", name[0])
    return ("Nombre del circuito más corrido:", name[0])

@app.get("/Pregunta 4") #localhost:8000
def read_root():
    conexion = pymysql.connect (host='localhost', database='proyecto', user ='Pia', password='Pixsiempre1')
    cursor = conexion.cursor()
    cursor.execute("SELECT forename, surname FROM drivers where driverId=(SELECT  driverId FROM results WHERE constructorId in (SELECT constructorId FROM constructors where nationality='British' or 'American') GROUP BY driverId ORDER BY SUM(points) DESC LIMIT 1);")
    for forename, surname in cursor:
        print ("Piloto con mayor cantidad de puntos en total, cuyo constructor sea de nacionalidad sea American o British:", forename, surname)
    return ("Piloto con mayor cantidad de puntos en total, cuyo constructor sea de nacionalidad sea American o British:", forename, surname)
from flask import Flask, render_template, request
from pymongo import MongoClient
from beebotte import *
import sys

app = Flask(__name__)

db_client = MongoClient()
#db = client.example # Ejemplo de base de datos local
db = db_client.localbbdd  # Ejemplo de base de datos local
collection = db.store # Coleccion donde se almacenan los datos recogidos

_accesskey = "p0SNk57KZfEuxGl3arBNTPca"
_secretkey = "KcP2X0JduoEuKiyaeWpLWnA82AwhXtvn"

bbt = BBT(_accesskey, _secretkey)


flag_DB = True #Flag de control para el acceso a las dos base de datos

def findThreshold(threshold):
    N = collection.count()
    data = collection.find({}, {'_id':False}).limit(N)

    count = 0
    resultado = []
    for element in data:

        if float(element.get("Clics")) > float(threshold):
            count = count + 1
            resultado.append(element)
    lenlist = len(resultado)
    if lenlist > 10:
        resultado = resultado[(lenlist-10):lenlist]
    else:
        resultado = resultado


    if resultado == None:
        return "Vacio"
    else:
        return resultado


def computeValor_medio():
    global flag_DB

    if flag_DB:
        N = collection.count()
        data = collection.find({}, {'_id': False}).limit(N)

        numClics = []
        for element in data:
            var = element.get("Clics")
            numClics.append(float(var))

        valor_medio = sum(numClics)/len(numClics)
        flag_DB = not flag_DB

        return valor_medio

    else:
        clics = bbt.read("PracticaCompu", "Clics", limit=200)
        numClics = [float(clics[i]["data"]) for i in range(len(clics))]

        valor_medio = sum(numClics)/len(numClics)
        flag_DB = not flag_DB

        return valor_medio


@app.route("/", methods=["GET"])
def home_get():
    N = collection.count()  # Se recogen el numero de elementos que hay en nuestra base de datos local
    data = collection.find().limit(N)  # Se almacenan los datos guardados en una variable
    lastOne = data[N - 1]  # Se recogen los datos del ultimo documento insertado en la coleccion

    date = lastOne.get("Date")
    num_clics = lastOne.get("Clics")
    num_meneo = lastOne.get("Meneos")
    title = lastOne.get("Title")

    return render_template("index.html", date=date, clics=num_clics, meneos=num_meneo, title=title)


@app.route("/", methods=["POST"])
def home_post():
    threshold_value = request.form["umbral"]
    result = findThreshold(threshold_value)

    return render_template("index.html", dataTable=result)

@app.route("/index.html", methods=["POST"])
def index_post():
    threshold_value = request.form["umbral"]
    result = findThreshold(threshold_value)

    return render_template("index.html", dataTable=result)


@app.route("/index.html", methods=["GET"])
def home_return():
    N = collection.count()  # Se recogen el numero de elementos que hay en nuestra base de datos local
    data = collection.find().limit(N)  # Se almacenan los datos guardados en una variable
    lastOne = data[N - 1]  # Se recogen los datos del ultimo documento insertado en la coleccion

    date = lastOne.get("Date")
    num_clics = lastOne.get("Clics")
    num_meneo = lastOne.get("Meneos")
    title = lastOne.get("Title")

    return render_template("index.html", date=date, clics=num_clics, meneos=num_meneo, title=title)


@app.route("/valor_medio")
def valor_medio():
    global flag_DB
    valor = computeValor_medio()

    return render_template("index.html", valorClics = valor, bbdd_flag=flag_DB)

@app.route("/graficas")
def show_Dashboards():
    return render_template("grafica.html")


if __name__ == "__main__":
    reload(sys)
    sys.setdefaultencoding("utf-8")
    app.run(debug=True, host='0.0.0.0', port=5000)








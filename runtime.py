import requests
import re
import datetime
import sched, time
from pymongo import MongoClient
from beebotte import *


db_client = MongoClient()
db = db_client.example

_accesskey = "p0SNk57KZfEuxGl3arBNTPca"
_secretkey = "KcP2X0JduoEuKiyaeWpLWnA82AwhXtvn"

bbt = BBT(_accesskey, _secretkey)


def get_Data():

    now  =datetime.datetime.now()
    date_time = now.strftime("%Y-%m-%d %H:%M")
    response = requests.get("https://www.meneame.net")
    response = response.content

    result_new = re.search(r'<div class="news-summary"[^>]*>(.*?)<div class="news-summary"[^>]*>', response, flags=0)
    result_new = result_new.group()

    result_meneo = re.search(r'<a id=[^>]*>(.*?)<\/a[^>]*>', result_new)
    num_meneos = result_meneo.group(1)

    resul_clics = re.search(r'<div class="clics"[^>]*>(.*?)<\/div[^>]*>', result_new)
    num_clics = resul_clics.group(1)
    num_clics = num_clics.strip()
    num_clics = num_clics.strip(" ")
    num_clics = num_clics[0]
    #num_clics = float(num_clics[0])

    result_title_1 = re.search(r'<h2[^>]*>(.*?)<\/a[^>]*>', result_new)
    result_title_1 = result_title_1.group()
    result_title_2 = re.search(r'<a href[^>]*>(.*?)<\/a[^>]*>', result_title_1)
    tittle_new = result_title_2.group(1)
    tittle_new = tittle_new.strip()
    #tittle_new = float(tittle_new.strip())

    db.store.insert({"Date":date_time, "Title":tittle_new, "Clics":num_clics, "Meneos":num_meneos})
    bbt.write("PracticaCompu", "Titulo", tittle_new)
    bbt.write("PracticaCompu", "Meneos", num_meneos)
    bbt.write("PracticaCompu", "Clics", num_clics)
    bbt.write("PracticaCompu", "Date", date_time)

    print "Datos regidos:"
    print "Timestamp: " + date_time
    print "Numero de clics: " + num_clics
    print "Numero de meneos: " + num_meneos
    print "Titulo de la noticia: " + tittle_new

    s.enter(120, 1, get_Data, ())



s = sched.scheduler(time.time, time.sleep)
s.enter(120, 1, get_Data, ())
s.run()
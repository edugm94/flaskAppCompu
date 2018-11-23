# Practica Computación en Red. MUIT

Esta practica consiste en realizar una aplicación web que recoje datos de una Web externa y los almacena en una base de datos tanto local como en la nube.

# Uso

En este repositorio se pueden encontrar 4 items inicialmente:

* La carpeta static
* La carpera templates
* run.py
* runtime.py

A continuación, se indicará qué es cada uno de los items previamente mencionados.
La carpeta static contiene todo el contenido estático de la web: css, fuentes, js... etc. la capera templates, contiene las plantillas HTML para visualizar la aplicación web desarrollada.

### run.py

Este script contiene la lógica de la aplicación de nuestro servicio web. Definiendo la aplicación desarrollada en Flask. 

### runtime.py

Este script contiene la gestión de recursos de la aplicación web desarrollada. Realiza el proceso de obtención de datos de una web externa y almacenamiento de los mismos en una base de datos NO realación local y otra en la nube.

# Setup

Para el uso de esta aplicación:

* Bajar el repositorio
* Ejecutar el archivo runtime.py de la siguiente forma:
```bash
python runtime.py
``` 
* Ejecutar el archivo run.py de la siguiente forma:
```bash
python run.py
```
* Entrar al navegador con la IP de la maquina y el puerto 5000.

###Requisitos

Para el correcto funcionamiento de la aplicación, será necesario la instalación de: 

* python
* Flask
* mongo


#!/bin/bash


echo '														       	 '
echo  '   _____ ______   _______   ________   _______   ________  _____ ______   _______           ________  ________  ________'   
echo '   |\   _ \  _   \|\  ___ \ |\   ___  \|\  ___ \ |\   __  \|\   _ \  _   \|\  ___ \         |\   __  \|\   __  \|\   __  \'  
echo '    \ \  \\\__\ \  \ \   __/|\ \  \\ \  \ \   __/|\ \  \|\  \ \  \\\__\ \  \ \   __/|        \ \  \|\  \ \  \|\  \ \  \|\  \' 
echo '     \ \  \\|__| \  \ \  \_|/_\ \  \\ \  \ \  \_|/_\ \   __  \ \  \\|__| \  \ \  \_|/__       \ \   __  \ \   ____\ \   ____\'
echo '      \ \  \    \ \  \ \  \_|\ \ \  \\ \  \ \  \_|\ \ \  \ \  \ \  \    \ \  \ \  \_|\ \       \ \  \ \  \ \  \___|\ \  \___|'
echo '       \ \__\    \ \__\ \_______\ \__\\ \__\ \_______\ \__\ \__\ \__\    \ \__\ \_______\       \ \__\ \__\ \__\    \ \__\'   
echo '        \|__|     \|__|\|_______|\|__| \|__|\|_______|\|__|\|__|\|__|     \|__|\|_______|        \|__|\|__|\|__|     \|__|'  
echo '							                                                                     '	



echo "Empieza instalación de la aplicación  MeneameApp..."


cd ~ #acceder al home que es donde sera donde estara la aplicacion


####################### Obtencion del repositorio con la aplicacion ########################################


echo "--> Clonando repositorio..."
git clone https://github.com/edugm94/flaskAppCompu.git 2> log.txt 2> log.txt #Clonar el repositorio donde reside la aplicacion

if [ -d ~/flaskAppCompu ]
then 
	cd flaskAppCompu
else 
	echo " `date`: Error al clonar el repositorio" >> log.txt
	exit 1 #Se finaliza el script
fi 


##############################################################################################################

###############  Configuracion de los diferentes servicio para funcionamiento de la App ######################

#Instalar Python
echo "--> Preparando instalacion de paquetes..."

sudo apt update
sudo apt -y install python
sudo apt -y install python-pip

#Instalar paquetes de python necesarion

if [ $? -eq 0 ]
then
	echo "--> Correcta intalacion de Python y Pip..."
	echo "--> Instalando paquetes de Python necesarios..."
	pip install -r requirements.txt
fi



#Instalar mongodb

if [ $? -eq 0 ]
then
	echo "--> Preparando instalacion de mongoDB..."
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
	echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu xenial/mongodb-org/4.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
	sudo apt-get update
	sudo apt-get install -y mongodb-org
	sudo service mongod start
	if [ $? -eq 0 ]
	then
		echo "--> Se ha instalado correctamente mongoDB. Estado: running."
	fi
else
	echo " `date`: Error al instalar mongoDB" >> log.txt
	exit 1
fi




#Importar base de datos


echo "--> Importando base de datos local en mongoDB..."
mongoimport --db localbbdd --collection store --file meneame_localbbdd.json

if [ $? -eq 0 ]
then
	echo "--> Base de datos importada correctamente!"
else	
	echo " `date`: Error al importar base de datos" >> log.txt
	exit 1 
fi


####################################################################################################################################

######################################## Crear demonio que se ejecuta al arrancar la maquina #######################################



echo "--> Preparando demonio..."

cp ~/flaskAppCompu/plug_and_play.sh /etc/inid.t
sudo chown root:root /etc/init.d/plug_and_play.sh
if [ $? -eq 0 ]
then
	echo "--> Owner: Correcto!"
else
	echo " `date`: Error al hacer propietario al crear demonio" >> log.txt
	exit 1
fi	
sudo chmod 755 /etc/init.d/plug_and_play.sh
if [ $? -eq 0 ]
then
	echo "--> Permisos: Correcto!"
else
	echo " `date`: Error al dar permisos al crear demonio" >> log.txt
	exit 1 
fi
sudo update-rc.d /etc/init.d/plug_and_play.sh defaults
if [ $? -eq 0 ]
then
	echo "--> Demonio creado correctamente!"
else 
	echo " `date`: Error al crear demonio" >> log.txt
	exit 1
fi




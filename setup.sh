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
	echo " `date`: Error al clonar el repositorio"
	exit 1 #Se finaliza el script
fi 


##############################################################################################################

###############  Configuracion de los diferentes servicio para funcionamiento de la App ######################

#Instalar Python
#Instalar paquetes de python necesarion
#Instalar mongodb
#Importar base de datos


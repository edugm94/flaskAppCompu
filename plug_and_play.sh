#!/bin/bash


#Este script crea un demonio para que se ejecute cada vez que se inicie la maquina


sudo service mongod start #Inicia el servicio de mongDB
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT  #abre el puerto 80
sudo python ~/flaskAppCompu/run.py &  #ejecuta el script de la aplicacion
sudo python ~/flaskAppCompu/runtime.py  #ejecuta el script de la adquisicion de datos




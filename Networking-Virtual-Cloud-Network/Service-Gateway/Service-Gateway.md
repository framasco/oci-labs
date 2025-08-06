Guía para la Configuración de un Service Gateway en Oracle Services Network 🌐
Este instructivo te guiará a través de la configuración de un Service Gateway, una herramienta esencial para conectar tu red virtual (VCN) con los servicios de Oracle de manera segura y eficiente.
---
## Paso a paso

1. Crear VCN manualmente.  
   Este laboratorio asume que ya tenés una VCN creada manualmente.  
   Si necesitás crearla, podés seguir los pasos en el siguiente laboratorio:  
   ?? [Crear una VCN manualmente](../Create-a-VCN-Manually/Create-a-VCN-Manually.md)


2. Creación de una subred privada
En la VCN que creaste en el paso anterior, configura una subred privada.

   ![Paso 2](../screenshots/Service-Gateway/02-Service-Gateway.png)
   ![Paso 2](../screenshots/Service-Gateway/02B-Service-Gateway.png)

3. Configuración de un Service Gateway
Dentro de la misma VCN, crea un Service Gateway.

   ![Paso 3](../screenshots/Service-Gateway/03-Service-Gateway.png)
   ![Paso 3](../screenshots/Service-Gateway/03B-Service-Gateway.png)
   
4. Configuración de un NAT Gateway
Añade un NAT Gateway a tu VCN.
   
   ![Paso 4](../screenshots/Service-Gateway/04-Service-Gateway.png)   

5. Actualización de la tabla de rutas por defecto
Accede a la tabla de rutas por defecto (Route Table Default) de tu VCN y agrega una regla para enrutar el tráfico a través del NAT Gateway que creaste en el paso 4.
   
   ![Paso 5](../screenshots/Service-Gateway/05-Service-Gateway.png)
   ![Paso 5](../screenshots/Service-Gateway/05B-Service-Gateway.png)   
   
6. Creación de un Bucket en Object Storage
Procede a crear un Bucket en el servicio de Object Storage.

   ![Paso 6](../screenshots/Service-Gateway/06-Service-Gateway.png)
   ![Paso 6](../screenshots/Service-Gateway/06B-Service-Gateway.png)   
   
7- Creación de una instancia
Crea una nueva instancia asociándola al Service Gateway que configuraste en el paso 3.

   ![Paso 7](../screenshots/Service-Gateway/07-Service-Gateway.png)
   ![Paso 7](../screenshots/Service-Gateway/07B-Service-Gateway.png)
   ![Paso 7](../screenshots/Service-Gateway/07C-Service-Gateway.png)
   ![Paso 7](../screenshots/Service-Gateway/07D-Service-Gateway.png)
   ![Paso 7](../screenshots/Service-Gateway/07E-Service-Gateway.png)
   ![Paso 7](../screenshots/Service-Gateway/07F-Service-Gateway.png)   
   ![Paso 7](../screenshots/Service-Gateway/07H-Service-Gateway.png)      
   
8- Creación de una definición de red privada
Configura una Private Network definition list.

   ![Paso 8](../screenshots/Service-Gateway/08-Service-Gateway.png)
   ![Paso 8](../screenshots/Service-Gateway/08B-Service-Gateway.png)
   ![Paso 8](../screenshots/Service-Gateway/08C-Service-Gateway.png)   
   
9- Conexión a la instancia vía SSH
Una vez que la conexión esté establecida, conéctate a la instancia utilizando SSH a través de su IP privada.

   ![Paso 9](../screenshots/Service-Gateway/09-Service-Gateway.png)
   
10- instalar CLI de OCI Configurarlo.
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)"

   ![Paso 10](../screenshots/Service-Gateway/10-Service-Gateway.png)
   ![Paso 10](../screenshots/Service-Gateway/10B-Service-Gateway.png)
   ![Paso 10](../screenshots/Service-Gateway/10C-Service-Gateway.png)
   ![Paso 10](../screenshots/Service-Gateway/10D-Service-Gateway.png)
   ![Paso 10](../screenshots/Service-Gateway/10E-Service-Gateway.png)
   
11- Interactuar con el Bucket desde la instancia.


Eliminamos la entrada del NAT en el Route Table Default.
   ![Paso 11](../screenshots/Service-Gateway/11-Service-Gateway.png)  

Agregamos el SGW (Service Gateway) al Route Table Default.
   ![Paso 11](../screenshots/Service-Gateway/11B-Service-Gateway.png)  

Creamos un archivo text.txt desde la instancia en el Bucket creado en el punto 6.
oci os object put --bucket-name DemoBucket --file text.txt
   ![Paso 11](../screenshots/Service-Gateway/11C-Service-Gateway.png)     
   ![Paso 11](../screenshots/Service-Gateway/11D-Service-Gateway.png)

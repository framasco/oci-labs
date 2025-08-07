Guía para la Configuración de un Network-Security-Group.
Este instructivo te guiará a través de la configuración de un Network-Security-Group
---
## Paso a paso

1. Crear VCN manualmente.  
   Este laboratorio asume que ya tenés una VCN creada manualmente.  
   Si necesitás crearla, podés seguir los pasos en el siguiente laboratorio:  
   [Crear una VCN manualmente](../Create-a-VCN-Manually/Create-a-VCN-Manually.md)


2. Creación de una subred pública
Dentro de la VCN que creaste en el paso anterior, configura una subred pública. Si necesitas ayuda con este paso, consulta el siguiente laboratorio: 
   [Crear una VCN manualmente](../Subnet-Public/Subnet-Public.md)
   
3. Configuración de un Network Security Group (NSG)
Dentro de la misma VCN, crea un Network Security Group.

   ![Paso 3](../screenshots/Network-Security-Groups/03-Network-Security-Groups.png)
   ![Paso 3](../screenshots/Network-Security-Groups/03B-Network-Security-Groups.png)
   
4. Crear una instancia de cómputo
Crea una instancia de cómputo en tu VCN.
   
   ![Paso 4](../screenshots/Network-Security-Groups/04-Network-Security-Groups.png) 
   ![Paso 4](../screenshots/Network-Security-Groups/04B-Network-Security-Groups.png)
   ![Paso 4](../screenshots/Network-Security-Groups/04C-Network-Security-Groups.png)
   ![Paso 4](../screenshots/Network-Security-Groups/04D-Network-Security-Groups.png)   

5. Instalar y configurar el servidor web Apache
En la instancia de cómputo que creaste, instala el servidor web Apache y crea un archivo index.html de prueba.
   
   ![Paso 5](../screenshots/Network-Security-Groups/05-Network-Security-Groups.png)
   ![Paso 5](../screenshots/Network-Security-Groups/05B-Network-Security-Groups.png)   
   
6. Asociar el NSG a la instancia
Asocia el Network Security Group que creaste en el paso 3 a la instancia de cómputo.

   ![Paso 6](../screenshots/Network-Security-Groups/06-Network-Security-Groups.png)
   ![Paso 6](../screenshots/Network-Security-Groups/06B-Network-Security-Groups.png)   
   
7- Verificar el funcionamiento del laboratorio
Copia la IP pública de tu instancia y pégala en el navegador de tu conexión local. Deberías ver el mensaje: "This is a compute demo test page".

   ![Paso 7](../screenshots/Network-Security-Groups/07-Network-Security-Groups.png)

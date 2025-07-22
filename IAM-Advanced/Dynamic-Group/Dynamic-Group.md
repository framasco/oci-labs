Dynamic-Group.md

🧩 Ejercicio
Se desea que el grupo dinamico GroupDevTeam pueda gestionar object storage en el compartimento Labs

Pasos previo.
A- Crear una VCN en el compartimento Labs, la misma debe tener una ip publica.
B- Crear una instancia en el compartimento Labs, y asociarla la ip publica de la VCN del punto A.
C- Se debe poner conectar a la instacia desde Cloud Shell.
  
---
## 🔍 Paso a paso

1. Desde Cloud Shell con conectamos vía ssh a la instancia creada en el punto B.  

    allow group 'labs'/'DevTeam' to manage object-family in compartment Labs
	
   ![Paso 1](../screenshots/Dynamic-Group/01-Dynamic-Group.png)

2. Luego verificamos si esta instalado OCI CLI, si no lo esta se puede instalar ejecutando este comando:
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)".

   ![Paso 2](../screenshots/Dynamic-Group/02-Dynamic-Group.png)

3. Crear el grupo dinamico GroupDevTeam en el dominio Labs.

   ![Paso 3](../screenshots/Dynamic-Group/03-Dynamic-Group.png)
   ![Paso 3](../screenshots/Dynamic-Group/03B-Dynamic-Group.png)
   ![Paso 3](../screenshots/Dynamic-Group/03C-Dynamic-Group.png)   
   
4. Autorizar al grupo dinamico mediante policies.   
   
   ![Paso 4](../screenshots/Dynamic-Group/04-Dynamic-Group.png)

5. Crear un bucket desde la instancia creada en el punto B.   
   
   ![Paso 5](../screenshots/Dynamic-Group/04-Dynamic-Group.png)
   ![Paso 5](../screenshots/Dynamic-Group/04B-Dynamic-Group.png) 

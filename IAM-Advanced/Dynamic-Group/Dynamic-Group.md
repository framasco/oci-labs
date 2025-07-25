Dynamic-Group.md
🧩 Ejercicio
El objetivo es permitir que el grupo dinámico GroupDevTeam pueda gestionar recursos de Object Storage en el compartimento Labs.

🔧 Pasos previos
A. Crear una VCN en el compartimento Labs, asegurándose de que tenga una IP pública.
B. Crear una instancia en ese mismo compartimento y asociarle la IP pública de la VCN del paso anterior.
C. Confirmar que es posible conectarse a la instancia desde Cloud Shell.

---
## 🔍 Paso a paso

1.  Conectarse por SSH desde Cloud Shell a la instancia creada.
	Policy necesaria:
    allow group 'labs'/'DevTeam' to manage object-family in compartment Labs
	
   ![Paso 1](../screenshots/Dynamic-Group/01-Dynamic-Group.png)

2. Verificar si la instancia tiene el OCI CLI instalado.
Si no lo está, se puede instalar con este comando:
bash -c "$(curl -L https://raw.githubusercontent.com/oracle/oci-cli/master/scripts/install/install.sh)".

   ![Paso 2](../screenshots/Dynamic-Group/02-Dynamic-Group.png)

3. Crear el grupo dinámico GroupDevTeam en el dominio de identidad Labs.

   ![Paso 3](../screenshots/Dynamic-Group/03-Dynamic-Group.png)
   ![Paso 3](../screenshots/Dynamic-Group/03B-Dynamic-Group.png)
   ![Paso 3](../screenshots/Dynamic-Group/03C-Dynamic-Group.png)   
   
4. Crear la política que autoriza al grupo dinámico. 
   
   ![Paso 4](../screenshots/Dynamic-Group/04-Dynamic-Group.png)

5. Probar la configuración intentando crear un bucket desde la instancia.   
   
   ![Paso 5](../screenshots/Dynamic-Group/05-Dynamic-Group.png)
   ![Paso 5](../screenshots/Dynamic-Group/05B-Dynamic-Group.png)   

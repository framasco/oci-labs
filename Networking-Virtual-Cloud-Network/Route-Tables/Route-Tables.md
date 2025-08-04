
Este ejercicio te mostrará cómo trabajar con tablas de rutas (Route Tables) en Oracle Cloud Infrastructure. Aprenderás a:

Crear una nueva tabla de rutas.

Agregar reglas de ruteo.

Asociar la tabla a una subnet específica.

---
## Paso a paso

1. Crear VCN manualmente.  
   Este laboratorio asume que ya tenés una VCN creada manualmente.  
   Si necesitás crearla, podés seguir los pasos en el siguiente laboratorio:  
   👉 [Crear una VCN manualmente](../Create-a-VCN-Manually/Create-a-VCN-Manually.md)


2. Crear una subnet pública en la VCN creada manualmente en el paso 1.

   ![Paso 2](../screenshots/Route-Tables/02-Route-Tables.png)
   ![Paso 2](../screenshots/Route-Tables/02B-Route-Tables.png)

3. Crear un Internet Gateway en la misma VCN.

   ![Paso 3](../screenshots/Route-Tables/03-Route-Tables.png)
   ![Paso 3](../screenshots/Route-Tables/03B-Route-Tables.png)
   
4. Agregar una regla de ruteo a la tabla de rutas por defecto (Default Route Table) de la VCN.
   
   ![Paso 4](../screenshots/Route-Tables/04-Route-Tables.png)
   ![Paso 4](../screenshots/Route-Tables/04B-Route-Tables.png)
   ![Paso 4](../screenshots/Route-Tables/04C-Route-Tables.png)

5. Crear una nueva tabla de rutas (Route Table).
   
   ![Paso 5](../screenshots/Route-Tables/05-Route-Tables.png)
   ![Paso 5](../screenshots/Route-Tables/05B-Route-Tables.png)   
   
6. Asociar la nueva tabla de rutas creada en el paso 5 a la subnet creada en el paso 2.

   ![Paso 6](../screenshots/Route-Tables/06-Route-Tables.png)
   ![Paso 6](../screenshots/Route-Tables/06B-Route-Tables.png)   

06 - Policies
✔️ Actividad práctica:
Crear una política (policy) que permita a los usuarios del grupo LabsNetwork administrar recursos de red (network-family) en el compartimento y dominio de identidad Labs.

🧠 Contexto
Ya contamos con:
Un dominio de identidad: Labs
Un compartimento: Labs
Un grupo: LabsNetwork

El objetivo es crear una policy que otorgue permisos al grupo LabsNetwork para administrar recursos de red (como VCNs) en el dominio y compartimento Labs.

---
## 🔍 Paso a paso

1. Ingresé al menú de navegación de Oracle Cloud y seleccioné Identity & Security > Policies.  
   ![Paso 1](../screenshots/06-policy/01-06-policy.png)

2. Hice clic en Create Policy. Asegurate de que esté seleccionada la ubicación correcta: compartimento Labs.  
   ![Paso 2](../screenshots/06-policy/02-06-policy.png)

3. Completé el formulario de creación de policy y confirmé con Create.  
   ![Paso 3](../screenshots/06-policy/03-06-policy.png)

4. Ahora ingresamos con un usuario que pertenezca al grupo LabsNetwork y inicié el proceso de creación de una VCN, completé los datos requeridos y finalicé el asistente. Esto validó que la policy funciona correctamente.
   ![Paso 4](../screenshots/06-policy/04-A-06-policy.png)
			(../screenshots/06-policy/04-B-06-policy.png)
			(../screenshots/06-policy/04-C-06-policy.png)
            (../screenshots/06-policy/04-D-06-policy.png)
			(../screenshots/06-policy/04-E-06-policy.png)
			(../screenshots/06-policy/04-F-06-policy.png)
			(../screenshots/06-policy/04-G-06-policy.png)

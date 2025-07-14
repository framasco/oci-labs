# 05. IAM-And-Policies 
Caso:
Querés permitir que un grupo llamado DevTeam:

Cree instancias de compute en el compartimento Sandbox

Use Object Storage solo si el recurso tiene el tag tier=dev

Policies necesarias:
Allow group DevTeam to manage instance-family in compartment Sandbox
Allow group DevTeam to use object-family in compartment Sandbox 
  where all { target.resource.tag.tier = 'dev' }

---
## 🔍 Paso a paso 

1. Ingresé al menú de navegación de Oracle Cloud y seleccioné Identity & Security > Compartments.  
   ![Paso 1](../screenshots/05-IAM-And-Policies/01-05-IAM-And-Policies.png)

2. Hice clic en Create Compartment..  
   ![Paso 2](../screenshots/05-IAM-And-Policies/02-05-IAM-And-Policies.png)   

3. Completé el formulario con los datos del compartimento y confirmé con Create Compartment.
   ![Paso 3](../screenshots/05-IAM-And-Policies/03-05-IAM-And-Policies.png)    
   
4. Navegué a Identity & Security > Domains para gestionar el dominio.
   ![Paso 4](../screenshots/05-IAM-And-Policies/04-05-IAM-And-Policies.png)
   
5. Ingresé al dominio correspondiente y accedí a la solapa User Management.
   ![Paso 5](../screenshots/05-IAM-And-Policies/05-05-IAM-And-Policies.png)   
   
6. Seleccioné Groups y luego hice clic en Create Group.
   ![Paso 6](../screenshots/05-IAM-And-Policies/06-05-IAM-And-Policies.png)  

7. Completé el formulario del grupo DevTeam y confirmé con Create.
   ![Paso 7](../screenshots/05-IAM-And-Policies/07-05-IAM-And-Policies.png)     
   
8. Luego accedí a la solapa Policies del dominio y seleccioné Create Policy.
   ![Paso 8](../screenshots/05-IAM-And-Policies/08-05-IAM-And-Policies.png) 

9. Completé el formulario y escribí manualmente las políticas necesarias, luego confirmé con Create.
   ![Paso 9](../screenshots/05-IAM-And-Policies/09-05-IAM-And-Policies.png)    

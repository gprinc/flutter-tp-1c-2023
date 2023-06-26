
# SerManos

## 73.21 - Desarrollo de Aplicaciones Móviles Multiplataforma


### Contenido

- Descripción
- Arquitectura
- Monitoreo
- Notificaciones
- Autores

## Descripción

El presente proyecto desarrollado mediante el framework de flutter, respeta el diseño solicitado del figma y su flujo de datos, además de implementar la funcionalidad de Push Notifications, Deep links, autenticación, state management y testing (tanto unit testing como golden tests). A continuación, se presenta toda la información relevante del proyecto.

## Arquitectura

La aplicación consta de una aplicación frontend desarrollada en dart mediante el framework flutter, y se comunica con el backend mediante una API de firebase, interactuando con una base de datos que almacena y provee los modelos del proyecto.

### Firebase

La base modela los datos mediante las siguientes colecciones:
- users: contiene toda la información relevante del usuario (email, id, nombre, apellido, etc.)
- novedades (Los campos de la novedad son: )
- voluntariados (Los campos del voluntariado son: )

### State management
Se utilizó la librería Provider para el manejo de estado de la aplicación. Esta librería nos permite obtener información tanto de los voluntariados como de las novedades y el manejo de la información del usuario de una manera eficiente y sencilla. 

### Navegación y Deep links
Para el manejo de deep links se utilizó la librería GoRouter, siendo esta la más sencilla de configurar con respecto al resto de las opciones y cubriendo todas las necesidades de la aplicación. 
También, se configuraron los archivos correspondientes con el siguiente esquema:
sermanos://pages/[page]

### Testing

Se implementaron los siguientes tipos de test:
#### Unit testing
En este caso se testearon los distintos servicios que nos permiten interactuar con los voluntariados, las novedades y los usuarios. Para ello, se mockearon los sericios y la base de firebase utilizando la librería [fake_cloud_firestore](https://pub.dev/packages/fake_cloud_firestore/example)

#### Golden tests
Se realizan en distintos dispositivos de diferentes tamaños con el fin de testear los widgets de la UI con snapshots, siendo exitoso el test si lucieran de la misma manera. 
Para correr los golden tests, se debe correr el comando:
`flutter test --update-goldens`

### Monitoreo
Para el monitoreo de la aplicación utilizamos Crashlytics de Firebase (para errores y bugs de la aplicación) y Analytics (para observar la navegación del usuario y el comportamiento del mismo durante la UX).

### Autenticación
Para el logueo o registración de la app se utilizo Firebase Auth, con únicamente disponible el ingreso usando un email y contraseña.

### Notificaciones

Las push notifications fueron implementadas utilizando las siguientes librerías:
[flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
[Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging?hl=es-419)

Actualmente la aplicación soporta tanto background notifications como foreground notifications. 
Por un lado se integró con Firebase Messaging para agregar el manejo general de notificaciones y se la complementó con flutter-local-notifications para poder emitir cuando la app se encuentra en foreground, ya que por default firebase no muestra las notificaciones si la app se encuentra en foreground (solo recibe el mensaje). Además de mostrar la notificación al usuario, la aplicación posee un handler para cuando el usuario interacciona con la notificación, parseando el payload del mismo (en caso de novedades, por ejemplo, el payload contiene el tipo de notificación y el identificaor de la novedad) para el correcto ruteo en la aplicación.

#### Testing de notificaciones
Para probar el correcto funcionamiento de las notificaciones, se utilizó la herramienta [Postman](https://www.postman.com/) con. la siguiente configuración: 


#### Dificultades
Si bien las funcionalidades mencionadas anteriormente con respecto a las notificaciones estan funcionando y estan probadas, hubo una dificultad que no se pudo sortear. Cuando el usuario presiona. la notificación, la misma reacciona ante evento, extrae la información relevante del payload, pero no llega a rutear correctamente a la página deseada. Esto no se debe a ninguna falta de configuración o mal funcionamiento de la implementación de notifiaciones, sino a un inconveniente con el BuildContext y el la configuración de GoRouter. Probamos muchas opciones distintas para solucionar esto (una de ellas, utilizar el widget Builder para utilizar el contexto del parent widget al configurar el router) sin embargo, no pudimos terminar de solucionarlo. 


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
- users: contiene toda la información relevante del usuario (email, id, )
- novedades
- voluntariados

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

### Notificaciones
### Dificultades

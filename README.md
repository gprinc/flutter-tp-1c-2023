
# SerManos

## 73.21 - Desarrollo de Aplicaciones Móviles Multiplataforma


### Contenido

- [Descripción](#descripción)
- [Arquitectura](#arquitectura)
- [Monitoreo](#monitoreo)
- [Autenticación](#autenticación)
- [Notificaciones](#notificaciones)
- [Autores](#autores)

## Descripción

El presente proyecto desarrollado mediante el framework de flutter, respeta el diseño solicitado del figma y su flujo de datos, además de implementar la funcionalidad de Push Notifications, Deep links, autenticación, state management y testing (tanto unit testing como golden tests). A continuación, se presenta toda la información relevante del proyecto.

## Arquitectura

La aplicación consta de una aplicación frontend desarrollada en dart mediante el framework flutter, y se comunica con el backend mediante una API de firebase, interactuando con una base de datos que almacena y provee los modelos del proyecto.

### Firebase

La base modela los datos mediante las siguientes colecciones:
- users
- novedades
- voluntariados

### State management
Se utilizó la librería Provider para el manejo de estado de la aplicación. Esta librería nos permite obtener información tanto de los voluntariados como de las novedades y el manejo de la información del usuario de una manera eficiente y sencilla. 

### Navegación y Deep links
Para el manejo de deep links se utilizó la librería GoRouter, siendo esta la más sencilla de configurar con respecto al resto de las opciones y cubriendo todas las necesidades de la aplicación. 
También, se configuraron los archivos correspondientes con el siguiente esquema:
sermanos://pages/[page]

Si fuese que también se estuviese trabajando en una aplicación web, se configuraría el deep link con el schema y el server de esa aplicación web, con el fin de que al abrir en el navegador la versión web de la aplicación, el mismo SO del dispositivo pueda redirigir al usuario a la versión móvil. Como solo contamos con una aplicación móvil, se optó por configurar. el esquema anteriormente mencionado. 

### Testing

Se implementaron los siguientes tipos de test:
#### Unit testing
En este caso se testearon los distintos servicios que nos permiten interactuar con los voluntariados, las novedades y los usuarios. Para ello, se mockearon los sericios y la base de firebase utilizando la librería [fake_cloud_firestore](https://pub.dev/packages/fake_cloud_firestore/example)<br />
Para correr los unit tests, se debe correr el comando:
`flutter test`

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
- [flutter_local_notifications](https://pub.dev/packages/flutter_local_notifications)
- [Firebase Cloud Messaging](https://firebase.google.com/docs/cloud-messaging?hl=es-419)

Actualmente la aplicación soporta tanto background notifications como foreground notifications. 
Por un lado se integró con Firebase Messaging para agregar el manejo general de notificaciones y se la complementó con flutter-local-notifications para poder emitir cuando la app se encuentra en foreground, ya que por default firebase no muestra las notificaciones si la app se encuentra en foreground (solo recibe el mensaje). Además de mostrar la notificación al usuario, la aplicación posee un handler para cuando el usuario interacciona con la notificación, parseando el payload del mismo (en caso de novedades, por ejemplo, el payload contiene el tipo de notificación y el identificaor de la novedad) para el correcto ruteo en la aplicación.

#### Testing de notificaciones
Para probar el correcto funcionamiento de las notificaciones, se utilizó la herramienta [Postman](https://www.postman.com/). Para el request, debe hacerse un POST a https://fcm.googleapis.com/fcm/send utilizando el siguiente formato en el body:  <br />
```
{
    "to": "<DEVICE_TOKEN>",
    "notification": {
        "title": "Novedades",
        "body": "Nueva noticia cargada!"
    },
    "data": {
        "id": "1",
        "type": "noticias"
    }
}
```
Como último requisito, debemos habilitar el servicio Firebase Cloud Messaging en Firebase para obtener un SERVER_KEY y utilizarlo en el header Authorization.

De esta manera, las notificaciones se muestran en foreground: <br />
<br />
![Captura de pantalla 2023-06-26 a la(s) 19 42 37](https://github.com/gprinc/flutter-tp-1c-2023/assets/37815318/3adc8aad-76b2-486e-9092-4faa4ae14ba2)



#### Dificultades
Si bien las funcionalidades mencionadas anteriormente con respecto a las notificaciones estan funcionando y estan probadas, hubo una dificultad que no se pudo sortear. Cuando el usuario presiona. la notificación, la misma reacciona ante evento, extrae la información relevante del payload, pero no llega a rutear correctamente a la página deseada. Esto no se debe a ninguna falta de configuración o mal funcionamiento de la implementación de notifiaciones, sino a un inconveniente con el BuildContext y el la configuración de GoRouter. Probamos muchas opciones distintas para solucionar esto (una de ellas, utilizar el widget Builder para utilizar el contexto del parent widget al configurar el router) sin embargo, no pudimos terminar de solucionarlo. 

### Comentarios finales sobre el diseño

1) Para confirmar la participación de un usuario a un voluntariado, se debe modificar la base de datos de firebase. Simplemente se logra pasando un usuario de un voluntariado de "appliersEmail" a "participantsEmails". De esa manera, se mostrará el diseño correspondiente en la página de un voluntariado.
2) En el perfil, no se podrá modificar el email del usuario. Esto se debió a una decisión de diseño ya que el email es la única manera de distinguir a un usuario de manera inequívoca. 

## Autores

- [@maanuluque](https://github.com/maanuluque)
- [@gprinc](https://github.com/gprinc)
- [@agbossi](https://github.com/agbossi)



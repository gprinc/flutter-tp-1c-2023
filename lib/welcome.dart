import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const WelcomeApp());
}

class WelcomeApp extends StatelessWidget {
  const WelcomeApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue
    ));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyWelcomePage(),
    );
  }
}

class MyWelcomePage extends StatelessWidget {
  const MyWelcomePage({super.key});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding( padding: const EdgeInsets.only( left: 20, right: 20), child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png', height: 150, width: 150,),
            const Padding(
              padding: EdgeInsets.only(
                top: 70,
                bottom: 20,
              ),
              child: Text(
                '¡Bienvenido!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(
                bottom: 80,
              ),
              child: Text(
                'Nunca subestimes tu habilidad para mejorar la vida de alguien',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                textAlign: TextAlign.center,
              ),
            ),
            FractionallySizedBox(
              widthFactor: 1,
              child: TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Colors.blue
                  
                ),
                child: const Text('COMENZAR'),
              ),
            )
          ],
        )),
      ),
    );
  }
}


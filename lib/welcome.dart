import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const WelcomeApp());
}

class WelcomeApp extends StatelessWidget {
  const WelcomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.blue
    ));
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyWelcomePage(),
    );
  }
}

class MyWelcomePage extends StatelessWidget {
  const MyWelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding( padding: const EdgeInsets.only( left: 20, right: 20), child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('assets/logo.png', height: width * 0.45, width: width * 0.45,),
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


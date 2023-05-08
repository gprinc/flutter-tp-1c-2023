import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(const InitialApp());
}

class InitialApp extends StatelessWidget {
  const InitialApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyInitialPage(),
    );
  }
}

class MyInitialPage extends StatelessWidget {
  const MyInitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/logo.png',
                  height: width * 0.45,
                  width: width * 0.45,
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    bottom: 50,
                  ),
                  child: Text(
                    '“El esfuerzo desinteresado para llevar alegría a los demás será el comienzo de una vida más feliz para nosotros”',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 50,
                  ),
                  child: FractionallySizedBox(
                    widthFactor: 1,
                    child: TextButton(
                      onPressed: () => context.goNamed('login'),
                      style: TextButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.blue),
                      child: const Text('INICIAR SESIÓN'),
                    ),
                  ),
                ),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: TextButton(
                    onPressed: () => context.goNamed('signup'),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue),
                    child: const Text('REGISTRARSE'),
                  ),
                )
              ],
            )),
      ),
    );
  }
}

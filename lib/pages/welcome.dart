import 'package:dam_1c_2023/tokens/token_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../atoms/logos.dart';
import '../molecules/buttons.dart';

void main() {
  runApp(const WelcomeApp());
}

class WelcomeApp extends StatelessWidget {
  const WelcomeApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WelcomePage(),
    );
  }
}

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                squareLogo,
                const Padding(
                  padding: EdgeInsets.only(
                    top: 70,
                    bottom: 20,
                  ),
                  child: Text(
                    '¡Bienvenido!',
                    textAlign: TextAlign.center,
                    style: headLine01,
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.only(
                      bottom: 80,
                    ),
                    child: Text(
                      'Nunca subestimes tu habilidad para mejorar la vida de alguien',
                      style: subtitle01,
                      textAlign: TextAlign.center,
                    )),
                FractionallySizedBox(
                  widthFactor: 1,
                  child: CtaButton(
                      text: 'COMENZAR',
                      handlePress: () => context.go("/home"),
                      enabledState: true,
                      disableAfterPress: true),
                )
              ],
            )),
      ),
    );
  }
}

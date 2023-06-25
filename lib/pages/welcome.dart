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
      body: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
          child: Column(
            children: <Widget>[
              Expanded(
                  child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    squareLogo,
                    const SizedBox(
                      height: 30,
                    ),
                    const Text(
                      '¡Bienvenido!',
                      textAlign: TextAlign.center,
                      style: headLine01,
                    ),
                    const SizedBox(
                      height: 48,
                    ),
                    const Text(
                      'Nunca subestimes tu habilidad para mejorar la vida de alguien',
                      style: subtitle01,
                      textAlign: TextAlign.center,
                    )
                  ],
                ),
              )),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CtaButton(
                    text: 'Comenzar',
                    handlePress: () => context.go("/home"),
                    enabledState: true,
                    disableAfterPress: true,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(' ', style: btnModif(Colors.white)),
                  )
                ],
              ),
            ],
          )),
    );
  }
}

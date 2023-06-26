import 'package:dam_1c_2023/molecules/buttons.dart';
import 'package:dam_1c_2023/tokens/token_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import 'tokens/token_fonts.dart';

void main() {
  runApp(const InitialApp());
}

class InitialApp extends StatelessWidget {
  const InitialApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: secondaryBlue));
    return const MaterialApp(
      title: 'Ser Manos',
      /*theme: ThemeData(
        primarySwatch: primary,
      ),*/
      home: MyInitialPage(),
    );
  }
}

class MyInitialPage extends StatelessWidget {
  const MyInitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 32),
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        /*Image.asset(
                          'assets/logo.png',
                          height: width * 0.45,
                          width: width * 0.45,
                        ),*/
                        Image.asset(
                          'assets/logo.png',
                          height: 150,
                          width: 150,
                        ),
                        const SizedBox(
                          height: 32,
                        ),
                        const Text(
                          '“El esfuerzo desinteresado para llevar alegría a los demás será el comienzo de una vida más feliz para nosotros”',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CtaButton(
                        text: 'Iniciar Sesión',
                        handlePress: () => context.goNamed('login'),
                        enabledState: true),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () => context.goNamed('signup'),
                      child: Text(
                        'Registrarse',
                        style: btnModif(primary),
                      ),
                    )
                  ],
                )
              ],
            )),
      ),
    );
  }
}

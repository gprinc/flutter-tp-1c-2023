import 'package:dam_1c_2023/pages/home.dart';
import 'package:dam_1c_2023/pages/selected_card_page.dart';
import 'package:dam_1c_2023/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'models/volunteering_list.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: "/",
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      path: "/home",
      builder: (context, state) => const Home(),
    ),
    GoRoute(
      path: "/selected-card",
      builder: (context, state) => const SelectedCardPage(
        imageName: 'voluntariado.png',
        title: 'Un techo para mi país',
        description:
            'A dos horas al sur de Vicente López en la ciudad de Buenos Aires.',
      ),
    ),
    GoRoute(
      path: "/welcome",
      builder: (context, state) => const WelcomePage(),
    ),
  ],
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return ChangeNotifierProvider(
        create: (_) => VolunteeringList(),
        child: MaterialApp.router(
          routerConfig: _router,
          title: 'Flutter App',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
        ));
  }
}

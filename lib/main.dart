import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'firebase_options.dart';
import 'package:dam_1c_2023/pages/home.dart';
import 'package:dam_1c_2023/pages/login.dart';
import 'package:dam_1c_2023/pages/selected_card_page.dart';
import 'package:dam_1c_2023/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'models/newsList.dart';
import 'models/volunteering_list.dart';
import 'pages/signup.dart';

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
        path: "/",
        builder: (context, state) => const MyInitialPage(),
        routes: [
          GoRoute(
            name: 'login',
            path: "login",
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            name: 'signup',
            path: "signup",
            builder: (context, state) => const SignupPage(),
          ),
        ]),
    GoRoute(
      name: 'welcome',
      path: "/welcome",
      builder: (context, state) => const WelcomePage(),
    ),
    GoRoute(
      name: 'home',
      path: "/home",
      builder: (context, state) => const Home(),
    ),
    GoRoute(
        name: 'selected-card',
        path: "/selected-card/:id",
        builder: (context, state) {
          final volunteeringProvider = Provider.of<VolunteeringList>(context);
          final int? index = int.tryParse(state.params['id'] ?? '');
          if (index == null) {
            // handle the case where index is null (e.g. invalid input)
            return Container();
          }
          final volunteering = volunteeringProvider.volunteering[index - 1];
          return SelectedCardPage(
            imageName: volunteering.imageName,
            title: volunteering.title,
            description: volunteering.description,
          );
        }),
  ],
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(statusBarColor: Colors.blue));
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VolunteeringList>(
          create: (_) => VolunteeringList(),
        ),
        ChangeNotifierProvider<NewsList>(
          create: (_) => NewsList(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        title: 'Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

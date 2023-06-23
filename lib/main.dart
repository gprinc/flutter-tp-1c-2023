import 'dart:ui';
import 'package:dam_1c_2023/initial.dart';
import 'package:dam_1c_2023/api/firebase_notifications.dart';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

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

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

GoRouter _router(FirebaseAnalyticsObserver obs) { 
  return GoRouter(
    observers: [obs],
  routes: [
    GoRoute(
        path: "/",
        builder: (context, state) => const WelcomePage(),
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
      builder: (context, state) => const Home(
        key: Key("Home"),
      ),
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
            info: volunteering,
          );
        }),
  ],
);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };
  
  await FirebaseNotifications().initNotifications();
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Got a message whilst in the foreground!');
      print('Message data: ${message.data}');

      if (message.notification != null) {
        print('Message also contained a notification: ${message.notification}');
      }
    });
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
        ChangeNotifierProvider<UserService>(
          create: (_) => UserService(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router(observer),
        title: 'Flutter App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}

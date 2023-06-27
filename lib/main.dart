import 'dart:ui';
import 'package:dam_1c_2023/firebase/firebase_notification_service.dart';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:dam_1c_2023/pages/novedades.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'firebase/firebase_notification_provider.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dam_1c_2023/pages/home.dart';
import 'package:dam_1c_2023/pages/login.dart';
import 'package:dam_1c_2023/pages/selected_card_page.dart';
import 'package:dam_1c_2023/pages/welcome.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import 'initial.dart';
import 'models/newsList.dart';
import 'models/volunteering_list.dart';
import 'pages/signup.dart';

GoRouter _router(FirebaseAnalyticsObserver obs) {
  return GoRouter(
    observers: [obs],
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
        path: "/home/:index",
        builder: (context, state) {
          final int initialTabIndex = state.params['index'] != null
              ? int.tryParse(state.params['index']!) ?? 0
              : 0;
          return Home(
            key: const Key("Home"),
            initialTabIndex: initialTabIndex,
          );
        },
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
            final volunteering = volunteeringProvider.volunteering[index];
            return SelectedCardPage(
              info: volunteering,
            );
          }),
      GoRoute(
        name: 'selected-news',
        path: "/selected-news/:id",
        builder: (context, state) {
          final newsProvider = Provider.of<NewsList>(context);
          final int? index = int.tryParse(state.params['id'] ?? '');
          if (index == null) {
            // handle the case where index is null (e.g. invalid input)
            return Container();
          }
          final news = newsProvider.news[index];
          return NewsPage(
            imageName: news.imageName,
            title: news.title,
            description: news.description,
            body: news.body,
            header: news.header,
            index: index,
          );
        },
      ),
    ],
  );
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await FirebaseNotificationService.initializeFirebase();
  final RemoteMessage? _message = await FirebaseNotificationService.firebaseMessaging.getInitialMessage();

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key, RemoteMessage? message}) : super(key: key);
  
  get message => null;

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      FCMProvider.setContext(context);
    });
  }

  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  @override
  Widget build(BuildContext context) {
    // FCMProvider.setContext(context);
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
        ChangeNotifierProvider<FCMProvider>(
          create: (_) => FCMProvider(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: _router(observer),
        title: 'Ser Manos',
        /*theme: ThemeData(
          primarySwatch: Colors.blue,
        ),*/
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

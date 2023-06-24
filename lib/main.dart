import 'dart:ui';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:overlay_support/overlay_support.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:dam_1c_2023/pages/home.dart';
import 'package:dam_1c_2023/pages/login.dart';
import 'package:dam_1c_2023/pages/selected_card_page.dart';
import 'package:dam_1c_2023/pages/welcome.dart';
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

Future<void> _firebaseMessagingBackgroundHandler(message) async {
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
  flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
      AndroidFlutterLocalNotificationsPlugin>()?.requestPermission();
 await UserService().loginUser('fluter@itba.com', 'prueba123');
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  String? token = await messaging.getToken();
  print(token);

  if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    print('User granted permission');
  } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
    print('User granted provisional permission');
  } else {
    print('User declined or has not accepted permission');
  }
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  FlutterError.onError = (errorDetails) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
  };
  // Pass all uncaught asynchronous errors that aren't handled by the Flutter framework to Crashlytics
  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };


  runApp(
    const OverlaySupport(child: MyApp())
  );
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>{

  @override
  void initState() {
    FirebaseMessaging.onMessage.listen(
          (RemoteMessage message) async {

            // showSimpleNotification(
            //   Text(message.notification?.title ?? ""),
            //   background: Colors.blue, // Customize the background color
            //   duration: Duration(seconds: 2), //the duration for which the notification will be displayed
            // );
            FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
            final AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('app_icon');
            await flutterLocalNotificationsPlugin.initialize(InitializationSettings(android: initializationSettingsAndroid));
            const AndroidNotificationDetails androidNotificationDetails =
          AndroidNotificationDetails(
              'your channel id',
              'your channel name',
              channelDescription: 'your channel description',
              importance: Importance.max,
              priority: Priority.max, fullScreenIntent: true,);
          const NotificationDetails notificationDetails =
              NotificationDetails(android: androidNotificationDetails);
          await flutterLocalNotificationsPlugin.show(
              0, message.notification?.title, message.notification?.body, notificationDetails,
              payload: 'item x');
      },
    );
    super.initState();
  }

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
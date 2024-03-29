import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsITBA {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  void onLogin() {
    analytics.logLogin();
  }

  void onEvent(String event, Map<String, Object> params) {
    analytics.logEvent(name: event, parameters: params);
  }
}

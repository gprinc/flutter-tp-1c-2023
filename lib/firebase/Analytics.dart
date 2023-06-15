import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class Analytics {
  static FirebaseAnalytics analytics = FirebaseAnalytics.instance;
  static FirebaseAnalyticsObserver observer =
      FirebaseAnalyticsObserver(analytics: analytics);

  void onLogin() {         
          analytics.logLogin();
         // similar to: analytics.logEvent(name: 'login');
     }
   
   void onEvent(String event, Map<String, Object> params) {
       analytics.logEvent(
         name: event, 
         parameters: params);
   }
}

import 'package:dam_1c_2023/initial.dart';
import 'package:dam_1c_2023/models/newsList.dart';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:dam_1c_2023/models/volunteering_list.dart';
import 'package:dam_1c_2023/pages/home.dart';
import 'package:dam_1c_2023/pages/login.dart';
import 'package:dam_1c_2023/pages/signup.dart';
import 'package:dam_1c_2023/pages/welcome.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:golden_toolkit/golden_toolkit.dart';
import 'package:network_image_mock/network_image_mock.dart';
import 'package:provider/provider.dart';

import 'mocks/mock_news_service.dart';
import 'mocks/mock_user_service.dart';
import 'mocks/mock_volunteering.dart';

Future<void> goldenTest(WidgetTester tester, Widget widget, String name,
    List<ChangeNotifierProvider> providers) async {
  DeviceBuilder deviceBuilder = DeviceBuilder()
    ..overrideDevicesForAllScenarios(devices: [
      Device.phone,
      Device.iphone11,
      Device.tabletPortrait,
    ])
    ..addScenario(
        widget: MultiProvider(
      providers: providers,
      child: MaterialApp(
          home: ChangeNotifierProvider<UserService>.value(
              value: MockUserService(), child: MaterialApp(home: widget))),
    ));

  await mockNetworkImagesFor(() => tester.pumpDeviceBuilder(deviceBuilder));
  await screenMatchesGolden(tester, name);
}

void main() {
  loadAppFonts();
  ChangeNotifierProvider<UserService> userMockedProvider =
      ChangeNotifierProvider<UserService>.value(value: MockUserService());
  ChangeNotifierProvider<NewsList> newsMockedProvider =
      ChangeNotifierProvider<NewsList>.value(value: MockNewsProvider());
  ChangeNotifierProvider<VolunteeringList> volunteeringMockedProvider =
      ChangeNotifierProvider<VolunteeringList>.value(
          value: MockVolunteeringList());

  testGoldens('Golden test initial page', (WidgetTester tester) async {
    await goldenTest(
        tester, const MyInitialPage(), 'initial_page', [userMockedProvider]);
  });

  testGoldens('Golden test welcome page', (WidgetTester tester) async {
    await goldenTest(
        tester, const WelcomePage(), 'welcome_page', [userMockedProvider]);
  });

  testGoldens('Golden test login page', (WidgetTester tester) async {
    await goldenTest(
        tester, const LoginPage(), 'login_page', [userMockedProvider]);
  });

  testGoldens('Golden test signup page', (WidgetTester tester) async {
    await goldenTest(
        tester, const SignupPage(), 'signup_page', [userMockedProvider]);
  });

  // testGoldens('Golden test home home page', (WidgetTester tester) async {
  //   await goldenTest(
  //       tester, const Home(key: Key('Home'),), 'home_page', [userMockedProvider, volunteeringMockedProvider, newsMockedProvider]);
  // });

}
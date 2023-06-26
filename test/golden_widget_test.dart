import 'package:dam_1c_2023/cells/profile_modal.dart';
import 'package:dam_1c_2023/initial.dart';
import 'package:dam_1c_2023/models/news.dart';
import 'package:dam_1c_2023/models/newsList.dart';
import 'package:dam_1c_2023/models/user.dart';
import 'package:dam_1c_2023/models/userService.dart';
import 'package:dam_1c_2023/models/volunteering_list.dart';
import 'package:dam_1c_2023/pages/home.dart';
import 'package:dam_1c_2023/pages/login.dart';
import 'package:dam_1c_2023/pages/news_tab.dart';
import 'package:dam_1c_2023/pages/novedades.dart';
import 'package:dam_1c_2023/pages/profile_tab.dart';
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

  testGoldens('Golden test novedad', (WidgetTester tester) async {
    News mockNews = News(
      header: 'REPORTE 2820',
      title: 'Ser donante voluntario',
      description:
          'Desde el Hospital Centenario recalcan la importancia de la donación voluntaria de Sangre',
      body:
          'En un esfuerzo por concienciar sobre la necesidad constante de sangre y sus componentes, el Hospital Centenario destaca la importancia de convertirse en un donante voluntario. La donación de sangre es un acto solidario y altruista que puede salvar vidas y mejorar la salud de aquellos que enfrentan enfermedades graves o accidentes.\n\nLa donación voluntaria de sangre desempeña un papel vital en el sistema de salud. A diferencia de la donación de sangre por reposición, donde se solicita a familiares y amigos donar para un paciente específico, la donación voluntaria se realiza sin ninguna conexión directa con un receptor particular. Esto garantiza un suministro constante y seguro de sangre y productos sanguíneos para todos aquellos que lo necesiten.\n\nLos beneficios de ser donante voluntario son numerosos. Además de la satisfacción de ayudar a quienes más lo necesitan, la donación de sangre tiene beneficios para la salud del propio donante. Al donar sangre, se realiza un chequeo médico que incluye pruebas para detectar enfermedades transmisibles, lo que puede proporcionar una evaluación temprana y ayuda en el diagnóstico de posibles problemas de salud.\n\n',
      imageName: 'assets/news_donar.png',
    );
    await goldenTest(
        tester,
        NewsPage(
          imageName: mockNews.imageName,
          title: mockNews.title,
          description: mockNews.description,
          body: mockNews.body,
          header: mockNews.header,
          index: 1,
        ),
        'news_page',
        [userMockedProvider]);
  });

  testGoldens('Golden test perfil vacio', (WidgetTester tester) async {
    UserModel user =
        UserModel(email: "user@itba.edu.ar", name: 'User', lastName: 'Model');
    await goldenTest(tester, ProfileTab(user: user), 'profile_tab_vacia',
        [userMockedProvider]);
  });

  testGoldens('Golden test perfil completo', (WidgetTester tester) async {
    UserModel user = UserModel(
        email: "user@itba.edu.ar",
        name: 'User',
        lastName: 'Model',
        birthDay: '09/07/1990',
        phoneNumber: '+549112255664',
        gender: 'Hombre');
    await goldenTest(tester, ProfileTab(user: user), 'profile_tab_lleno',
        [userMockedProvider]);
  });

  testGoldens('Golden test completar perfil', (WidgetTester tester) async {
    UserModel user =
        UserModel(email: "user@itba.edu.ar", name: 'User', lastName: 'Model');
    await goldenTest(tester, ProfileModal(user: user), 'profile_modal_vacio',
        [userMockedProvider]);
  });

  testGoldens('Golden test perfil completado', (WidgetTester tester) async {
    UserModel user = UserModel(
        email: "user@itba.edu.ar",
        name: 'User',
        lastName: 'Model',
        birthDay: '09/07/1990',
        phoneNumber: '+549112255664',
        gender: 'Hombre');
    await goldenTest(tester, ProfileModal(user: user), 'profile_modal_lleno',
        [userMockedProvider]);
  });

  testGoldens('Golden test tab novedades', (WidgetTester tester) async {
    await goldenTest(tester, const NewsTab(), 'tab_novedades',
        [userMockedProvider, newsMockedProvider]);
  });

  /*testGoldens('Golden test home home page', (WidgetTester tester) async {
    await goldenTest(
        tester,
        const Home(
          key: Key('Home'),
        ),
        'home_page',
        [userMockedProvider, volunteeringMockedProvider, newsMockedProvider]);
  }); */
}

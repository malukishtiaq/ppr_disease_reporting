import 'package:flutter/material.dart';
import 'package:ppr_disease_reporting/presentation/welcome/welcome_page.dart';
import 'package:ppr_disease_reporting/presentation/login/login_page.dart';
import 'package:ppr_disease_reporting/presentation/register/register_page.dart';
import 'package:ppr_disease_reporting/presentation/app_navigation_screen/app_navigation_screen.dart';

import '../presentation/maps/maps_page.dart';

class AppRoutes {
  static const String welcomePage = '/welcome';

  static const String loginPage = '/login';

  static const String registerPage = '/register';

  static const String mapsPage = '/maps';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    welcomePage: (context) => WelcomePage(),
    loginPage: (context) => LoginPage(),
    registerPage: (context) => RegisterPage(),
    mapsPage: (context) => MapsPage(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}

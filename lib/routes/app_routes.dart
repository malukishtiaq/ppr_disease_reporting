import 'package:get/get.dart';
import 'package:ppr_disease_reporting/presentation/welcome/welcome_page.dart';
import 'package:ppr_disease_reporting/presentation/login/login_page.dart';
import 'package:ppr_disease_reporting/presentation/register/register_page.dart';
import 'package:ppr_disease_reporting/presentation/app_navigation_screen/app_navigation_screen.dart';

import '../presentation/home/home_page.dart';
import '../presentation/maps/maps_page.dart';

class AppRoutes {
  static const String welcomePage = '/welcome';
  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String mapsPage = '/maps';
  static const String homePage = '/home';
  static const String appNavigationScreen = '/app_navigation_screen';

  static List<GetPage> routes = [
    GetPage(name: welcomePage, page: () => WelcomePage()),
    GetPage(name: loginPage, page: () => LoginPage()),
    GetPage(name: registerPage, page: () => RegisterPage()),
    GetPage(name: mapsPage, page: () => MapsPage()),
    GetPage(name: homePage, page: () => HomePage()),
    GetPage(name: appNavigationScreen, page: () => AppNavigationScreen()),
  ];

  static void init() {
    Get.put(AppRoutes());
    Get.put(WelcomePage());
    Get.put(LoginPage());
    Get.put(RegisterPage());
    Get.put(MapsPage());
    Get.put(HomePage());
    Get.put(AppNavigationScreen());
  }
}

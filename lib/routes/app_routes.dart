import 'package:get/get.dart';
import 'package:ppr_disease_reporting/presentation/vacine/vaccine_page.dart';
import 'package:ppr_disease_reporting/presentation/welcome/welcome_page.dart';
import 'package:ppr_disease_reporting/presentation/login/login_page.dart';
import 'package:ppr_disease_reporting/presentation/register/register_page.dart';
import 'package:ppr_disease_reporting/presentation/app_navigation_screen/app_navigation_screen.dart';

import '../presentation/goat/goat_page.dart';
import '../presentation/mixed/mixed_page.dart';
import '../presentation/sheep/sheep_page.dart';
import '../presentation/home/home_page.dart';
import '../presentation/maps/maps_page.dart';
import '../presentation/speci_vaccine/speci_vaccine_page.dart';

class AppRoutes {
  static const String welcomePage = '/welcome';
  static const String loginPage = '/login';
  static const String registerPage = '/register';
  static const String mapsPage = '/maps';
  static const String vaccinePage = '/vaccine';
  static const String speciVaccine = '/speciVaccine';
  static const String sheep = '/sheep';
  static const String goat = '/goat';
  static const String mixed = '/mixed';
  static const String homePage = '/home';
  static const String appNavigationScreen = '/app_navigation_screen';

  static List<GetPage> routes = [
    GetPage(name: welcomePage, page: () => WelcomePage()),
    GetPage(name: loginPage, page: () => LoginPage()),
    GetPage(name: registerPage, page: () => RegisterPage()),
    GetPage(name: homePage, page: () => HomePage()),
    GetPage(name: appNavigationScreen, page: () => AppNavigationScreen()),
    GetPage(name: mapsPage, page: () => MapsPage()),
    GetPage(name: vaccinePage, page: () => VaccinePage()),
    GetPage(name: goat, page: () => GoatPage()),
    GetPage(name: mixed, page: () => MixedPage()),
    GetPage(name: sheep, page: () => SheepPage()),
    GetPage(name: speciVaccine, page: () => SpeciVaccinePage()),
  ];
}

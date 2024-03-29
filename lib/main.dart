import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/presentation/vacine/vaccine_controller.dart';
import 'package:ppr_disease_reporting/routes/app_routes.dart';
import 'package:ppr_disease_reporting/theme/theme_helper.dart';
import 'presentation/goat/goat_controller.dart';
import 'presentation/sheep/sheep_controller.dart';
import 'presentation/home/home_controller.dart';
import 'presentation/login/login_controller.dart';
import 'presentation/maps/maps_controller.dart';
import 'presentation/register/register_controller.dart';
import 'presentation/speci_vaccine/speci_vaccine_controller.dart';
import 'presentation/welcome/welcome_controller.dart';
import 'provider/user_controller.dart';
import 'helper/sentry_helper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');

  SentryHelper.sentryFlutterInit(() {
    runApp(MyApp());
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: initApp(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return GetMaterialApp(
            theme: theme,
            title: 'ppr_disease_reporting',
            initialBinding: AppBindings(),
            debugShowCheckedModeBanner: false,
            initialRoute: Get.find<UserController>().user != null
                ? AppRoutes.homePage
                : AppRoutes.welcomePage,
            getPages: AppRoutes.routes,
          );
        } else {
          return MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        }
      },
    );
  }

  Future<void> initApp() async {
    UserController value = Get.put(UserController());
    await value.loadUser();
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<WelcomeController>(WelcomeController());
    Get.put<MapsController>(MapsController());
    Get.put<HomeController>(HomeController());
    Get.put<VaccineController>(VaccineController());
    Get.put<SheepDataController>(SheepDataController());
    Get.put<GoatDataController>(GoatDataController());
    Get.put<SpeciVaccineController>(SpeciVaccineController());
    Get.put<RegisterController>(RegisterController());
    Get.put<LoginController>(LoginController());
  }
}

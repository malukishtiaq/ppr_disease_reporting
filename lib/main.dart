import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppr_disease_reporting/theme/theme_helper.dart';
import 'package:ppr_disease_reporting/routes/app_routes.dart';
import 'package:get/get.dart';

import 'presentation/home/home_controller.dart';
import 'presentation/login/login_controller.dart';
import 'presentation/maps/maps_controller.dart';
import 'presentation/register/register_controller.dart';
import 'provider/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userController = Get.put(UserController());
  await userController.loadUser();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');
  Get.put(AppBindings());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
  }
}

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<MapsController>(MapsController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => RegisterController());
    Get.lazyPut(() => LoginController());
  }
}

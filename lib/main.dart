import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppr_disease_reporting/theme/theme_helper.dart';
import 'package:ppr_disease_reporting/routes/app_routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      title: 'ppr_disease_reporting',
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.welcomePage,
      routes: AppRoutes.routes,
    );
  }
}

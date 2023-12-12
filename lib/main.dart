import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppr_disease_reporting/theme/theme_helper.dart';
import 'package:ppr_disease_reporting/routes/app_routes.dart';
import 'package:provider/provider.dart';

import 'provider/user_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final userProvider = UserProvider();
  await userProvider.loadUser();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);

  ThemeHelper().changeTheme('primary');
  runApp(
    ChangeNotifierProvider(
      create: (context) => userProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);
    return MaterialApp(
      theme: theme,
      title: 'ppr_disease_reporting',
      debugShowCheckedModeBanner: false,
      initialRoute: userProvider.user != null
          ? AppRoutes.homePage
          : AppRoutes.welcomePage,
      routes: AppRoutes.routes,
    );
  }
}

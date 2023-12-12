import 'package:flutter/material.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:provider/provider.dart';

import '../../provider/user_provider.dart';
import '../../widgets/custom_elevated_button.dart';
import 'home_controller.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key})
      : super(
          key: key,
        );

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context);

    final user = userProvider.user;
    mediaQueryData = MediaQuery.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 50.h,
            vertical: 48.v,
          ),
          child: Column(
            children: [
              CustomImageView(
                imagePath: ImageConstant.imgReshotIllustra,
                height: 249.v,
                width: 321.h,
              ),
              SizedBox(height: 49.v),
              SizedBox(height: 45.v),
              Expanded(
                child: FutureBuilder<DataResponse?>(
                  future: HomeController().getData(user?.id ?? 0),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.hasData) {
                      return Column(
                        children: [
                          GridView.count(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            children: [
                              _buildMenuCard(
                                  snapshot.data?.positiveOutbreaksData,
                                  "Positive Outbreaks"),
                              _buildMenuCard(
                                  snapshot.data?.negativeOutbreaksData,
                                  "Negative Outbreaks"),
                            ],
                          ),
                          _buildFullWidthMenuCard(
                              snapshot.data?.outbreaksData, "Outbreaks"),
                          _addOutBreak(),
                        ],
                      );
                    } else {
                      return Text('No data available.');
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuCard(int? value, String title) {
    return Card(
      color: Colors.white,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              (value ?? 0).toString(),
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFullWidthMenuCard(int? value, String title) {
    return Card(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              title,
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              (value ?? 0).toString(),
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _addOutBreak() {
    return Card(
      color: theme.colorScheme.onPrimary,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              onPressed: () {
                onTapScreenTitle(context, AppRoutes.mapsPage);
              },
              text: "Add out break",
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "PPR Reporting",
        margin: EdgeInsets.only(left: 45.h),
      ),
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgPepiconsPopMenu,
          margin: EdgeInsets.fromLTRB(34.h, 5.v, 34.h, 10.v),
          onTap: () => _showLogoutConfirmationDialog(context),
        ),
      ],
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Logout Confirmation',
          ),
          content: Text(
            'Are you sure you want to logout?',
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: TextStyle(color: Colors.blue, fontSize: 12),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _handleLogout(context);
              },
              child: Text(
                'Logout',
                style: TextStyle(color: Colors.red, fontSize: 12),
              ),
            ),
          ],
          backgroundColor: Color(0XFF102C57),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
        );
      },
    );
  }

  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }

  void _handleLogout(BuildContext context) {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    userProvider.setUser(null, true);
    Navigator.pushReplacementNamed(context, AppRoutes.welcomePage);
  }
}

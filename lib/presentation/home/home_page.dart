import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/models/data_response.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:ppr_disease_reporting/provider/user_controller.dart';
import 'package:ppr_disease_reporting/widgets/custom_elevated_button.dart';
import 'home_controller.dart';

class HomePage extends StatelessWidget {
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 50.h, vertical: 48.v),
          child: RefreshIndicator(
            onRefresh: () async => await homeController.getData(),
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              child: Column(
                children: [
                  CustomImageView(
                    imagePath: ImageConstant.imgReshotIllustra,
                    height: 249.v,
                    width: 321.h,
                  ),
                  SizedBox(height: 49.v),
                  Obx(() => _buildDataView(homeController.dataResponse.value)),
                  SizedBox(height: 11.v),
                  _addOutBreak(),
                  _addVaccine(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildDataView(DataResponse? data) {
    if (data == null) {
      return Center(
          child: Text(
        'You have not added any records',
        style: theme.textTheme.labelLarge,
      ));
    } else {
      return Column(
        children: [
          GridView.count(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            children: [
              _buildMenuCard(data.positiveOutbreaksData, "Positive Outbreaks"),
              _buildMenuCard(data.negativeOutbreaksData, "Negative Outbreaks"),
            ],
          ),
          _buildFullWidthMenuCard(data.outbreaksData, "Outbreaks"),
        ],
      );
    }
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
              textAlign: TextAlign.center,
              style: TextStyle(
                color: theme.colorScheme.onPrimary,
                fontSize: 14,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
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
            SizedBox(height: 10),
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
                onTapScreenTitle(AppRoutes.mapsPage);
              },
              text: "Add out break",
            ),
          ],
        ),
      ),
    );
  }

  Widget _addVaccine() {
    return Card(
      color: theme.colorScheme.onPrimary,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              onPressed: () {
                onTapScreenTitle(AppRoutes.vaccinePage);
              },
              text: "Add vaccine",
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
        IconButton(
          padding: EdgeInsets.fromLTRB(34.h, 5.v, 34.h, 10.v),
          icon: Icon(
            Icons.exit_to_app,
            color: Colors.white,
            size: 30,
          ),
          onPressed: () {
            _showLogoutConfirmationDialog(context);
          },
        )
      ],
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Logout Confirmation'),
          content: Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Get.back(),
              child: Text('Cancel',
                  style: TextStyle(color: Colors.blue, fontSize: 14)),
            ),
            TextButton(
              onPressed: () {
                Get.back();
                _handleLogout();
              },
              child: Text('Logout',
                  style: TextStyle(color: Colors.white, fontSize: 14)),
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

  void onTapScreenTitle(String routeName) {
    Get.toNamed(routeName)?.then((_) {
      homeController.getData();
    });
  }

  void _handleLogout() {
    final userController = Get.find<UserController>();
    userController.setUser(null, true);
    Get.offAllNamed(AppRoutes.welcomePage);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:ppr_disease_reporting/widgets/custom_elevated_button.dart';
import 'package:location/location.dart' as loc;
import '../../helper/permision_helper.dart';
import 'welcome_controller.dart';

class WelcomePage extends StatelessWidget {
  final WelcomeController controller = Get.put(WelcomeController());

  @override
  Widget build(BuildContext context) {
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
              Text(
                "Hello , Welcome !",
                style: theme.textTheme.displaySmall,
              ),
              SizedBox(height: 18.v),
              Container(
                width: 307.h,
                margin: EdgeInsets.symmetric(horizontal: 11.h),
                child: Text(
                  "Welcome to PPR Reporting",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 45.v),
              CustomElevatedButton(
                onPressed: () async {
                  controller.getLocationAndNavigate(AppRoutes.loginPage);
                },
                text: "Login",
              ),
              SizedBox(height: 24.v),
              CustomElevatedButton(
                onPressed: () async {
                  controller.getLocationAndNavigate(AppRoutes.registerPage);
                },
                text: "Sign Up",
              ),
              SizedBox(height: 13.v),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> getLocation() async {
    await PermissionHandler.isFor.locationPermission();
    loc.Location location = loc.Location();
    var _currentPosition = await location.getLocation();
    var longitude = _currentPosition!.longitude.toString();
    var latitude = _currentPosition!.latitude.toString();
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "PPR Reporting",
        margin: EdgeInsets.only(left: 45.h),
      ),
    );
  }
}

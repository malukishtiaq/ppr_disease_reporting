import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:ppr_disease_reporting/widgets/custom_elevated_button.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mediaQueryData = MediaQuery.of(context);

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
                  "Welcome to PPR Reporting Top platform to coders",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.titleMedium,
                ),
              ),
              SizedBox(height: 45.v),
              CustomElevatedButton(
                onPressed: () {
                  Get.offNamed(AppRoutes.loginPage);
                },
                text: "Login",
              ),
              SizedBox(height: 24.v),
              CustomElevatedButton(
                onPressed: () {
                  Get.offNamed(AppRoutes.registerPage);
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

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "PPR Reporting",
        margin: EdgeInsets.only(left: 45.h),
      ),
    );
  }
}

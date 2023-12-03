import 'package:flutter/material.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:ppr_disease_reporting/widgets/custom_checkbox_button.dart';
import 'package:ppr_disease_reporting/widgets/custom_elevated_button.dart';
import 'package:ppr_disease_reporting/widgets/custom_text_form_field.dart';
import 'login_controller.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key})
      : super(
          key: key,
        );

  final LoginController loginController = LoginController();

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  bool rememberme = false;

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(
            horizontal: 47.h,
            vertical: 58.v,
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 6.h),
                  child: Text(
                    "Welcome Back!",
                    style: theme.textTheme.displaySmall,
                  ),
                ),
              ),
              SizedBox(height: 10.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 6.h),
                  child: Text(
                    "Login to continue",
                    style: theme.textTheme.titleMedium,
                  ),
                ),
              ),
              SizedBox(height: 49.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 6.h),
                  child: Text(
                    "Username",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ),
              SizedBox(height: 11.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: CustomTextFormField(
                  controller: userNameController,
                ),
              ),
              SizedBox(height: 51.v),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 6.h),
                  child: Text(
                    "Password",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ),
              SizedBox(height: 11.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: CustomTextFormField(
                  controller: passwordController,
                  textInputAction: TextInputAction.done,
                ),
              ),
              SizedBox(height: 25.v),
              Padding(
                padding: EdgeInsets.only(left: 16.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildRememberme(context),
                    Padding(
                      padding: EdgeInsets.only(top: 3.v),
                      child: Text(
                        "Forget password?",
                        style: theme.textTheme.labelLarge,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 55.v),
              CustomElevatedButton(
                onPressed: () => _handleLogin(),
                text: "Login",
                margin: EdgeInsets.only(left: 6.h),
              ),
              SizedBox(height: 28.v),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Don’t have an account? ",
                      style: theme.textTheme.labelLarge,
                    ),
                    TextSpan(
                      text: "Sign Up",
                      style: CustomTextStyles.labelLargePrimary.copyWith(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                textAlign: TextAlign.left,
              ),
              SizedBox(height: 5.v),
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
      actions: [
        AppbarTrailingImage(
          imagePath: ImageConstant.imgPepiconsPopMenu,
          margin: EdgeInsets.fromLTRB(34.h, 5.v, 34.h, 10.v),
        ),
      ],
    );
  }

  Widget _buildRememberme(BuildContext context) {
    return CustomCheckboxButton(
      text: "Remember me",
      value: rememberme,
      padding: EdgeInsets.symmetric(vertical: 2.v),
      onChange: (value) {
        rememberme = value;
      },
    );
  }

  Future<void> _handleLogin() async {
    final username = userNameController.text;
    final password = passwordController.text;

    await loginController.handleLogin(username, password);
  }
}

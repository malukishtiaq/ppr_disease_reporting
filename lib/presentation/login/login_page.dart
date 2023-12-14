import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:ppr_disease_reporting/widgets/custom_checkbox_button.dart';
import 'package:ppr_disease_reporting/widgets/custom_elevated_button.dart';
import 'package:ppr_disease_reporting/widgets/custom_text_form_field.dart';
import '../../helper/c_n_i_c_formatter.dart';
import 'login_controller.dart';

class LoginPage extends GetView<LoginController> {
  final LoginController controller = Get.put(LoginController());

  LoginPage({Key? key}) : super(key: key);
  Future<void> _handleLogin() async {
    try {
      final result = await controller.handleLogin();

      if (result.success) {
        Get.snackbar('Success', 'Login successful');
        onTapScreenTitleAndRemoveUntil(AppRoutes.homePage);
      } else {
        Get.snackbar('Error', 'Login failed. ${result.message}');
      }
    } catch (e) {
      Get.snackbar('Error', 'Login failed. Please try again later.');
    }
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "PPR Reporting",
        margin: EdgeInsets.only(left: 45.h),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Welcome Back!", style: theme.textTheme.displaySmall),
        SizedBox(height: 10.v),
        Text("Login to continue", style: theme.textTheme.titleMedium),
      ],
    );
  }

  Widget _buildCnicField() {
    return CustomTextFormField(
      controller: controller.CNICController,
      validator: (value) {
        RegExp cnicRegex = RegExp(r'^\d{5}-\d{7}-\d$');
        if (!cnicRegex.hasMatch(value ?? "")) {
          return 'Invalid CNIC format';
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        CNICFormatter(),
      ],
    );
  }

  Widget _buildPasswordField() {
    return CustomTextFormField(
      obscureText: true,
      controller: controller.passwordController,
      textInputAction: TextInputAction.done,
    );
  }

  Widget _buildRememberMeRow() {
    return Obx(() => GestureDetector(
          onTap: () {
            controller.rememberMe.toggle();
          },
          child: Padding(
            padding: EdgeInsets.only(left: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomCheckboxButton(
                  text: "Remember me",
                  value: controller.rememberMe.value,
                  padding: EdgeInsets.symmetric(vertical: 2.v),
                  onChange: (value) {
                    controller.rememberMe.toggle();
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(top: 3.v),
                  child: Text("Forget password?",
                      style: theme.textTheme.labelLarge),
                ),
              ],
            ),
          ),
        ));
  }

  Widget _buildLoginButton() {
    return CustomElevatedButton(
      onPressed: _handleLogin,
      text: "Login",
      margin: EdgeInsets.only(left: 6.h),
    );
  }

  Widget _buildSignUpText() {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: "Don’t have an account? ",
            style: theme.textTheme.labelLarge,
          ),
          WidgetSpan(
            child: GestureDetector(
              onTap: () {
                onTapScreenTitle(AppRoutes.registerPage);
              },
              child: Text(
                "Sign Up",
                style: CustomTextStyles.labelLargePrimary.copyWith(
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        ],
      ),
      textAlign: TextAlign.left,
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.symmetric(horizontal: 47.h, vertical: 58.v),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWelcomeText(),
              SizedBox(height: 49.v),
              _buildCnicField(),
              SizedBox(height: 51.v),
              _buildPasswordField(),
              SizedBox(height: 25.v),
              _buildRememberMeRow(),
              SizedBox(height: 55.v),
              _buildLoginButton(),
              SizedBox(height: 28.v),
              _buildSignUpText(),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  void onTapScreenTitleAndRemoveUntil(String routeName) {
    Get.offAllNamed(routeName);
  }

  void onTapScreenTitle(String routeName) {
    Get.offNamed(routeName);
  }
}

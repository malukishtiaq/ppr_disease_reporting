import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:ppr_disease_reporting/widgets/custom_checkbox_button.dart';
import 'package:ppr_disease_reporting/widgets/custom_elevated_button.dart';
import 'package:ppr_disease_reporting/widgets/custom_text_form_field.dart';
import '../../helper/c_n_i_c_formatter.dart';
import 'login_controller.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key})
      : super(
          key: key,
        );

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController loginController = LoginController();

  TextEditingController CNICController = TextEditingController();

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
                    "CNIC",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
              ),
              SizedBox(height: 11.v),
              Padding(
                  padding: EdgeInsets.only(left: 6.h),
                  child: CustomTextFormField(
                    controller: CNICController,
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
                  )),
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
                  obscureText: true,
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
                onPressed: () async {
                  await _handleLogin(context);
                },
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
                    WidgetSpan(
                      child: GestureDetector(
                        onTap: () {
                          onTapScreenTitle(context, AppRoutes.registerPage);
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
              ),
              SizedBox(height: 5.v),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogin(BuildContext context) async {
    final CNIC = CNICFormatter.saveCNICToDatabase(CNICController.text);
    final password = passwordController.text;

    try {
      final result = await loginController.handleLogin(
          CNIC, password, context, rememberme);

      if (result.success) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login successful')),
        );

        onTapScreenTitleAndRemoveUntill(context, AppRoutes.homePage);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. ${result.message}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Login failed. Please try again later.')),
      );
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

  Widget _buildRememberme(BuildContext context) {
    return CustomCheckboxButton(
      text: "Remember me",
      value: rememberme,
      padding: EdgeInsets.symmetric(vertical: 2.v),
      onChange: (value) {
        setState(() {
          rememberme = value;
        });
      },
    );
  }

  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }

  void onTapScreenTitleAndRemoveUntill(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      routeName,
      (route) => false,
    );
  }
}

import 'package:flutter/material.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:ppr_disease_reporting/widgets/custom_elevated_button.dart';
import 'package:ppr_disease_reporting/widgets/custom_text_form_field.dart';
import 'register_controller.dart';

class RegisterPage extends StatelessWidget {
  RegisterPage({Key? key})
      : super(
          key: key,
        );

  final RegisterController registerController = RegisterController();

  TextEditingController fullNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: _buildAppBar(context),
        body: Container(
          width: double.maxFinite,
          padding: EdgeInsets.only(
            left: 49.h,
            top: 61.v,
            right: 49.h,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: Text(
                  "Create Account Now!",
                  style: theme.textTheme.displaySmall,
                ),
              ),
              SizedBox(height: 43.v),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Text(
                  "Full Name",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 12.v),
              _buildFullName(context),
              SizedBox(height: 39.v),
              Padding(
                padding: EdgeInsets.only(left: 1.h),
                child: Text(
                  "Email",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 13.v),
              _buildEmail(context),
              SizedBox(height: 36.v),
              Padding(
                padding: EdgeInsets.only(left: 2.h),
                child: Text(
                  "Password",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 11.v),
              _buildPassword(context),
              SizedBox(height: 36.v),
              Padding(
                padding: EdgeInsets.only(left: 6.h),
                child: Text(
                  "Phone No",
                  style: theme.textTheme.titleLarge,
                ),
              ),
              SizedBox(height: 11.v),
              _buildPhone(context),
              SizedBox(height: 54.v),
              _buildSignUp(context),
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

  Widget _buildFullName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        controller: fullNameController,
        borderDecoration: TextFormFieldStyleHelper.fillOnPrimaryContainerTL24,
      ),
    );
  }

  Widget _buildEmail(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: CustomTextFormField(
        controller: emailController,
      ),
    );
  }

  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: CustomTextFormField(
        controller: passwordController,
        obscureText: true,
      ),
    );
  }

  Widget _buildPhone(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: CustomTextFormField(
        controller: phoneController,
        textInputAction: TextInputAction.done,
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return CustomElevatedButton(
      text: "Sign Up",
      margin: EdgeInsets.only(left: 2.h),
      onPressed: () {
        final fullName = fullNameController.text;
        final email = emailController.text;
        final password = passwordController.text;
        final phone = phoneController.text;

        registerController.register(fullName, email, password, phone);
      },
    );
  }
}

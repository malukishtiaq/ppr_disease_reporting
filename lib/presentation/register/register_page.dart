import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/helper/c_n_i_c_formatter.dart';
import 'package:ppr_disease_reporting/models/registration_result.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:ppr_disease_reporting/widgets/custom_elevated_button.dart';
import 'package:ppr_disease_reporting/widgets/custom_text_form_field.dart';
import 'register_controller.dart';

class RegisterPage extends GetView<RegisterController> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController CNICController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Container(
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
                    "CNIC",
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                SizedBox(height: 13.v),
                _buildCNIC(context),
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

  Widget _buildFullName(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        maxLength: 50,
        controller: fullNameController,
        borderDecoration: TextFormFieldStyleHelper.fillOnPrimaryContainerTL24,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your full name';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildCNIC(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: CustomTextFormField(
        controller: CNICController,
        hintText: '12345-1234567-1',
        hintStyle: TextStyle(color: Colors.grey),
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
      ),
    );
  }

  Widget _buildPassword(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: CustomTextFormField(
        controller: passwordController,
        obscureText: true,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your password';
          }

          if (value.length < 3 || value.length > 15) {
            return 'Password must be between 3 and 15 characters';
          }

          return null;
        },
      ),
    );
  }

  Widget _buildPhone(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: CustomTextFormField(
        controller: phoneController,
        textInputAction: TextInputAction.done,
        maxLength: 11,
        textInputType: TextInputType.phone,
        hintText: '03001234567',
        hintStyle: TextStyle(color: Colors.grey),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your phone number';
          }

          RegExp phoneRegex = RegExp(r'^\d{11}$');

          if (!phoneRegex.hasMatch(value)) {
            return 'Invalid phone number format. It should be 11 digits';
          }

          return null;
        },
      ),
    );
  }

  Widget _buildSignUp(BuildContext context) {
    return Stack(
      children: [
        CustomElevatedButton(
          text: "Sign Up",
          margin: EdgeInsets.only(left: 2.h),
          onPressed: () async {
            if (!_validateFields()) {
              return;
            }

            final fullName = fullNameController.text;
            final CNIC = CNICFormatter.saveCNICToDatabase(CNICController.text);
            final password = passwordController.text;
            final phone = phoneController.text;

            try {
              RegistrationResult? result =
                  await controller.register(fullName, CNIC, password, phone);
              if (result == null) {
                return;
              }
              if (result.success) {
                Get.snackbar(
                  'Success',
                  'Registration successful',
                  snackPosition: SnackPosition.BOTTOM,
                );

                onTapScreenTitle(AppRoutes.loginPage);
              } else {
                Get.snackbar(
                  'Error',
                  'Registration failed. ${result.message}',
                  snackPosition: SnackPosition.BOTTOM,
                );
              }
            } catch (e) {
              Get.snackbar(
                'Error',
                'Registration failed. Please try again later.',
                snackPosition: SnackPosition.BOTTOM,
              );
            }
          },
        ),
      ],
    );
  }

  bool _validateFields() {
    if (fullNameController.text.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your full name',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    RegExp cnicRegex = RegExp(r'^\d{5}-\d{7}-\d$');
    if (!cnicRegex.hasMatch(CNICController.text)) {
      Get.snackbar(
        'Error',
        'Invalid CNIC format',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    if (passwordController.text.length < 6) {
      Get.snackbar(
        'Error',
        'Password must be at least 6 characters long',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    String phone = phoneController.text;
    if (phone.isEmpty) {
      Get.snackbar(
        'Error',
        'Please enter your phone number',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    RegExp phoneRegex = RegExp(r'^03\d{2}\d{7}$');
    if (!phoneRegex.hasMatch(phone)) {
      Get.snackbar(
        'Error',
        'Invalid phone number format. Please enter a valid number like 03001234567',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    }

    return true;
  }

  void onTapScreenTitle(String routeName) {
    Get.offNamed(routeName);
  }
}

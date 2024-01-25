import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import '../../provider/user_controller.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'sheep_controller.dart';

class SheepPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: GetBuilder<SheepDataController>(builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      _buildForm(controller, context),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.only(
                          left: 49.h,
                          right: 49.h,
                        ),
                        child: _addOutBreak(controller),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }

  Widget _buildForm(SheepDataController vaccineController, context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.only(
        left: 49.h,
        top: 40.v,
        right: 49.h,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: Text(
              "Add Sheep Info!",
              style: theme.textTheme.displaySmall,
            ),
          ),
          SizedBox(height: 43.v),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Age 0-3 months",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildZeroToThree(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Age 4 to 12 months",
              style: theme.textTheme.titleLarge,
            ),
          ),
          _buildFourToTwele(vaccineController),
          _buildFourToTweleVaccinated(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "12 to 24 months",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _build12To24(vaccineController),
          _build12To24Vaccinated(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "> 24 months",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildGreaterThen24(vaccineController),
          _buildGreaterThen24Vaccinated(vaccineController),
          SizedBox(height: 43.v),
        ],
      ),
    );
  }

  Widget _buildZeroToThree(SheepDataController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        hintText: '0',
        textInputType: TextInputType.phone,
        maxLength: 50,
        controller: vaccineController.ageZeroController,
        borderDecoration: TextFormFieldStyleHelper.fillOnPrimaryContainerTL24,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Total';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildFourToTwele(SheepDataController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        hintText: '0',
        textInputType: TextInputType.phone,
        maxLength: 50,
        controller: vaccineController.age4To12Controller,
        borderDecoration: TextFormFieldStyleHelper.fillOnPrimaryContainerTL24,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Total';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildFourToTweleVaccinated(SheepDataController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        hintText: '0',
        textInputType: TextInputType.phone,
        maxLength: 50,
        controller: vaccineController.age4To12TwoVaccinatedController,
        borderDecoration: TextFormFieldStyleHelper.fillOnPrimaryContainerTL24,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Total';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGreaterThen24(SheepDataController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        hintText: '0',
        textInputType: TextInputType.phone,
        maxLength: 50,
        controller: vaccineController.moreThen24Controller,
        borderDecoration: TextFormFieldStyleHelper.fillOnPrimaryContainerTL24,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter population of goats';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildGreaterThen24Vaccinated(SheepDataController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        hintText: '0',
        textInputType: TextInputType.phone,
        maxLength: 50,
        controller: vaccineController.moreThen24VaccinatedController,
        borderDecoration: TextFormFieldStyleHelper.fillOnPrimaryContainerTL24,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter population of goats';
          }
          return null;
        },
      ),
    );
  }

  Widget _build12To24(SheepDataController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        hintText: '0',
        textInputType: TextInputType.phone,
        maxLength: 50,
        controller: vaccineController.age12To24Controller,
        borderDecoration: TextFormFieldStyleHelper.fillOnPrimaryContainerTL24,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter population of goats';
          }
          return null;
        },
      ),
    );
  }

  Widget _build12To24Vaccinated(SheepDataController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        hintText: '0',
        textInputType: TextInputType.phone,
        maxLength: 50,
        controller: vaccineController.age12To24TwoVaccinatedController,
        borderDecoration: TextFormFieldStyleHelper.fillOnPrimaryContainerTL24,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter population of goats';
          }
          return null;
        },
      ),
    );
  }

  Widget _addOutBreak(SheepDataController vaccineController) {
    return Card(
      color: theme.colorScheme.onPrimary,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              onPressed: () async {
                await vaccineController.onSaveDisease();
              },
              text: "Save",
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      title: AppbarTitle(
        text: "PPR Vaccination",
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

  void _handleLogout() {
    final userController = Get.find<UserController>();
    userController.setUser(null, true);
    Get.offAllNamed(AppRoutes.welcomePage);
  }
}

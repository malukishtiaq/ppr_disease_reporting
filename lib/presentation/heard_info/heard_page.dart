import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import '../../provider/user_controller.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'heard_controller.dart';

class HeardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: GetBuilder<HeardController>(builder: (controller) {
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

  Widget _buildForm(HeardController vaccineController, context) {
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
              "Add Herd Info!",
              style: theme.textTheme.displaySmall,
            ),
          ),
          SizedBox(height: 43.v),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Popupation of Sheep",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildPopulationOfSheep(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "No of Sheep Herds",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildNumberOfSheepHerds(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Population of Goats",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildPopulationOfGoats(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "No of Goats Herds",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildNumberOfGoatHerds(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Present Vaccination Status",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          dropdown(vaccineController),
          SizedBox(height: 25.v),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Last Vaccination Date",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildPhone(vaccineController, context),
          SizedBox(height: 43.v),
        ],
      ),
    );
  }

  Widget dropdown(HeardController controller) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: DropdownButton<String>(
        value: controller.selectedVaccineStatus.value,
        itemHeight: 50,
        style: theme.textTheme.bodyLarge?.copyWith(
          color: ThemeHelper().textColor,
        ),
        onChanged: (String? newValue) {
          if (newValue != null) {
            controller.setSelectedVaccineStatus(newValue);
          }
        },
        items: controller.vaccineStatusOptions.map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(
                value,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: ThemeHelper().textColor,
                ),
              ),
            ),
          );
        }).toList(),
        isExpanded: true,
        underline: Container(),
        dropdownColor: Colors.white,
        iconEnabledColor: ThemeHelper().textColor, //Icon color
      ),
    );
  }

  Widget _buildPopulationOfSheep(HeardController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        textInputType: TextInputType.phone,
        maxLength: 50,
        controller: vaccineController.sheepPopController,
        borderDecoration: TextFormFieldStyleHelper.fillOnPrimaryContainerTL24,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter population of sheep';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPopulationOfGoats(HeardController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        textInputType: TextInputType.phone,
        maxLength: 50,
        controller: vaccineController.goatPopController,
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

  Widget _buildNumberOfGoatHerds(HeardController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        textInputType: TextInputType.phone,
        maxLength: 50,
        controller: vaccineController.noGoatController,
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

  Widget _buildNumberOfSheepHerds(HeardController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        textInputType: TextInputType.phone,
        maxLength: 50,
        controller: vaccineController.noSheepController,
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

  Widget _buildPhone(HeardController vaccineController, context) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: GestureDetector(
        onTap: () => vaccineController.selectDate(context),
        child: AbsorbPointer(
          absorbing: true,
          child: CustomTextFormField(
            controller: vaccineController.lastVaccineController,
            textInputAction: TextInputAction.done,
            maxLength: 11,
            textInputType: TextInputType.phone,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter population of goats';
              }
              return null;
            },
          ),
        ),
      ),
    );
  }

  Widget _addOutBreak(HeardController vaccineController) {
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
              text: "Save Out Break",
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

  void _handleLogout() {
    final userController = Get.find<UserController>();
    userController.setUser(null, true);
    Get.offAllNamed(AppRoutes.welcomePage);
  }
}

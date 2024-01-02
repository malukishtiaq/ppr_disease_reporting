import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../provider/user_controller.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'vaccine_controller.dart';

class VaccinePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: GetBuilder<VaccineController>(builder: (controller) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      Obx(() {
                        return controller.showMap.value
                            ? Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.8,
                                padding: EdgeInsets.only(top: 16.v),
                                child: GoogleMap(
                                  onMapCreated: controller.onMapCreated,
                                  markers: Set.from(controller.markers),
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(33.6844, 73.0479),
                                    zoom: 15.0,
                                  ),
                                  onTap: controller.onMapTap,
                                ),
                              )
                            : _buildForm(controller);
                      }),
                      Container(
                        width: double.maxFinite,
                        padding: EdgeInsets.only(
                          left: 49.h,
                          right: 49.h,
                        ),
                        child: Column(
                          children: [
                            Obx(() {
                              return Text(
                                'Selected Address: ${controller.selectedAddress.value}',
                                style: theme.textTheme.labelLarge,
                                textAlign: TextAlign.center,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              );
                            }),
                            _nextBreak(controller),
                            Obx(() {
                              return controller.showMap.value
                                  ? Container()
                                  : _addOutBreak(controller);
                            }),
                          ],
                        ),
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

  Widget _buildForm(VaccineController vaccineController) {
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
              "Add Vaccine Info!",
              style: theme.textTheme.displaySmall,
            ),
          ),
          SizedBox(height: 43.v),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Tehsil",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildTehsil(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Village",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildVillageName(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Vaccinator Name",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildFullName(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Designation",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildDesignation(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Hospital",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildHospital(vaccineController),
          Padding(
            padding: EdgeInsets.only(left: 2.h),
            child: Text(
              "Contact",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 12.v),
          _buildPhone(vaccineController),
          SizedBox(height: 54.v),
        ],
      ),
    );
  }

  DecoratedBox dropdown() {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: theme.colorScheme.onPrimaryContainer,
        borderRadius: BorderRadius.circular(20.h),
      ),
      child: DropdownButton<String>(
        value: selectedAnimal,
        itemHeight: 50,
        style: TextStyle(
          color: ThemeHelper().textColor,
        ),
        onChanged: (String? newValue) {
          //setState(() {
          selectedAnimal = newValue!;
          //});
        },
        items: <String>['Goat', 'Sheep', 'Other'].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
              ),
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

  String selectedAnimal = "Goat";
  Widget _buildFullName(VaccineController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        maxLength: 50,
        controller: vaccineController.fullNameController,
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

  Widget _buildTehsil(VaccineController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        maxLength: 50,
        controller: vaccineController.tehsilController,
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

  Widget _buildDesignation(VaccineController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        maxLength: 50,
        controller: vaccineController.designationController,
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

  Widget _buildHospital(VaccineController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        maxLength: 50,
        controller: vaccineController.hospitalController,
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

  Widget _buildContact(VaccineController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        maxLength: 50,
        controller: vaccineController.contactController,
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

  Widget _buildVillageName(VaccineController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        maxLength: 50,
        controller: vaccineController.villageNameController,
        borderDecoration: TextFormFieldStyleHelper.fillOnPrimaryContainerTL24,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your village name';
          }
          return null;
        },
      ),
    );
  }

  Widget _buildPhone(VaccineController vaccineController) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: CustomTextFormField(
        controller: vaccineController.contactController,
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

  Widget _nextBreak(VaccineController vaccineController) {
    return Card(
      color: theme.colorScheme.onPrimary,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Obx(() {
              return CustomElevatedButton(
                onPressed: () async {
                  await vaccineController.nextClicked();
                },
                text: vaccineController.showMap.value ? "Next" : "Go to Map",
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _addOutBreak(VaccineController vaccineController) {
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
              text: "Next",
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

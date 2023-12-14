import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../helper/c_n_i_c_formatter.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_text_form_field.dart';
import 'maps_controller.dart';

class MapsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: GetBuilder<MapsController>(builder: (mapsController) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  child: Column(
                    children: [
                      Obx(() {
                        return mapsController.showMap.value
                            ? Container(
                                height: 500,
                                padding: EdgeInsets.symmetric(vertical: 16.v),
                                child: GoogleMap(
                                  onMapCreated: mapsController.onMapCreated,
                                  markers: Set.from(mapsController.markers),
                                  initialCameraPosition: CameraPosition(
                                    target: LatLng(30.3753, 69.3451),
                                    zoom: 15.0,
                                  ),
                                  onTap: mapsController.onMapTap,
                                ),
                              )
                            : _buildForm(mapsController);
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
                                'Selected Address: ${mapsController.selectedAddress.value}',
                                style: theme.textTheme.labelLarge,
                                textAlign: TextAlign.left,
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              );
                            }),
                            _nextBreak(mapsController),
                            Obx(() {
                              return mapsController.showMap.value
                                  ? Container()
                                  : _addOutBreak(mapsController);
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

  Widget _buildForm(MapsController mapsController) {
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
              "Add User Info!",
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
          _buildFullName(mapsController),
          Padding(
            padding: EdgeInsets.only(left: 1.h),
            child: Text(
              "CNIC",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 13.v),
          _buildCNIC(mapsController),
          SizedBox(height: 36.v),
          Padding(
            padding: EdgeInsets.only(left: 6.h),
            child: Text(
              "Phone No",
              style: theme.textTheme.titleLarge,
            ),
          ),
          SizedBox(height: 11.v),
          _buildPhone(mapsController),
          SizedBox(height: 54.v),
        ],
      ),
    );
  }

  Widget _buildFullName(MapsController mapsController) {
    return Padding(
      padding: EdgeInsets.only(left: 1.h),
      child: CustomTextFormField(
        maxLength: 50,
        controller: mapsController.fullNameController,
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

  Widget _buildCNIC(MapsController mapsController) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: CustomTextFormField(
        controller: mapsController.CNICController,
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

  Widget _buildPhone(MapsController mapsController) {
    return Padding(
      padding: EdgeInsets.only(left: 2.h),
      child: CustomTextFormField(
        controller: mapsController.phoneController,
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

  Widget _nextBreak(MapsController mapsController) {
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
                  await mapsController.nextClicked();
                },
                text: mapsController.showMap.value ? "Next" : "Go to Map",
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _addOutBreak(MapsController mapsController) {
    return Card(
      color: theme.colorScheme.onPrimary,
      child: Container(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              onPressed: () async {
                await mapsController.onSaveDisease();
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
        AppbarTrailingImage(
          imagePath: ImageConstant.imgPepiconsPopMenu,
          margin: EdgeInsets.fromLTRB(34.h, 5.v, 34.h, 10.v),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../widgets/custom_elevated_button.dart';
import 'maps_controller.dart';

class MapsPage extends StatelessWidget {
  final MapsController mapsController = Get.put(MapsController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Obx(() {
              return Expanded(
                child: Container(
                  color: Colors.white,
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
                ),
              );
            }),
            Builder(
              builder: (context) {
                return Obx(() {
                  return Text(
                    'Selected Address: ${mapsController.selectedAddress.value}',
                    style: theme.textTheme.labelLarge,
                    textAlign: TextAlign.left,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                  );
                });
              },
            ),
            _addOutBreak(),
          ],
        ),
      ),
    );
  }

  Widget _addOutBreak() {
    return Card(
      color: theme.colorScheme.onPrimary,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomElevatedButton(
              onPressed: () async {
                await mapsController.onSaveDisease();
              },
              text: "Save location",
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

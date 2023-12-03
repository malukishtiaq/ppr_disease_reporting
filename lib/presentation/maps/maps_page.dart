import 'package:flutter/material.dart';
import 'package:ppr_disease_reporting/core/app_export.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_title.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/appbar_trailing_image.dart';
import 'package:ppr_disease_reporting/widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_text_form_field.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart';

class MapsPage extends StatefulWidget {
  MapsPage({Key? key})
      : super(
          key: key,
        );

  @override
  State<MapsPage> createState() => _MapsPageState();
}

class _MapsPageState extends State<MapsPage> {
  final Set<Marker> _markers = {};

  GoogleMapController? _mapController;

  TextEditingController _searchController = TextEditingController();

  String _selectedAddress = '';

  bool rememberme = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    mediaQueryData = MediaQuery.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 6.h),
              child: CustomTextFormField(
                controller: _searchController,
                suffix: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    _searchLocation();
                  },
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(
                    horizontal: 50.h,
                    vertical: 16.v,
                  ),
                  child: Column(
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: GoogleMap(
                          onMapCreated: (controller) {
                            setState(() {
                              _mapController = controller;
                            });
                          },
                          markers: _markers,
                          initialCameraPosition: CameraPosition(
                            target: LatLng(37.7749, -122.4194),
                            zoom: 15.0,
                          ),
                          onTap: (LatLng latLng) {
                            _addMarker(latLng);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Text(
              'Selected Address: $_selectedAddress',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }

  void _addMarker(LatLng latLng) {
    setState(() {
      _markers.clear();
      _markers.add(
        Marker(
          markerId: MarkerId('selected_location'),
          position: latLng,
        ),
      );
    });

    _getAddressFromLatLng(latLng);
  }

  Future<void> _searchLocation() async {
    try {
      List<Location> locations =
          await locationFromAddress(_searchController.text);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        _mapController?.animateCamera(
          CameraUpdate.newLatLngZoom(
            LatLng(location.latitude!, location.longitude!),
            15.0,
          ),
        );
        _addMarker(LatLng(location.latitude!, location.longitude!));
      }
    } catch (e) {
      print('Error searching location: $e');
    }
  }

  void _getAddressFromLatLng(LatLng latLng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );
      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        setState(() {
          _selectedAddress = placemark.street ?? '';
        });
      }
    } catch (e) {
      print('Error fetching address: $e');
    }
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

  void onTapScreenTitle(
    BuildContext context,
    String routeName,
  ) {
    Navigator.pushNamed(context, routeName);
  }
}

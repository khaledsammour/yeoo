import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';
import 'package:yeeo/pressentation/widget/locationDialogViewModel.dart';

double? latitude, longitude;

class LocationDialog extends StatelessWidget {
  const LocationDialog({Key? key, required this.onTap}) : super(key: key);
  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationDialogViewModel>(
        init: LocationDialogViewModel(),
        builder: (controller) {
          return Container(
              margin: EdgeInsets.symmetric(
                  vertical: MediaQuery.of(context).size.height * .04),
              child: Material(
                child: Stack(
                  children: [
                    GoogleMap(
                      zoomControlsEnabled: true,
                      mapType: MapType.normal,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              controller.vlatitude, controller.vlongitude),
                          zoom: controller.zoom),
                      onMapCreated: (GoogleMapController googleMapController) {
                        controller.onMapCreated();
                        controller.mapController = googleMapController;
                      },
                      markers: controller.myMarker,
                      onCameraMove: (v) {
                        controller.onCameraMove(
                            v.target.latitude, v.target.longitude);
                        latitude = v.target.latitude;
                        longitude = v.target.longitude;
                      },
                    ),
                    Positioned(
                      left: 10,
                      top: 30,
                      child: GestureDetector(
                        onTap: () {
                          Get.back();
                        },
                        child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all()),
                          alignment: Alignment.topLeft,
                          child: Center(child: Icon(Icons.arrow_back_ios_new)),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: 5,
                      right: 60,
                      child: GestureDetector(
                        onTap: onTap,
                        child: Container(
                          height: 60.h,
                          decoration: BoxDecoration(
                              color: ColorManager.yellow,
                              border: Border.all(),
                              borderRadius: BorderRadius.circular(60.r)),
                          child: Center(
                            child: FlexText(
                              title: 'Choose Current Location',
                              style: getBoldStyle(color: ColorManager.black),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 110,
                      left: MediaQuery.of(context).size.width - 60,
                      right: 10,
                      child: Container(
                          height: 50.h,
                          width: 50.w,
                          decoration: BoxDecoration(
                              color: ColorManager.primary,
                              borderRadius: BorderRadius.circular(20.r),
                              border: Border.all()),
                          child: IconButton(
                            icon: Icon(
                              Icons.location_on,
                              color: Colors.red,
                            ),
                            onPressed: () async {
                              await controller.getGeoLocationPosition();
                              await controller.moveCamera(
                                  controller.currentLatiude,
                                  controller.currentLongtiude,
                                  18.0);
                            },
                          )),
                    ),
                  ],
                ),
              ));
        });
  }
}

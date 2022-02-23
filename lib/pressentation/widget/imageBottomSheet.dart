import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';

class ImageBottomSheet extends StatelessWidget {
  const ImageBottomSheet(
      {Key? key, required this.onCameraTap, required this.onGallaryTap})
      : super(key: key);
  final Function()? onCameraTap;
  final Function()? onGallaryTap;
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(color: ColorManager.whiteWithOpecity1),
        height: MediaQuery.of(context).copyWith().size.height * .26,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(AppPadding.p12),
              height: MediaQuery.of(context).copyWith().size.height * .05,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlexText(
                    title: "Select Image",
                    style: getRegularSalsaStyle(
                        color: ColorManager.black, fontSize: FontSize.s16),
                  ),
                  IconButton(
                      padding: EdgeInsets.all(0),
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(Icons.clear_outlined))
                ],
              ),
            ),
            Container(
              height: MediaQuery.of(context).copyWith().size.height * .2,
              child: Row(
                children: [
                  Spacer(
                    flex: 1,
                  ),
                  Flexible(
                    flex: 10,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: onCameraTap,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.w, color: ColorManager.yellow)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.camera,
                              color: ColorManager.yellow,
                              size: 50.w,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            FlexText(
                              title: "Camera",
                              style: getBoldStyle(color: ColorManager.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Flexible(
                    flex: 10,
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      onTap: onGallaryTap,
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 2.w, color: ColorManager.yellow)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.photo,
                              color: ColorManager.yellow,
                              size: 50.w,
                            ),
                            SizedBox(
                              height: 5.h,
                            ),
                            FlexText(
                              title: "Gallary",
                              style: getBoldStyle(color: ColorManager.black),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Spacer(
                    flex: 1,
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}

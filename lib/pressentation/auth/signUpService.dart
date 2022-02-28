import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/authViewModel.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';
import 'package:yeeo/pressentation/widget/flexTextFiled.dart';
import 'package:yeeo/pressentation/widget/imageBottomSheet.dart';
import 'package:yeeo/pressentation/widget/locationBottomSheet.dart';

class SignupServiceView extends StatelessWidget {
  const SignupServiceView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.only(right: 178.w),
              height: 1003.h,
              width: 246.w,
              child: Image.asset(
                ImageStrings.rectangle,
                fit: BoxFit.fill,
              ),
            ),
            GetBuilder<AuthViewModel>(
              init: AuthViewModel(),
              builder: (controller) => GestureDetector(
                onTap: () {
                  controller.focusNode.unfocus();
                  controller.update();
                },
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 44.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 235.w),
                        height: 114.75.h,
                        width: 137.7.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(ImageStrings.bigPolygon),
                                fit: BoxFit.contain)),
                      ),
                      SizedBox(
                        height: 28.25.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 113.w),
                        height: 73.h,
                        width: 205.w,
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                          image: AssetImage(
                            ImageStrings.yeeo,
                          ),
                          fit: BoxFit.contain,
                        )),
                      ),
                      SizedBox(
                        height: 73.h,
                      ),
                      _textFill(
                        validator: (p0) {},
                        title: "Company",
                        textInputType: TextInputType.name,
                        autofillHints: AutofillHints.username,
                        onChanged: (vlaue) {
                          controller.userName = vlaue;
                        },
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 27.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 21.h,
                              width: 88.w,
                              child: FlexText(
                                title: "Password",
                                style:
                                    getMPlus1cStyle(color: ColorManager.black),
                              ),
                            ),
                            FlexTextFiled(
                              validator: (value) {
                                if (value!.length < 7) {
                                  return 'Password must be at least 7 characters long';
                                } else {
                                  return null;
                                }
                              },
                              textInputType: TextInputType.visiblePassword,
                              autofillHints: "",
                              left: 15,
                              onChanged: (v) {
                                controller.password = v;
                              },
                              password: true,
                              obscureText: controller.pass,
                              onEyeTap: () {
                                controller.pass = !controller.pass;
                                controller.update();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 27.w),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 42.h,
                              width: 88.w,
                              child: FlexText(
                                title: Strings.confirmPassword,
                                style: getMPlus1cStyle(
                                  color: ColorManager.black,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 15.w,
                            ),
                            FlexTextFiled(
                              validator: (p0) {
                                if (controller.confirmPass !=
                                    controller.password) {
                                  return 'Password is not the same';
                                } else {
                                  null;
                                }
                              },
                              onChanged: (value) {
                                controller.password == value
                                    ? controller.notSame = true
                                    : controller.notSame = false;
                              },
                              autofillHints: "",
                              textInputType: TextInputType.visiblePassword,
                              left: 0,
                              password: true,
                              obscureText: controller.confirmPass,
                              onEyeTap: () {
                                controller.confirmPass =
                                    !controller.confirmPass;
                                controller.update();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      _textFill(
                        validator: (p0) {},
                        title: "phone number",
                        textInputType: TextInputType.emailAddress,
                        autofillHints: AutofillHints.email,
                        onChanged: (vlaue) {
                          controller.phoneNumber = vlaue;
                        },
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      _textFill(
                        validator: (p0) {},
                        title: "job title",
                        textInputType: TextInputType.emailAddress,
                        autofillHints: AutofillHints.email,
                        onChanged: (vlaue) {
                          controller.jobTitle = vlaue;
                        },
                      ),
                      SizedBox(
                        height: 22.h,
                      ),
                      _tradeLicense(
                        title: "Trade license",
                        onChanged: (p0) {},
                      ),
                      SizedBox(
                        height: 14.h,
                      ),
                      _companyLogo(
                        title: "company logo",
                        height: 69,
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      _location(),
                      SizedBox(
                        height: 23.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 152.w),
                        height: 38.h,
                        width: 123.w,
                        decoration: BoxDecoration(
                            border: Border.all(color: ColorManager.black),
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20.r),
                            boxShadow: const [
                              BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 6,
                                  offset: Offset(0, 2))
                            ]),
                        child: InkWell(
                          onTap: () {
                            controller.notSame == true &&
                                    controller.privacy == true &&
                                    controller.terms == true
                                ? controller.signUpService()
                                : Get.snackbar("wrong",
                                    "please make sure you did every thing right");
                          },
                          child: Ink(
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 39.w, vertical: 6.h),
                              child: FlexText(
                                title: Strings.start,
                                style: getMeduimStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s18),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      _termsPrivacy(() {
                        controller.terms = !controller.terms;
                        controller.update();
                      }, Strings.termsAndConditions, controller.terms),
                      SizedBox(
                        height: 2.h,
                      ),
                      _termsPrivacy(() {
                        controller.privacy = !controller.privacy;
                        controller.update();
                      }, Strings.privacyPolicy, controller.privacy),
                      SizedBox(
                        height: 8.h,
                      ),
                      Container(
                          margin: EdgeInsets.only(left: 132.w),
                          height: 16.h,
                          width: 167.w,
                          child: FlexText(
                            title: Strings.copyright,
                            style: getBoldStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s14),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _termsPrivacy(
    void Function() onTap,
    String title,
    bool type,
  ) {
    return GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (controller) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: 125.w,
              ),
              InkWell(
                onTap: onTap,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 9.h,
                      width: 27.w,
                      decoration: BoxDecoration(
                          color: type
                              ? ColorManager.yellow
                              : ColorManager.whiteWithOpecity1,
                          border: Border.all(color: ColorManager.black),
                          borderRadius: BorderRadius.circular(30.r)),
                    ),
                    SizedBox(
                      width: 9.w,
                    ),
                    Container(
                      height: 21.h,
                      width: 127.w,
                      child: AutoSizeText(
                        title,
                        textAlign: TextAlign.start,
                        style: getMPlusStyle(color: ColorManager.black),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }

  Widget _textFill(
      {String? title,
      TextInputType? textInputType,
      String? autofillHints,
      required String? Function(String?)? validator,
      Function(String)? onChanged}) {
    return Container(
      margin: EdgeInsets.only(left: 27.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Container(
            height: 21.h,
            width: 88.w,
            child: FlexText(
              title: title!,
              style: getMPlus1cStyle(color: ColorManager.black),
            ),
          ),
          FlexTextFiled(
            validator: validator,
            textInputType: textInputType!,
            autofillHints: autofillHints!,
            left: 15,
            onChanged: onChanged!,
          ),
        ],
      ),
    );
  }

  Widget _companyLogo({String? title, double? height}) {
    return GetBuilder<AuthViewModel>(builder: (controller) {
      return Container(
        margin: EdgeInsets.only(left: 27.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 21.h,
              width: 88.w,
              child: FlexText(
                title: title!,
                style: getMPlus1cStyle(color: ColorManager.black),
              ),
            ),
            Container(
              height: height!.h,
              width: 80.w,
              margin: EdgeInsets.only(left: 21.w),
              decoration: BoxDecoration(
                  color: ColorManager.filterItemColor,
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(30.r)),
              child: Center(
                child: controller.companyLogo == null
                    ? GestureDetector(
                        onTap: () {
                          Get.bottomSheet(ImageBottomSheet(
                            onCameraTap: () {
                              controller.getImageLogoFromCamera();
                            },
                            onGallaryTap: () {
                              controller.getImageLogo();
                            },
                          ));
                        },
                        child: Container(
                          height: 20.h,
                          width: 22.w,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  ImageStrings.addImage,
                                ),
                                fit: BoxFit.contain),
                          ),
                        ))
                    : Image.file(
                        File(
                          controller.companyLogo,
                        ),
                        fit: BoxFit.fill,
                      ),
              ),
            ),
          ],
        ),
      );
    });
  }

  _location() {
    return GetBuilder<AuthViewModel>(
        init: AuthViewModel(),
        builder: (controller) {
          return Container(
            margin: EdgeInsets.only(left: 27.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 21.h,
                  width: 88.w,
                  child: FlexText(
                    title: "Location",
                    style: getMPlus1cStyle(color: ColorManager.black),
                  ),
                ),
                Container(
                  height: 32.h,
                  width: 80.w,
                  margin: EdgeInsets.only(left: 21.w),
                  decoration: BoxDecoration(
                      color: ColorManager.filterItemColor,
                      border: Border.all(),
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Center(
                      child: GestureDetector(
                          onTap: () {
                            Get.dialog(LocationDialog(
                              onTap: () {
                                controller.latitude = latitude!;
                                controller.longitude = longitude!;
                                controller.getAddressFromLatLong();
                                controller.update();
                                Get.back();
                                latitude = null;
                                longitude = null;
                              },
                            ));
                          },
                          child: Container(
                            height: 20.h,
                            width: 22.w,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                    ImageStrings.addImage,
                                  ),
                                  fit: BoxFit.contain),
                            ),
                          ))),
                ),
                SizedBox(
                  width: 20.w,
                ),
                controller.cityName == null
                    ? Container(
                        height: 0.h,
                        width: 0.w,
                      )
                    : FlexText(
                        title:
                            controller.cityName! + "," + controller.areaName!,
                        style: getMeduimStyle(color: ColorManager.black)),
              ],
            ),
          );
        });
  }

  Widget _tradeLicense({String? title, Function(String)? onChanged}) {
    return Builder(builder: (context) {
      return GetBuilder<AuthViewModel>(builder: (controller) {
        return Container(
          margin: EdgeInsets.only(left: 27.w),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 21.h,
                width: 88.w,
                child: FlexText(
                  title: title!,
                  style: getMPlus1cStyle(color: ColorManager.black),
                ),
              ),
              Container(
                height: 27.h,
                width: 199.w,
                margin: EdgeInsets.only(left: 21.w),
                decoration: BoxDecoration(
                    color: ColorManager.filterItemColor,
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(30.r)),
                child: Row(
                  children: [
                    SizedBox(
                      width: 12.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.bottomSheet(ImageBottomSheet(onCameraTap: () {
                          controller.getImageFromCamera();
                        }, onGallaryTap: () {
                          controller.getImage();
                        }));
                      },
                      child: Container(
                        height: 20.h,
                        width: 22.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                ImageStrings.addImage,
                              ),
                              fit: BoxFit.contain),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 7.h),
                      width: 150.w,
                      child: ListView.builder(
                          itemCount: controller.img.length == null
                              ? 0
                              : controller.img.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                Container(
                                  width: 11.w,
                                  decoration: BoxDecoration(
                                      border:
                                          Border.all(color: ColorManager.grey),
                                      borderRadius: BorderRadius.circular(3.r)),
                                  child: controller.img == null
                                      ? Text("no file")
                                      : Image.file(
                                          File(
                                            controller.img[index],
                                          ),
                                          fit: BoxFit.fill,
                                        ),
                                ),
                                SizedBox(
                                  width: 10.w,
                                )
                              ],
                            );
                          }),
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      });
    });
  }
}

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
                                fit: BoxFit.fill)),
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
                          fit: BoxFit.fill,
                        )),
                      ),
                      SizedBox(
                        height: 73.h,
                      ),
                      _textFill(
                        focusNode: controller.focusNode,
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
                      _textFill(
                        focusNode: controller.focusNode,
                        title: Strings.password,
                        textInputType: TextInputType.visiblePassword,
                        autofillHints: AutofillHints.password,
                        onChanged: (vlaue) {
                          controller.password = vlaue;
                        },
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
                            Container(
                              height: 27.h,
                              width: 199.w,
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
                              child: TextField(
                                onChanged: (value) {
                                  controller.password == value
                                      ? controller.notSame = true
                                      : controller.notSame = false;
                                },
                                style:
                                    getMeduimStyle(color: ColorManager.black),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 27 / 2.h, horizontal: 5.w),
                                  hintStyle: TextStyle(color: Colors.black38),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 7.h,
                      ),
                      _textFill(
                        focusNode: controller.focusNode,
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
                        focusNode: controller.focusNode,
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
                      _plus(
                        title: "company logo",
                        height: 69,
                        onChanged: (vlaue) {
                          controller.companyLogo = vlaue;
                        },
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      _plus(
                        title: "Location",
                        height: 32,
                        onChanged: (vlaue) {
                          controller.phoneNumber = vlaue;
                        },
                      ),
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
          return InkWell(
            onTap: onTap,
            child: Container(
              margin: EdgeInsets.only(left: 125.w),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
          );
        });
  }

  Widget _textFill(
      {String? title,
      TextInputType? textInputType,
      String? autofillHints,
      required FocusNode focusNode,
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
            textInputType: textInputType!,
            autofillHints: autofillHints!,
            left: 15,
            onChanged: onChanged!,
          ),
        ],
      ),
    );
  }

  Widget _plus({String? title, double? height, Function(String)? onChanged}) {
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
                          controller.getImageLogo();
                          controller.update();
                        },
                        child: Icon(Icons.plus_one_outlined))
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
                        Get.bottomSheet(Container(
                            decoration: BoxDecoration(
                                color: ColorManager.whiteWithOpecity1),
                            height:
                                MediaQuery.of(context).copyWith().size.height *
                                    .26,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.all(AppPadding.p12),
                                  height: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      .05,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Select Image",
                                        overflow: TextOverflow.visible,
                                        style: getRegularSalsaStyle(
                                            color: ColorManager.black,
                                            fontSize: FontSize.s16),
                                      ),
                                      IconButton(
                                          padding: EdgeInsets.all(0),
                                          onPressed: () {
                                            Get.back();
                                          },
                                          icon: Icon(Icons
                                              .cancel_presentation_rounded))
                                    ],
                                  ),
                                ),
                                Container(
                                  height: MediaQuery.of(context)
                                          .copyWith()
                                          .size
                                          .height *
                                      .2,
                                  child: Row(
                                    children: [
                                      Flexible(
                                        flex: 10,
                                        fit: FlexFit.tight,
                                        child: GestureDetector(
                                          onTap: () async {
                                            controller.getImageFromCamera();

                                            controller.update();
                                          },
                                          child: Container(
                                            color: Colors.blueGrey,
                                            child: Center(
                                              child: Text(
                                                "Camera",
                                              ),
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
                                          onTap: () async {
                                            controller.getImage();
                                            controller.update();
                                          },
                                          child: Container(
                                            color: Colors.red,
                                            child: Center(
                                              child: Text(
                                                "Gallary",
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )));
                      },
                      child: Container(
                        height: 20.h,
                        width: 22.w,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                                ImageStrings.addImage,
                              ),
                              fit: BoxFit.fill),
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

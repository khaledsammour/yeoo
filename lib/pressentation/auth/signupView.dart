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

class SignupView extends StatelessWidget {
  const SignupView({Key? key}) : super(key: key);

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
              builder: (controller) => SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 29.h,
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
                      height: 74.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 145.w),
                      height: 42.h,
                      width: 141.w,
                      child: FlexText(
                        title: Strings.signup,
                        style: getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s36),
                      ),
                    ),
                    SizedBox(
                      height: 50.h,
                    ),
                    _textFill(
                      focusNode: controller.focusNode,
                      title: Strings.userName,
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
                            height: 54.h,
                            width: 81.w,
                            child: FlexText(
                              title: Strings.confirmPassword,
                              style: getMeduimStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s18),
                            ),
                          ),
                          SizedBox(
                            width: 26.w,
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
                              style: getMeduimStyle(color: ColorManager.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 15.h, horizontal: 5.w),
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
                      title: Strings.email,
                      textInputType: TextInputType.emailAddress,
                      autofillHints: AutofillHints.email,
                      onChanged: (vlaue) {
                        controller.email = vlaue;
                      },
                    ),
                    SizedBox(
                      height: 57.h,
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
                              ? controller.signUpUser()
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
                      height: 50.h,
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
                      height: 60.h,
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
        children: [
          Container(
            height: 27.h,
            width: 83.w,
            child: FlexText(
              title: title!,
              style: getMeduimStyle(
                  color: ColorManager.black, fontSize: FontSize.s18),
            ),
          ),
          FlexTextFiled(
            textInputType: textInputType!,
            autofillHints: autofillHints!,
            left: 26,
            onChanged: onChanged!,
          ),
        ],
      ),
    );
  }
}

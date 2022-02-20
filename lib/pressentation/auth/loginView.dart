import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/authViewModel.dart';
import 'package:yeeo/pressentation/auth/loading.dart';
import 'package:yeeo/pressentation/auth/signUpService.dart';
import 'package:yeeo/pressentation/auth/signupView.dart';
import 'package:yeeo/pressentation/control/userControl/controlView.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/user/userView.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';
import 'package:yeeo/pressentation/widget/flexTextFiled.dart';

class LoginView extends StatelessWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(children: [
          Container(
            margin: EdgeInsets.only(right: 228.w),
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
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 141.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 197.w),
                      height: 114.75.h,
                      width: 137.7.w,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImageStrings.bigPolygon),
                              fit: BoxFit.contain)),
                    ),
                    SizedBox(
                      height: 29.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 84.w),
                      width: 205.w,
                      height: 73.h,
                      decoration: const BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(ImageStrings.yeeo),
                              alignment: Alignment.centerLeft)),
                    ),
                    SizedBox(
                      height: 95.h,
                    ),
                    Container(
                      height: 37.h,
                      margin: EdgeInsets.only(left: 135.w, right: 33.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.userSelected = true;
                              controller.update();
                            },
                            child: Container(
                              width: 44.w,
                              child: Column(
                                children: [
                                  SizedBox(
                                    width: 44.w,
                                    height: 18.h,
                                    child: FlexText(
                                      title: Strings.user,
                                      style: getMeduimStyle(
                                          color: ColorManager.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 3.h,
                                  ),
                                  Container(
                                    width: 14.w,
                                    margin: EdgeInsets.only(right: 20.w),
                                    height: controller.userSelected ? 1.h : 0.h,
                                    color: ColorManager.black,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Stack(
                            children: [
                              Container(
                                alignment: Alignment.centerLeft,
                                margin: controller.userSelected
                                    ? EdgeInsets.only(bottom: 15.h)
                                    : EdgeInsets.only(top: 15.h),
                                child: Image.asset(
                                  controller.userSelected
                                      ? ImageStrings.selectedUser
                                      : ImageStrings.unselectedUser,
                                  height: 22.79.h,
                                  width: 31.60.w,
                                  fit: BoxFit.contain,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 20.w),
                                margin: controller.userSelected
                                    ? EdgeInsets.only(top: 15.h)
                                    : EdgeInsets.only(bottom: 15.h),
                                child: Image.asset(
                                  controller.userSelected
                                      ? ImageStrings.selectedService
                                      : ImageStrings.unselectedService,
                                  width: 30.61.w,
                                  height: 19.07.h,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            width: 15.77.w,
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.userSelected = false;
                              controller.update();
                            },
                            child: SizedBox(
                              width: 113.w,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 18.h,
                                    child: FlexText(
                                      title: Strings.serviceProvider,
                                      style: getMeduimStyle(
                                          color: ColorManager.black),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 6.h,
                                  ),
                                  Container(
                                    width: 70.w,
                                    margin: EdgeInsets.only(left: 0.w),
                                    height: controller.userSelected ? 0.h : 1.h,
                                    color: ColorManager.black,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 98.w),
                        width: 65.w,
                        height: 41.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.userSelected
                                    ? controller.signInUser()
                                    : controller.loginService();
                              },
                              child: FlexText(
                                title: Strings.login,
                                style: getBoldStyle(color: ColorManager.black),
                              ),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            Container(
                              width: 14.w,
                              height: 1.h,
                              color: ColorManager.black,
                            )
                          ],
                        )),
                    SizedBox(
                      height: 4.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 99.w),
                      width: 83.w,
                      height: 18.h,
                      child: FlexText(
                        title: Strings.userName,
                        style: getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s12),
                      ),
                    ),
                    SizedBox(
                      height: 3.h,
                    ),
                    FlexTextFiled(
                      textInputType: TextInputType.name,
                      autofillHints: AutofillHints.username,
                      left: 99,
                      onChanged: (value) {
                        controller.email = value;
                        controller.userName = value;
                      },
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    FlexTextFiled(
                      textInputType: TextInputType.visiblePassword,
                      autofillHints: AutofillHints.password,
                      left: 99,
                      obscureText: true,
                      onChanged: (value) {
                        controller.password = value;
                      },
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 99.w),
                      width: 83.w,
                      height: 18.h,
                      child: FlexText(
                        title: Strings.password,
                        style: getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s12),
                      ),
                    ),
                    SizedBox(
                      height: 18.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 210.w),
                      width: 20.w,
                      height: 21.h,
                      alignment: Alignment.center,
                      child: FlexText(
                        title: Strings.or,
                        style: getBoldStyle(color: ColorManager.black),
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 22.w),
                      width: 396.w,
                      height: 28.h,
                      child: FlexText(
                        title: Strings.loginDesc,
                        textAlign: TextAlign.center,
                        style: getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s12),
                      ),
                    ),
                    SizedBox(
                      height: 7.h,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 169.w),
                        width: 102.w,
                        height: 32.h,
                        child: Image.asset(
                          ImageStrings.google,
                          fit: BoxFit.fill,
                        )),
                    SizedBox(
                      height: 7.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 185.w),
                      width: 69.w,
                      height: 21.h,
                      child: GestureDetector(
                        onTap: () {
                          controller.userSelected
                              ? Get.to(const SignupView())
                              : Get.to(SignupServiceView());
                        },
                        child: FlexText(
                          title: Strings.signup,
                          style: getBoldStyle(color: ColorManager.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 60.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 136.w),
                      width: 167.w,
                      height: 16.h,
                      alignment: Alignment.center,
                      child: FlexText(
                        title: Strings.copyright,
                        textAlign: TextAlign.center,
                        style: getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s14),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

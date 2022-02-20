import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/loading.dart';
import 'package:yeeo/pressentation/auth/loginView.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';
import 'package:yeeo/pressentation/control/serviceProviderControl/chat/serviceProviderChatView.dart';
import 'package:yeeo/pressentation/control/userControl/chat/chatView.dart';
import 'package:yeeo/pressentation/control/serviceProviderControl/controlViewModelService.dart';
import 'package:yeeo/pressentation/control/menuView.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';

import '../userControl/controlViewModel.dart';

class ControlViewService extends StatelessWidget {
  final LocalStorageData localStorageData = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlViewModelService>(
      init: ControlViewModelService(),
      builder: (controller) => controller.loading.value
          ? LoadingView()
          : Scaffold(
              backgroundColor: ColorManager.primary,
              appBar: appBar(),
              body: controller.currentScreen,
              bottomNavigationBar: bottomNavigatorBar(),
            ),
    );
  }

  PreferredSizeWidget appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: ColorManager.primary,
      elevation: 0,
      title: Row(
        children: [
          Flexible(
            flex: 1,
            child: Image.asset(ImageStrings.yeeo),
          ),
          Flexible(
            flex: 4,
            child: Image.asset(ImageStrings.arrow),
          ),
        ],
      ),
      actions: [
        Builder(builder: (context) {
          return GetBuilder<ControlViewModelService>(
              init: ControlViewModelService(),
              builder: (controller) {
                return GestureDetector(
                  onTap: () {
                    controller.currentScreen = MenuView(
                      onLogOut: () {
                        controller.localStorageData.deleteUser();
                        Get.offAll(LoginView());
                      },
                    );
                    controller.update();
                  },
                  child: Container(
                      margin: EdgeInsets.only(right: 6.r),
                      height: 36.h,
                      width: 36.w,
                      child: Image.asset(ImageStrings.menu)),
                );
              });
        }),
        GetBuilder<ControlViewModelService>(
            init: ControlViewModelService(),
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  controller.currentScreen = ServiceProviderChatView();
                  controller.update();
                },
                child: Container(
                    margin: EdgeInsets.only(right: 6.r),
                    height: 29.42.h,
                    width: 34.85.w,
                    child: Column(
                      children: [
                        FlexText(
                            title: "105",
                            style: getMPlus1cStyle(
                                color: ColorManager.red,
                                fontSize: FontSize.s10)),
                        Image.asset(
                          ImageStrings.messagePolygon,
                          fit: BoxFit.fill,
                        ),
                      ],
                    )),
              );
            }),
      ],
    );
  }

  Widget bottomNavigatorBar() {
    return GetBuilder<ControlViewModelService>(
      init: ControlViewModelService(),
      builder: (controller) => Container(
        height: 55.h,
        child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    height: 32.h,
                    width: 36.w,
                    child: Image.asset(
                      controller.navigatorValue == 0
                          ? ImageStrings.services
                          : ImageStrings.services,
                      fit: BoxFit.fill,
                    ),
                  ),
                  title: Container(height: 0.0)),
              BottomNavigationBarItem(
                  icon: Container(
                    height: 32.h,
                    width: 36.w,
                    child: Image.asset(
                      controller.navigatorValue == 1
                          ? ImageStrings.starService
                          : ImageStrings.starService,
                      fit: BoxFit.fill,
                    ),
                  ),
                  title: Container(height: 0.0)),
            ],
            backgroundColor: ColorManager.primary,
            elevation: 0,
            currentIndex: controller.navigatorValue,
            onTap: (index) => controller.changeSelectedValue(index)),
      ),
    );
  }
}

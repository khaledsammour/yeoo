import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/loading.dart';
import 'package:yeeo/pressentation/auth/loginView.dart';
import 'package:yeeo/pressentation/auth/service/localStorageData.dart';
import 'package:yeeo/pressentation/control/chat/chatDetailView.dart';
import 'package:yeeo/pressentation/control/userControl/chat/chatView.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';

import 'controlViewModel.dart';
import '../menuView.dart';

class ControlView extends StatelessWidget {
  final LocalStorageData localStorageData = Get.find();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
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
          return GetBuilder<ControlViewModel>(
              init: ControlViewModel(),
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
        GetBuilder<ControlViewModel>(
            init: ControlViewModel(),
            builder: (controller) {
              return GestureDetector(
                onTap: () {
                  controller.currentScreen = ChatView();
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
    return GetBuilder<ControlViewModel>(
      init: ControlViewModel(),
      builder: (controller) => Container(
        height: 55.h,
        child: BottomNavigationBar(
            items: [
              BottomNavigationBarItem(
                  icon: Container(
                    height: 34.h,
                    width: 27.w,
                    child: Image.asset(
                      controller.navigatorValue == 0
                          ? ImageStrings.addEnabled
                          : ImageStrings.addDisable,
                      fit: BoxFit.fill,
                    ),
                  ),
                  title: Container(height: 0.0)),
              BottomNavigationBarItem(
                  icon: Container(
                    height: 25.81.h,
                    width: 42.w,
                    child: Image.asset(
                      controller.navigatorValue == 1
                          ? ImageStrings.historyEnable
                          : ImageStrings.historyDisable,
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

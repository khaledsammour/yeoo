import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yeeo/pressentation/auth/loading.dart';
import 'package:yeeo/pressentation/auth/userModel.dart';
import 'package:yeeo/pressentation/control/serviceProviderControl/controlViewModelService.dart';
import 'package:yeeo/pressentation/control/userControl/chat/chatView.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/serviceProvider/onGoingViewModel.dart';
import 'package:yeeo/pressentation/serviceProvider/replyModel.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';
import 'package:yeeo/pressentation/widget/loadingWidget.dart';
import 'package:yeeo/pressentation/widget/ratingView.dart';

import '../control/serviceProviderControl/chat/serviceProviderChatView.dart';

class OngoingView extends StatelessWidget {
  const OngoingView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<OnGoingViewModel>(
        init: OnGoingViewModel(),
        builder: (controller) => controller.loading.value
            ? LoadingWidget()
            : Column(
                children: [
                  Container(
                    height: 40.h,
                    decoration: BoxDecoration(boxShadow: [_boxShadow()]),
                    child: Row(
                      children: [
                        Container(
                          width: 267.w,
                          decoration: BoxDecoration(
                            color: ColorManager.yellow,
                          ),
                          child: Center(
                            child: Text(
                              'ALL',
                              style: getRegularSalsaStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s24),
                            ),
                          ),
                        ),
                        Container(
                          width: 147.w,
                          decoration: BoxDecoration(
                            color: ColorManager.whiteWithOpecity1,
                          ),
                          child: Center(
                            child: Image.asset(ImageStrings.like),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.filter
                          ? controller.filter = false
                          : controller.filter = true;
                      controller.update();
                    },
                    child: Container(
                        margin: EdgeInsets.only(left: 309.w),
                        height: 28.h,
                        width: 74.w,
                        child: Image.asset(
                          ImageStrings.filter,
                          fit: BoxFit.contain,
                        )),
                  ),
                  SizedBox(
                    height: controller.opened || controller.filter ? 15.h : 0.h,
                  ),
                  Flexible(flex: 1, child: _all())
                ],
              ),
      ),
    );
  }

  _all() {
    return GetX<OnGoingViewModel>(
      init: OnGoingViewModel(),
      builder: (controller) => SingleChildScrollView(
        child: controller.filter
            ? _filter()
            : Column(
                children: [
                  controller.swimming.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.opened
                                ? controller.opened = false
                                : controller.opened = true;
                            controller.update();
                          },
                          child: _inventoryItem("swimming pool"),
                        ),
                  controller.opened
                      ? _inventory(controller.swimming)
                      : SizedBox(
                          height: 1,
                        ),
                  SizedBox(
                    height: 6.h,
                  ),
                  controller.insect.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.opened
                                ? controller.opened = false
                                : controller.opened = true;
                            controller.update();
                          },
                          child: _inventoryItem("insect."),
                        ),
                  controller.opened
                      ? _inventory(controller.insect)
                      : SizedBox(
                          height: 1,
                        ),
                  SizedBox(
                    height: 6.h,
                  ),
                  controller.constr.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.opened
                                ? controller.opened = false
                                : controller.opened = true;
                            controller.update();
                          },
                          child: _inventoryItem("const."),
                        ),
                  controller.opened
                      ? _inventory(controller.constr)
                      : SizedBox(
                          height: 1,
                        ),
                  SizedBox(
                    height: 6.h,
                  ),
                  controller.tech.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.opened
                                ? controller.opened = false
                                : controller.opened = true;
                            controller.update();
                          },
                          child: _inventoryItem("tech."),
                        ),
                  controller.opened
                      ? _inventory(controller.tech)
                      : SizedBox(
                          height: 1,
                        ),
                  SizedBox(
                    height: 6.h,
                  ),
                  controller.lands.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.opened
                                ? controller.opened = false
                                : controller.opened = true;
                            controller.update();
                          },
                          child: _inventoryItem("lands"),
                        ),
                  controller.opened
                      ? _inventory(controller.lands)
                      : SizedBox(
                          height: 1,
                        ),
                  SizedBox(
                    height: 6.h,
                  ),
                  controller.carp.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : GestureDetector(
                          onTap: () {
                            controller.opened
                                ? controller.opened = false
                                : controller.opened = true;
                            controller.update();
                          },
                          child: _inventoryItem("carps."),
                        ),
                  controller.opened
                      ? _inventory(controller.carp)
                      : SizedBox(
                          height: 1,
                        ),
                  SizedBox(
                    height: 6.h,
                  ),
                ],
              ),
      ),
    );
  }

  _filter() {
    return Builder(builder: (context) {
      return GetBuilder<OnGoingViewModel>(
          init: OnGoingViewModel(),
          builder: (controller) {
            return Container(
              height: 116.h,
              width: 337.w,
              decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.yellow, width: 3),
                  boxShadow: [_boxShadow()],
                  color: ColorManager.whiteWithOpecity1,
                  borderRadius: BorderRadius.circular(30.r)),
              child: Column(
                children: [
                  SizedBox(
                    height: 21.h,
                  ),
                  Row(
                    children: List.generate(
                        controller.filterType.length,
                        (index) => Row(
                              children: [
                                SizedBox(
                                  width: index == 0 ? 85.w : 100.w,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    controller.filterIndex = index;
                                    controller.update();
                                  },
                                  child: Container(
                                    width: 41.w,
                                    height: 32.h,
                                    decoration: BoxDecoration(
                                        color: controller.filterIndex == index
                                            ? ColorManager.myProposed
                                            : ColorManager.filterItemColor,
                                        border: Border.all(
                                          color: ColorManager.black,
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(30.r),
                                        boxShadow: [_boxShadow()]),
                                    child: Center(
                                      child: FlexText(
                                        title: controller.filterType[index],
                                        style: getMPlus1cStyle(
                                            color: ColorManager.black),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                  ),
                  SizedBox(
                    height: 26.h,
                  ),
                  InkWell(
                    onTap: () {
                      controller.filter = !controller.filter;
                      controller.update();
                    },
                    child: Ink(
                      child: Container(
                        height: 22.h,
                        width: 51.w,
                        decoration: BoxDecoration(
                            color: ColorManager.filterItemColor,
                            border: Border.all(
                              color: ColorManager.black,
                            ),
                            borderRadius: BorderRadius.circular(30.r),
                            boxShadow: [_boxShadow()]),
                        child: Center(
                          child: FlexText(
                            title: "OK",
                            style: getMPlus1cStyle(color: ColorManager.black),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
    });
  }

  _inventory(List<ReplyModel> replyModel) {
    return Builder(builder: (context) {
      return GetBuilder<OnGoingViewModel>(
          init: OnGoingViewModel(),
          builder: (controller) {
            return Column(
              children: List.generate(
                replyModel.length,
                (index) => replyModel[index].accepted == "true"
                    ? _accepted(replyModel[index].userName)
                    : Container(
                        margin: EdgeInsets.only(top: 19.h, left: 19.w),
                        height: 496.h,
                        width: 343.w,
                        decoration: BoxDecoration(
                            color: ColorManager.primary,
                            border: Border.all(
                              width: 4.w,
                              color: ColorManager.yellow,
                            ),
                            borderRadius: BorderRadius.circular(60.r),
                            boxShadow: [_boxShadow()]),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 5.h,
                            ),
                            Container(
                              height: 31.h,
                              width: 162.35,
                              margin: EdgeInsets.only(left: 36.w),
                              child: FlexText(
                                title: replyModel[index].userName,
                                style: getMPlus1cStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s24),
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Container(
                              height: 212.h,
                              width: 273.w,
                              margin: EdgeInsets.only(left: 30.w),
                              decoration: BoxDecoration(
                                  color: ColorManager.sendBackground,
                                  border:
                                      Border.all(color: ColorManager.yellow),
                                  boxShadow: [_boxShadow()],
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 47.w, vertical: 22.h),
                                child: FlexText(
                                  title: replyModel[index].jobDetail,
                                  style: getMPlus1cStyle(
                                      color: ColorManager.black,
                                      fontSize: FontSize.s24),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 8.h,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 51.w),
                              height: 15.h,
                              child: FlexText(
                                title: "Add pervious project",
                                style: getRegularSalsaStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s12),
                              ),
                            ),
                            SizedBox(
                              height: 2.h,
                            ),
                            Container(
                              height: 44.h,
                              width: 260.w,
                              margin: EdgeInsets.only(left: 41.w),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 2.w,
                                    color: ColorManager.lightBlue,
                                  ),
                                  borderRadius: BorderRadius.circular(30.r)),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                    replyModel[index].images.length,
                                    (indexR) => Container(
                                          height: 24.h,
                                          width: 21.85.w,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                  color: ColorManager.grey)),
                                          margin: EdgeInsets.symmetric(
                                              vertical: 10.h, horizontal: 5.w),
                                          child: Image.network(
                                            replyModel[index].images[indexR],
                                            fit: BoxFit.fill,
                                          ),
                                        )),
                              ),
                            ),
                            SizedBox(
                              height: 13.h,
                            ),
                            SizedBox(
                              height: 17.h,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: 89.w,
                                  ),
                                  Container(
                                    width: 86,
                                    child: FlexText(
                                      title: "Duration",
                                      style: getRegularSalsaStyle(
                                          color: ColorManager.black),
                                    ),
                                  ),
                                  Container(
                                    width: 86,
                                    child: FlexText(
                                      title:
                                          replyModel[index].duration + " days",
                                      style: getRegularSalsaStyle(
                                          color: ColorManager.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 7.h,
                            ),
                            SizedBox(
                              height: 17.h,
                              child: SizedBox(
                                height: 17.h,
                                child: _budget(ImageStrings.avavilability,
                                    "Timing", "calander"),
                              ),
                            ),
                            SizedBox(
                              height: 12.h,
                            ),
                            SizedBox(
                              height: 17.h,
                              child: _budget(
                                  ImageStrings.budget,
                                  HomeStrings.budget,
                                  replyModel[index].budgetFrom +
                                      " AED" +
                                      "-" +
                                      replyModel[index].budgetTo +
                                      " AED"),
                            ),
                            SizedBox(
                              height: 10.h,
                            ),
                            SizedBox(
                              height: 17.h,
                              child: _budget(
                                  ImageStrings.location,
                                  HomeStrings.location,
                                  replyModel[index].location),
                            ),
                            SizedBox(
                              height: 11.h,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 118.w),
                              height: 36.h,
                              width: 89.w,
                              child: FlexText(
                                title: "Pending",
                                style: getMPlus1cStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s24),
                              ),
                            ),
                          ],
                        ),
                      ),
              ),
            );
          });
    });
  }

  _accepted(String userName) {
    return Builder(builder: (context) {
      return Container(
        margin: EdgeInsets.only(top: 25.h),
        height: 288.h,
        decoration: BoxDecoration(
            color: ColorManager.acceptedColor,
            border: Border.all(
              color: ColorManager.grey,
            ),
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [_boxShadow()]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
              height: 4.h,
            ),
            Container(
              height: 64.35.h,
              child: Row(
                children: [
                  SizedBox(
                    width: 24.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 36.04.h,
                        width: 113.w,
                        child: FlexText(
                          title: userName,
                          style: getRegularSalsaStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s36),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: List.generate(
                                4,
                                (index) => Row(
                                      children: [
                                        Icon(
                                          Icons.star,
                                          color: ColorManager.starColor,
                                          size: 15.56.h,
                                        ),
                                        SizedBox(
                                          width: index == 4 ? 0.w : 5.w,
                                        ),
                                      ],
                                    )),
                          ),
                          SizedBox(
                            width: 79.w,
                          ),
                          Container(
                            width: 84.w,
                            height: 28.h,
                            decoration: BoxDecoration(
                              color: ColorManager.well,
                              borderRadius: BorderRadius.circular(90.r),
                            ),
                            child: Center(
                              child: FlexText(
                                title: "well",
                                style: getRegularSalsaStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s18),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 101.w,
                          ),
                          Container(
                            height: 19.h,
                            width: 24.w,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(90.r),
                            ),
                            child: Image.asset(
                              ImageStrings.flag,
                              fit: BoxFit.fill,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 9.h,
            ),
            Container(
              height: 2.h,
              color: ColorManager.grey,
            ),
            SizedBox(
              height: 33.h,
            ),
            GetBuilder<ControlViewModelService>(
                init: ControlViewModelService(),
                builder: (controlController) {
                  return GestureDetector(
                    onTap: () {
                      controlController.currentScreen =
                          ServiceProviderChatView();
                      controlController.update();
                    },
                    child: Container(
                      height: 38.h,
                      decoration: BoxDecoration(
                        color: ColorManager.yellow,
                        border: Border.symmetric(
                          horizontal: BorderSide(color: ColorManager.black),
                        ),
                      ),
                      child: Center(
                        child: FlexText(
                          title: "Chat",
                          style: getMPlus1cStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s36),
                        ),
                      ),
                    ),
                  );
                }),
            SizedBox(
              height: 57.h,
            ),
            Container(
                height: 35.h,
                child: Row(
                  children: [
                    SizedBox(
                      width: 23.w,
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.dialog(RatingView(
                            onChangedcallAnswerRate: (v) {},
                            onChangedserviceRate: (v) {},
                            onChangedpriceRate: (v) {},
                            onChangedtimeRate: (v) {},
                            userName: userName,
                            callAnswerRate: 0,
                            serviceRate: 0,
                            priceRate: 0,
                            timeRate: 0));
                      },
                      child: Container(
                        width: 145.w,
                        decoration: BoxDecoration(
                            color: ColorManager.primary,
                            border: Border.all(
                              color: ColorManager.black,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: FlexText(
                            title: "Done",
                            style: getMPlus1cStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 53.w,
                    ),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 145.w,
                        decoration: BoxDecoration(
                            color: ColorManager.primary,
                            border: Border.all(
                              color: ColorManager.black,
                            ),
                            borderRadius: BorderRadius.circular(30)),
                        child: Center(
                          child: FlexText(
                            title: "cancel",
                            style: getMPlus1cStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s20),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
            SizedBox(
              height: 43.h,
            ),
          ],
        ),
      );
    });
  }

  _budget(String image, String name, String value) {
    return Row(
      children: [
        SizedBox(
          width: 84.w,
        ),
        Container(
          height: 17.h,
          width: 15.w,
          child: Image.asset(
            image,
            fit: BoxFit.fill,
          ),
        ),
        SizedBox(
          width: 7.w,
        ),
        Container(
          height: 17.h,
          width: 60.w,
          child: FlexText(
            title: name,
            style: getRegularSalsaStyle(color: ColorManager.black),
          ),
        ),
        Container(
          height: 17.h,
          width: 160.w,
          child: FlexText(
            title: value,
            style: getRegularSalsaStyle(color: ColorManager.black),
          ),
        ),
      ],
    );
  }

  _inventoryItem(String name) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 17.w,
        ),
        Container(
          decoration: BoxDecoration(
              color: ColorManager.filterItemColor,
              border: Border.all(color: ColorManager.black),
              borderRadius: BorderRadius.circular(30.r)),
          height: 38.h,
          width: 229.w,
          child: Row(
            children: [
              SizedBox(
                width: 22.w,
              ),
              Container(
                width: 165.w,
                child: FlexText(
                  title: name,
                  style: getMPlusStyle(
                      color: ColorManager.black, fontSize: FontSize.s24),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  _boxShadow() {
    return const BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.25),
      spreadRadius: 0,
      blurRadius: 4,
      offset: Offset(0, 4),
    );
  }
}

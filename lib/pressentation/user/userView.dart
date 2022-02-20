import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/user/userViewModel.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';

class UserView extends StatelessWidget {
  const UserView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: GetBuilder<UserViewModel>(
          init: UserViewModel(),
          builder: (controller) {
            return GestureDetector(
              onTap: () {
                controller.focusNode.unfocus();
                controller.longPressed = false;
                controller.update();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 31.h,
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 30.w),
                      height: 35.h,
                      width: 163.w,
                      child: FlexText(
                        title: HomeStrings.jobDescribtion,
                        style: getMPlusStyle(
                            color: ColorManager.black, fontSize: FontSize.s24),
                      ),
                    ),
                    SizedBox(
                      height: 13.h,
                    ),
                    Container(
                        margin: EdgeInsets.only(left: 24.w),
                        height: 650.h,
                        width: 365.w,
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorManager.yellow, width: 4.w),
                            borderRadius: BorderRadius.circular(75.r)),
                        child: controller.send ? _sended() : _addService()),
                    SizedBox(
                      height: 3.h,
                    ),
                  ],
                ),
              ),
            );
          }),
    );
  }

  _sended() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(75),
          color: ColorManager.sendBackground),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
                height: 40,
                width: 100,
                child: Image.asset(
                  ImageStrings.yeeo,
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: 40,
            ),
            Container(
                height: 76,
                width: 84,
                child: Image.asset(
                  ImageStrings.sentPolygon,
                  fit: BoxFit.fill,
                )),
            SizedBox(
              height: 40,
            ),
            Container(
                height: 40,
                width: 100,
                child: Image.asset(
                  ImageStrings.sent,
                  fit: BoxFit.fill,
                ))
          ],
        ),
      ),
    );
  }

  _addService() {
    return Builder(builder: (context) {
      return GetBuilder<UserViewModel>(
          init: UserViewModel(),
          builder: (controller) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 63.w),
                  height: 18.h,
                  width: 62.w,
                  child: FlexText(
                    title: HomeStrings.jobDetails,
                    style: getMPlusStyle(
                        color: ColorManager.black, fontSize: FontSize.s12),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                    margin: EdgeInsets.only(left: 47.w),
                    height: 211.h,
                    width: 273.w,
                    decoration: BoxDecoration(
                      border: Border.all(color: ColorManager.yellow),
                      color: ColorManager.textBackground,
                      boxShadow: [
                        BoxShadow(
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                            offset: Offset(0, 3),
                            blurStyle: BlurStyle.outer)
                      ],
                      borderRadius: BorderRadius.circular(30.r),
                    ),
                    child: Stack(
                      children: [
                        controller.tapped
                            ? SizedBox(
                                height: 0,
                                width: 0,
                              )
                            : Container(
                                margin: EdgeInsets.only(left: 31.w),
                                height: 185.h,
                                width: 204.w,
                                child: Stack(
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 32.h,
                                        ),
                                        Container(
                                          height: 119.h,
                                          width: 204.w,
                                          child: FlexText(
                                            title: HomeStrings.jobDetailHint,
                                            style: getRegularSalsaStyle(
                                                color: ColorManager.grey),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 55.h,
                                        ),
                                        Container(
                                          height: 1.h,
                                          width: 204.w,
                                          color: ColorManager.grey,
                                        ),
                                        SizedBox(
                                          height: 37.h,
                                        ),
                                        Container(
                                          height: 1.h,
                                          width: 204.w,
                                          color: ColorManager.grey,
                                        ),
                                        SizedBox(
                                          height: 34.h,
                                        ),
                                        Container(
                                          height: 1.h,
                                          width: 204.w,
                                          color: ColorManager.grey,
                                        ),
                                        SizedBox(
                                          height: 53.h,
                                        ),
                                        Container(
                                          height: 1.h,
                                          width: 204.w,
                                          color: ColorManager.grey,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                        TextFormField(
                          controller: controller.textEditingController,
                          focusNode: controller.focusNode,
                          style: getMeduimStyle(
                              color: ColorManager.black,
                              fontSize: FontSize.s18),
                          onChanged: (v) {
                            controller.tapped = true;
                            controller.jobDetail = v;
                            controller.update();
                          },
                          keyboardType: TextInputType.multiline,
                          maxLines: 12,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.all(31),
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: 7.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 66.w),
                  height: 18.h,
                  width: 58.w,
                  child: FlexText(
                    title: HomeStrings.addImage,
                    style: getMPlusStyle(
                        color: ColorManager.black, fontSize: FontSize.s12),
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 57.w),
                  height: 44.h,
                  width: 260.w,
                  decoration: BoxDecoration(
                    border: Border.all(color: ColorManager.yellow, width: 2),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Row(
                      children: [
                        SizedBox(
                          width: 19.w,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(Container(
                                decoration: BoxDecoration(
                                    color: ColorManager.whiteWithOpecity1),
                                height: MediaQuery.of(context)
                                        .copyWith()
                                        .size
                                        .height *
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
                                          FlexText(
                                            title: "Select Image",
                                            style: getRegularSalsaStyle(
                                                color: ColorManager.black,
                                                fontSize: FontSize.s16),
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
                                      height: MediaQuery.of(context)
                                              .copyWith()
                                              .size
                                              .height *
                                          .2,
                                      child: Row(
                                        children: [
                                          Spacer(
                                            flex: 1,
                                          ),
                                          Flexible(
                                            flex: 10,
                                            fit: FlexFit.tight,
                                            child: GestureDetector(
                                              onTap: () async {
                                                controller.getImageFromCamera();

                                                controller.update();
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        width: 2.w,
                                                        color: ColorManager
                                                            .yellow)),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.camera,
                                                      color:
                                                          ColorManager.yellow,
                                                      size: 50.w,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    FlexText(
                                                      title: "Camera",
                                                      style: getBoldStyle(
                                                          color: ColorManager
                                                              .black),
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
                                              onTap: () async {
                                                controller.getImage();
                                                controller.update();
                                              },
                                              child: Container(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Icon(
                                                      Icons.photo,
                                                      color:
                                                          ColorManager.yellow,
                                                      size: 50.w,
                                                    ),
                                                    SizedBox(
                                                      height: 5.h,
                                                    ),
                                                    FlexText(
                                                      title: "Gallary",
                                                      style: getBoldStyle(
                                                          color: ColorManager
                                                              .black),
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
                                )));
                          },
                          child: Container(
                            height: 38.h,
                            width: 38.w,
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
                          width: 22.w,
                        ),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10.h),
                          height: 24.h,
                          width: 155.85.w,
                          child: ListView.builder(
                              itemCount: controller.img.length == null
                                  ? 0
                                  : controller.img.length,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return Row(
                                  children: [
                                    GestureDetector(
                                      onLongPress: () {
                                        controller.longPressed = true;
                                        controller.update();
                                      },
                                      child: Stack(
                                        children: [
                                          Container(
                                            width: 21.85.w,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color: ColorManager.grey),
                                                borderRadius:
                                                    BorderRadius.circular(3.r)),
                                            child: controller.imageFile == null
                                                ? Text("no file")
                                                : Image.file(
                                                    File(
                                                      controller.img[index],
                                                    ),
                                                    fit: BoxFit.fill,
                                                  ),
                                          ),
                                          controller.longPressed
                                              ? GestureDetector(
                                                  onTap: () {
                                                    controller.img
                                                        .removeAt(index);
                                                    controller.imgFirebase
                                                        .removeAt(index);
                                                    controller.update();
                                                  },
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 11.w),
                                                    height: 10.h,
                                                    width: 10.w,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(30.r),
                                                        color:
                                                            ColorManager.grey),
                                                    child: Icon(
                                                      Icons.clear_outlined,
                                                      size: 10.w,
                                                    ),
                                                  ),
                                                )
                                              : SizedBox(
                                                  height: 0.h,
                                                ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      width: 9,
                                    )
                                  ],
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(left: 70.w),
                  height: 9.h,
                  width: 241.w,
                  child: FlexText(
                    title: HomeStrings.addImageDesc,
                    style: getMPlus1cStyle(
                        color: ColorManager.black, fontSize: FontSize.s6),
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 60.w),
                  height: 18.h,
                  width: 71.w,
                  child: FlexText(
                    title: HomeStrings.briefDetails,
                    style: getMPlusStyle(
                        color: ColorManager.black, fontSize: FontSize.s12),
                  ),
                ),
                SizedBox(
                  height: 1.h,
                ),
                Row(
                  children: [
                    Container(
                        margin: EdgeInsets.only(left: 71.w, top: 5.h),
                        height: 17.h,
                        width: 15.w,
                        child: Image.asset(ImageStrings.avavilability)),
                    SizedBox(
                      height: 7.w,
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 4.h),
                      height: 17.h,
                      width: 86.w,
                      child: FlexText(
                        title: HomeStrings.availability,
                        style: getMeduimStyle(
                          color: ColorManager.black,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(_selecAvailability(
                                name: "From",
                                onDateTimeChanged: (value) {
                                  controller.availabilityFromSelected = value;
                                },
                                onTap: () {
                                  controller.availabilityFrom =
                                      controller.availabilityFromSelected;
                                  controller.update();
                                  Get.back();
                                }));
                          },
                          child: Row(
                            children: [
                              FlexText(
                                title: HomeStrings.from,
                                style: getMeduimStyle(
                                  color: ColorManager.black,
                                ),
                              ),
                              SizedBox(width: 5.w),
                              FlexText(
                                title: DateFormat('M/dd\nk:mm a')
                                    .format(controller.availabilityFrom),
                                style: getMeduimStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s12),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 5.w),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(_selecAvailability(
                                name: "To",
                                onDateTimeChanged: (value) {
                                  controller.availabilityToSelected = value;
                                },
                                onTap: () {
                                  controller.availabilityTo =
                                      controller.availabilityToSelected;
                                  controller.update();
                                  Get.back();
                                }));
                          },
                          child: Row(
                            children: [
                              FlexText(
                                title: HomeStrings.to,
                                style: getMeduimStyle(
                                  color: ColorManager.black,
                                ),
                              ),
                              SizedBox(width: 3.w),
                              FlexText(
                                title: DateFormat('M/dd\nk:mm a')
                                    .format(controller.availabilityTo),
                                style: getMeduimStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 12.h,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 71.w,
                  ),
                  child: Row(
                    children: [
                      Container(
                          height: 17.h,
                          width: 15.w,
                          child: Image.asset(ImageStrings.budget)),
                      SizedBox(
                        width: 7.w,
                      ),
                      Container(
                        height: 17.h,
                        width: 86.w,
                        child: FlexText(
                          title: HomeStrings.budget,
                          style: getMeduimStyle(
                            color: ColorManager.black,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => selectBudget(),
                        child: Container(
                          height: 17.h,
                          width: 167.w,
                          child: Row(
                            children: [
                              Flexible(
                                flex: 30,
                                fit: FlexFit.tight,
                                child: FlexText(
                                  title: controller.budgetFrom,
                                  style: getMeduimStyle(
                                    color: ColorManager.black,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 20,
                                fit: FlexFit.loose,
                                child: FlexText(
                                  title: HomeStrings.aed,
                                  style: getMeduimStyle(
                                    color: ColorManager.red,
                                  ),
                                ),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Flexible(
                                flex: 5,
                                child: Text(
                                  "-",
                                  style:
                                      getMeduimStyle(color: ColorManager.black),
                                ),
                              ),
                              Spacer(
                                flex: 1,
                              ),
                              Flexible(
                                flex: 30,
                                fit: FlexFit.tight,
                                child: FlexText(
                                  title: controller.budgetTo,
                                  style: getMeduimStyle(
                                    color: ColorManager.black,
                                  ),
                                ),
                              ),
                              Flexible(
                                flex: 20,
                                fit: FlexFit.tight,
                                child: FlexText(
                                  title: HomeStrings.aed,
                                  style: getMeduimStyle(
                                    color: ColorManager.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 9.h,
                ),
                Container(
                  margin: EdgeInsets.only(
                    left: 71.w,
                  ),
                  child: Row(
                    children: [
                      Container(
                          height: 17.h,
                          width: 15.w,
                          child: Image.asset(ImageStrings.location)),
                      SizedBox(
                        width: 7.w,
                      ),
                      Container(
                        height: 17.h,
                        width: 86.w,
                        child: FlexText(
                          title: HomeStrings.location,
                          style: getMeduimStyle(
                            color: ColorManager.black,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 17.h,
                            width: 104.w,
                            child: FlexText(
                              title: controller
                                  .locations[controller.locationIndex],
                              style: getMeduimStyle(
                                color: ColorManager.black,
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 14.w,
                          ),
                          Container(
                            height: 10.h,
                            width: 15.w,
                            child: GestureDetector(
                              onTap: () {
                                Get.bottomSheet(Container(
                                    decoration: BoxDecoration(
                                        color: ColorManager.whiteWithOpecity1),
                                    height: MediaQuery.of(context)
                                            .copyWith()
                                            .size
                                            .height *
                                        .32,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding:
                                              EdgeInsets.all(AppPadding.p12),
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
                                                "Select your Location",
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
                                                  icon: Icon(
                                                      Icons.clear_outlined))
                                            ],
                                          ),
                                        ),
                                        Container(
                                          height: MediaQuery.of(context)
                                                  .copyWith()
                                                  .size
                                                  .height *
                                              .2,
                                          child: CupertinoPicker(
                                            itemExtent: 30,
                                            onSelectedItemChanged: (int value) {
                                              controller.locationIndexSelected =
                                                  value;
                                            },
                                            children: List.generate(
                                                controller.locations.length,
                                                (index) => Text(controller
                                                    .locations[index])),
                                          ),
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            controller.locationIndex =
                                                controller
                                                    .locationIndexSelected;
                                            controller.update();
                                            Get.back();
                                          },
                                          child: Container(
                                            height: MediaQuery.of(context)
                                                    .copyWith()
                                                    .size
                                                    .height *
                                                .05,
                                            margin: EdgeInsets.symmetric(
                                              horizontal: MediaQuery.of(context)
                                                      .copyWith()
                                                      .size
                                                      .width *
                                                  .35,
                                            ),
                                            decoration: BoxDecoration(
                                                color: ColorManager.confirm,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Confirm",
                                                  style: getRegularSalsaStyle(
                                                      color:
                                                          ColorManager.black),
                                                ),
                                                Icon(
                                                  Icons.check_outlined,
                                                  color: ColorManager
                                                      .whiteWithOpecity1,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    )));
                              },
                              child: Image.asset(
                                ImageStrings.dropDownArrow,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 23.h,
                ),
                Container(
                  margin: EdgeInsets.only(left: 86.w),
                  height: 98.h,
                  width: 182.w,
                  child: Column(
                    children: List.generate(2, (indexC) {
                      return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: List.generate(controller.service.length - 3,
                              (index) {
                            return GestureDetector(
                              onTap: () {
                                indexC == 0
                                    ? controller.serviceIndex = index
                                    : controller.serviceIndex = index + 3;
                                controller.update();
                              },
                              child: Container(
                                height: 46.h,
                                width: 54.w,
                                margin: EdgeInsets.only(
                                    right: index == 2 ? 0.w : 10.w,
                                    top: indexC == 1 ? 6.h : 0.h),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: indexC == 0
                                            ? controller.serviceIndex == index
                                                ? ColorManager.blue
                                                : ColorManager.yellow
                                            : controller.serviceIndex ==
                                                    index + 3
                                                ? ColorManager.blue
                                                : ColorManager.yellow)),
                                child: Center(
                                  child: Text(
                                    controller.service[
                                        indexC == 0 ? index : index + 3],
                                    style: getMPlusStyle(
                                        color: ColorManager.black),
                                  ),
                                ),
                              ),
                            );
                          }));
                    }),
                  ),
                ),
                SizedBox(
                  height: 18.h,
                ),
                GestureDetector(
                  onTap: () {
                    controller.sending();
                    controller.update();
                  },
                  child: Container(
                    margin: EdgeInsets.only(left: 119.w),
                    height: 33.h,
                    width: 121.w,
                    decoration: BoxDecoration(
                        color: ColorManager.textBackground,
                        borderRadius: BorderRadius.circular(11)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 40.w,
                          height: 27.h,
                          child: FlexText(
                            title: HomeStrings.send,
                            style: getMPlusStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s18),
                          ),
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        Container(
                            height: 15.01.h,
                            width: 22.89.w,
                            child: Image.asset(ImageStrings.sendPolygon))
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 13.h,
                ),
              ],
            );
          });
    });
  }

  selectBudget() {
    return Get.bottomSheet(Builder(builder: (context) {
      return GetBuilder<UserViewModel>(
          init: UserViewModel(),
          builder: (controller) {
            return Container(
                decoration:
                    BoxDecoration(color: ColorManager.whiteWithOpecity1),
                height: MediaQuery.of(context).copyWith().size.height * .32,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppPadding.p12),
                      height:
                          MediaQuery.of(context).copyWith().size.height * .05,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Select your budget",
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
                              icon: Icon(Icons.clear_outlined))
                        ],
                      ),
                    ),
                    Container(
                      height:
                          MediaQuery.of(context).copyWith().size.height * .2,
                      child: Row(
                        children: [
                          Flexible(
                            flex: 10,
                            fit: FlexFit.tight,
                            child: TextField(
                              onChanged: (value) {
                                controller.budgetFromSelected = value;
                              },
                              keyboardType: TextInputType.number,
                              style: getBoldStyle(color: ColorManager.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Image.asset(
                                  ImageStrings.budget,
                                ),
                                hintText: 'From',
                                hintStyle:
                                    getBoldStyle(color: ColorManager.black),
                              ),
                            ),
                          ),
                          Flexible(
                              flex: 1,
                              fit: FlexFit.tight,
                              child: Text(
                                "-",
                                style: getBoldStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s36),
                              )),
                          Flexible(
                            flex: 10,
                            fit: FlexFit.tight,
                            child: TextField(
                              onChanged: (value) {
                                controller.budgetToSelected = value;
                              },
                              keyboardType: TextInputType.number,
                              style: getBoldStyle(color: ColorManager.black),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                contentPadding: EdgeInsets.only(top: 14),
                                prefixIcon: Image.asset(
                                  ImageStrings.budget,
                                ),
                                hintText: 'To',
                                hintStyle:
                                    getBoldStyle(color: ColorManager.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.budgetFrom = controller.budgetFromSelected;
                        controller.budgetTo = controller.budgetToSelected;
                        controller.update();
                        Get.back();
                      },
                      child: Container(
                        height:
                            MediaQuery.of(context).copyWith().size.height * .05,
                        margin: EdgeInsets.symmetric(
                          horizontal:
                              MediaQuery.of(context).copyWith().size.width *
                                  .35,
                        ),
                        decoration: BoxDecoration(
                            color: ColorManager.confirm,
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            FlexText(
                              title: "Confirm",
                              style: getBoldStyle(
                                  color: ColorManager.black,
                                  fontSize: FontSize.s14),
                            ),
                            SizedBox(
                              width: 3,
                            ),
                            Icon(
                              Icons.check_outlined,
                              color: ColorManager.whiteWithOpecity1,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ));
          });
    }));
  }

  _selecAvailability(
      {required String name, required onDateTimeChanged, required onTap}) {
    return Builder(builder: (context) {
      return Container(
          decoration: BoxDecoration(color: ColorManager.whiteWithOpecity1),
          height: MediaQuery.of(context).copyWith().size.height * .32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(AppPadding.p12),
                height: MediaQuery.of(context).copyWith().size.height * .05,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Select avavilabilty dates $name",
                      overflow: TextOverflow.visible,
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
                child: CupertinoDatePicker(
                  initialDateTime: DateTime.now(),
                  onDateTimeChanged: onDateTimeChanged,
                  minuteInterval: 1,
                  mode: CupertinoDatePickerMode.dateAndTime,
                ),
              ),
              GestureDetector(
                onTap: onTap,
                child: Container(
                  height: MediaQuery.of(context).copyWith().size.height * .05,
                  margin: EdgeInsets.symmetric(
                    horizontal:
                        MediaQuery.of(context).copyWith().size.width * .35,
                  ),
                  decoration: BoxDecoration(
                      color: ColorManager.confirm,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Confirm",
                        style: getBoldStyle(
                            color: ColorManager.black, fontSize: FontSize.s14),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.check_outlined,
                        color: ColorManager.whiteWithOpecity1,
                      )
                    ],
                  ),
                ),
              ),
            ],
          ));
    });
  }
}

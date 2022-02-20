import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yeeo/pressentation/auth/loading.dart';
import 'package:yeeo/pressentation/auth/userModel.dart';
import 'package:yeeo/pressentation/control/serviceProviderControl/controlViewModelService.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/serviceProvider/serviceProviderViewModel.dart';
import 'package:yeeo/pressentation/user/jobModel.dart';
import 'package:yeeo/pressentation/widget/availabilityBottomSheet.dart';
import 'package:yeeo/pressentation/widget/budgetBottomSheet.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';
import 'package:yeeo/pressentation/widget/loadingWidget.dart';

class ServiceProviderView extends StatelessWidget {
  const ServiceProviderView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<ServiceProviderViewModel>(
        init: ServiceProviderViewModel(),
        builder: (controller) => controller.loading.value
            ? LoadingWidget()
            : GestureDetector(
                onTap: () => controller.focusNode.unfocus(),
                child: Column(
                  children: [
                    Container(
                      height: 40.h,
                      decoration: BoxDecoration(boxShadow: [_boxShadow()]),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              controller.likeSelected = false;

                              controller.update();
                            },
                            child: Container(
                              width: 267.w,
                              decoration: BoxDecoration(
                                color: controller.likeSelected
                                    ? ColorManager.whiteWithOpecity1
                                    : ColorManager.yellow,
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
                          ),
                          GestureDetector(
                            onTap: () {
                              controller.likeSelected = true;
                              controller.update();
                            },
                            child: Container(
                              width: 147.w,
                              decoration: BoxDecoration(
                                color: controller.likeSelected
                                    ? ColorManager.yellow
                                    : ColorManager.whiteWithOpecity1,
                              ),
                              child: Center(
                                child: Image.asset(ImageStrings.like),
                              ),
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
                            fit: BoxFit.fill,
                          )),
                    ),
                    SizedBox(
                      height:
                          controller.opened || controller.filter ? 15.h : 0.h,
                    ),
                    Flexible(
                      flex: 1,
                      child:
                          controller.likeSelected ? _likedServices() : _all(),
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  _all() {
    return GetBuilder<ServiceProviderViewModel>(
        init: ServiceProviderViewModel(),
        builder: (controller) {
          return SingleChildScrollView(
            child: controller.filter
                ? _filter()
                : Column(
                    children: [
                      controller.jobModelSwimming.length == 0
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
                          ? _inventory(controller.jobModelSwimming,
                              controller.userModelSwimming)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.jobModelInsect.length == 0
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
                          ? _inventory(controller.jobModelInsect,
                              controller.userModelInsect)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.jobModelConst.length == 0
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
                          ? _inventory(controller.jobModelConst,
                              controller.userModelConst)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.jobModelTech.length == 0
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
                          ? _inventory(
                              controller.jobModelTech, controller.userModelTech)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.jobModelLands.length == 0
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
                          ? _inventory(controller.jobModelLands,
                              controller.userModelLands)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.jobModelCarp.length == 0
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
                          ? _inventory(
                              controller.jobModelCarp, controller.userModelCarp)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                    ],
                  ),
          );
        });
  }

  _likedServices() {
    return GetBuilder<ServiceProviderViewModel>(
        init: ServiceProviderViewModel(),
        builder: (controller) {
          return SingleChildScrollView(
            child: controller.filter
                ? _filter()
                : Column(
                    children: [
                      controller.likedJobModelSwimming.length == 0
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
                          ? _inventory(controller.likedJobModelSwimming,
                              controller.userModelSwimming)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.likedJobModelInsect.length == 0
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
                          ? _inventory(controller.likedJobModelInsect,
                              controller.userModelInsect)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.likedJobModelConst.length == 0
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
                          ? _inventory(controller.likedJobModelConst,
                              controller.userModelConst)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.likedJobModelTech.length == 0
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
                          ? _inventory(controller.likedJobModelTech,
                              controller.userModelTech)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.likedJobModelLands.length == 0
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
                          ? _inventory(controller.likedJobModelLands,
                              controller.userModelLands)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.likedJobModelCarp.length == 0
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
                          ? _inventory(controller.likedJobModelCarp,
                              controller.userModelCarp)
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                    ],
                  ),
          );
        });
  }

  _reported(String name, JobModel jobModel) {
    return GetBuilder<ServiceProviderViewModel>(
        init: ServiceProviderViewModel(),
        builder: (controller) {
          return Row(
            children: [
              SizedBox(
                width: 35.w,
              ),
              Container(
                height: 497.h,
                width: 343.w,
                decoration: BoxDecoration(
                    color: ColorManager.primary,
                    border: Border.all(width: 4.w, color: ColorManager.yellow),
                    boxShadow: [_boxShadow()],
                    borderRadius: BorderRadius.circular(60.r)),
                child: Column(
                  children: [
                    SizedBox(
                      height: 26.h,
                    ),
                    GestureDetector(
                      onTap: () {
                        jobModel.reported = "false";
                        controller.update();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 250.w),
                        height: 34.h,
                        width: 27.w,
                        decoration: BoxDecoration(
                            color: ColorManager.sendBackground,
                            border: Border.all(),
                            borderRadius: BorderRadius.circular(30.r),
                            boxShadow: [_boxShadow()]),
                        child: Center(
                          child: Image.asset(ImageStrings.x),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 56.h,
                    ),
                    _rejectItems(name, FontSize.s24),
                    _rejectItems("improper content", FontSize.s18),
                    _rejectItems("Abuse", FontSize.s18),
                    _rejectItems("Other", FontSize.s18),
                  ],
                ),
              ),
            ],
          );
        });
  }

  _rejectItems(name, fontSize) {
    return Container(
      height: 38.h,
      width: 163.w,
      margin: EdgeInsets.only(bottom: 25.h),
      decoration: BoxDecoration(
          color: ColorManager.filterItemColor,
          border: Border.all(
            color: ColorManager.black,
          ),
          boxShadow: [_boxShadow()],
          borderRadius: BorderRadius.circular(30.r)),
      child: Center(
        child: Container(
          height: 31.h,
          width: 152.w,
          alignment: Alignment.center,
          child: FlexText(
            title: name,
            style:
                getMeduimStyle(color: ColorManager.black, fontSize: fontSize),
          ),
        ),
      ),
    );
  }

  _filter() {
    return Builder(builder: (context) {
      return GetBuilder<ServiceProviderViewModel>(
          init: ServiceProviderViewModel(),
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

  _inventory(List<JobModel> jobModel, List<UserModel> userModel) {
    return Builder(builder: (context) {
      return GetBuilder<ServiceProviderViewModel>(
          init: ServiceProviderViewModel(),
          builder: (controller) {
            return Column(
              children: List.generate(
                jobModel.length,
                (index) => jobModel[index].accepted == "true"
                    ? _accepted(userModel[index], jobModel[index])
                    : jobModel[index].reported == "true"
                        ? _reported(userModel[index].userName, jobModel[index])
                        : Container(
                            margin: EdgeInsets.only(top: 19.h),
                            height: 497.h,
                            width: 382.w,
                            decoration: BoxDecoration(
                                color: ColorManager.textBackground,
                                border: Border.all(
                                  width: 4.w,
                                  color: ColorManager.yellow,
                                ),
                                borderRadius: BorderRadius.circular(90.r),
                                boxShadow: [_boxShadow()]),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 24.h,
                                ),
                                Container(
                                  height: 38.h,
                                  width: 242.w,
                                  margin: EdgeInsets.only(left: 60.w),
                                  decoration: BoxDecoration(
                                      color: ColorManager.filterItemColor,
                                      border:
                                          Border.all(color: ColorManager.black),
                                      boxShadow: [_boxShadow()],
                                      borderRadius:
                                          BorderRadius.circular(30.r)),
                                  alignment: Alignment.bottomLeft,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 19.w,
                                      ),
                                      Container(
                                        width: 152.w,
                                        margin: EdgeInsets.only(bottom: 5.h),
                                        child: FlexText(
                                          title: userModel[index].userName,
                                          style: getRegularSalsaStyle(
                                              color: ColorManager.black,
                                              fontSize: FontSize.s36),
                                        ),
                                      ),
                                      Container(
                                        height: 26.h,
                                        width: 63.w,
                                        decoration: BoxDecoration(
                                          color: ColorManager.well,
                                          borderRadius:
                                              BorderRadius.circular(90),
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
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                Container(
                                  height: 205.h,
                                  width: 344.w,
                                  margin: EdgeInsets.only(left: 17.w),
                                  decoration: BoxDecoration(
                                      color: ColorManager.primary,
                                      border: Border.all(
                                          color: ColorManager.yellow),
                                      boxShadow: [_boxShadow()],
                                      borderRadius:
                                          BorderRadius.circular(30.r)),
                                  child: Container(
                                    margin: EdgeInsets.symmetric(
                                        horizontal: 47.w, vertical: 22.h),
                                    child: FlexText(
                                      title: jobModel[index].jobDetail,
                                      style: getMPlus1cStyle(
                                          color: ColorManager.black,
                                          fontSize: FontSize.s24),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15.h,
                                ),
                                Container(
                                  height: 44.h,
                                  width: 331.w,
                                  margin: EdgeInsets.only(left: 25.w),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        width: 2.w,
                                        color: ColorManager.lightBlue,
                                      ),
                                      borderRadius:
                                          BorderRadius.circular(30.r)),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: List.generate(
                                        jobModel[index].images.length,
                                        (indexR) => Container(
                                              height: 24.h,
                                              width: 21.85.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color:
                                                          ColorManager.grey)),
                                              margin: EdgeInsets.symmetric(
                                                  vertical: 10.h,
                                                  horizontal: 5.w),
                                              child: Image.network(
                                                jobModel[index].images[indexR],
                                                fit: BoxFit.fill,
                                              ),
                                            )),
                                  ),
                                ),
                                SizedBox(
                                  height: 23.h,
                                ),
                                _budget(
                                  ImageStrings.avavilability,
                                  HomeStrings.availability,
                                  "From: " +
                                      DateFormat('M/dd k:mm a').format(
                                        DateTime.parse(
                                          jobModel[index].availabilityFrom,
                                        ),
                                      ) +
                                      " To: " +
                                      DateFormat('M/dd k:mm a').format(
                                        DateTime.parse(
                                          jobModel[index].availabilityTo,
                                        ),
                                      ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 15.h,
                                  child: _budget(
                                    ImageStrings.budget,
                                    HomeStrings.budget,
                                    "From: " +
                                        jobModel[index].budgetFrom +
                                        " AED" +
                                        " To: " +
                                        jobModel[index].budgetTo +
                                        " AED",
                                  ),
                                ),
                                SizedBox(
                                  height: 10.h,
                                ),
                                SizedBox(
                                  height: 15.h,
                                  child: _budget(
                                      ImageStrings.location,
                                      HomeStrings.location,
                                      jobModel[index].location),
                                ),
                                SizedBox(
                                  height: 18.h,
                                ),
                                SizedBox(
                                  height: 22.11.h,
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 146.w,
                                      ),
                                      Container(
                                        width: 87.w,
                                        height: 22.11.h,
                                        decoration: BoxDecoration(
                                          boxShadow: [_boxShadow()],
                                          color: ColorManager.textBackground,
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          border: Border.all(
                                              color: ColorManager.black),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                jobModel[index].accepted =
                                                    "true";
                                                controller.update();
                                              },
                                              child: Container(
                                                width: 16.w,
                                                height: 11.47.h,
                                                child: Icon(
                                                  Icons.check_outlined,
                                                  size: 16.w,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10.w,
                                            ),
                                            Container(
                                                width: 0.w,
                                                child: FlexText(
                                                  title: "|",
                                                  style: getMPlus1cStyle(
                                                      color:
                                                          ColorManager.black),
                                                )),
                                            SizedBox(
                                              width: 14.5.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                controller.update();
                                              },
                                              child: Container(
                                                width: 16.w,
                                                height: 11.47.h,
                                                child: Icon(
                                                  Icons.clear_outlined,
                                                  size: 16.w,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        width: 18.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          if (jobModel[index].like.contains(
                                              controller.serviceProviderModel
                                                  .serviceProviderId)) {
                                            jobModel[index].like.remove(
                                                controller.serviceProviderModel
                                                    .serviceProviderId);
                                            controller.like(jobModel[index]);
                                            controller.update();
                                          } else {
                                            jobModel[index].like.add(controller
                                                .serviceProviderModel
                                                .serviceProviderId);
                                            controller.like(jobModel[index]);
                                            controller.update();
                                          }
                                        },
                                        child: Container(
                                            height: 18.73.h,
                                            width: 18.07.w,
                                            child: Image.asset(
                                              jobModel[index].like.contains(
                                                      controller
                                                          .serviceProviderModel
                                                          .serviceProviderId)
                                                  ? ImageStrings.liked
                                                  : ImageStrings.like,
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                      SizedBox(
                                        width: 13.w,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          jobModel[index].reported = "true";
                                          controller.update();
                                        },
                                        child: Container(
                                            height: 19.h,
                                            width: 24.w,
                                            child: Image.asset(
                                              ImageStrings.flag,
                                              fit: BoxFit.fill,
                                            )),
                                      ),
                                    ],
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

  _sended() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 50.h,
        ),
        Container(
            height: 50.h,
            width: 110.w,
            child: Image.asset(
              ImageStrings.yeeo,
              fit: BoxFit.fill,
            )),
        SizedBox(
          height: 20.h,
        ),
        Container(
            height: 75.74.h,
            width: 84.w,
            child: Image.asset(
              ImageStrings.sentPolygon,
              fit: BoxFit.fill,
            )),
        SizedBox(
          height: 23.h,
        ),
        Container(
            height: 50.h,
            width: 110.w,
            child: Image.asset(
              ImageStrings.sent,
              fit: BoxFit.fill,
            ))
      ],
    );
  }

  _accepted(UserModel userModel, JobModel jobModel) {
    return Builder(builder: (context) {
      return GetBuilder<ServiceProviderViewModel>(
          init: ServiceProviderViewModel(),
          builder: (controller) {
            return Container(
              margin: EdgeInsets.only(top: 25.h),
              height: 477.h,
              width: 343.w,
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  border: Border.all(
                    color: ColorManager.yellow,
                    width: 4.w,
                  ),
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [_boxShadow()]),
              child: controller.sending == true
                  ? _sended()
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 25.h,
                        ),
                        GestureDetector(
                          onTap: () => controller.focusNode.requestFocus(),
                          child: Container(
                            height: 212.h,
                            width: 273.w,
                            margin: EdgeInsets.only(left: 30.w),
                            decoration: BoxDecoration(
                                color: ColorManager.sendBackground,
                                border: Border.all(color: ColorManager.yellow),
                                boxShadow: [_boxShadow()],
                                borderRadius: BorderRadius.circular(30.r)),
                            child: Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15.w, vertical: 34.h),
                              child: TextFormField(
                                style: getMeduimStyle(
                                    color: ColorManager.black,
                                    fontSize: FontSize.s18),
                                onChanged: (v) {
                                  controller.jobDetail = v;
                                },
                                focusNode: controller.focusNode,
                                keyboardType: TextInputType.multiline,
                                maxLines: 12,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: 51.w,
                          ),
                          height: 15.h,
                          width: 118.w,
                          child: FlexText(
                            title: "Add pervious projects",
                            style: getRegularSalsaStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s12),
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 41.w),
                          height: 44.h,
                          width: 260.w,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorManager.yellow, width: 2),
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
                                    controller.focusNode.unfocus();
                                    Get.bottomSheet(Container(
                                        decoration: BoxDecoration(
                                            color:
                                                ColorManager.whiteWithOpecity1),
                                        height: MediaQuery.of(context)
                                                .copyWith()
                                                .size
                                                .height *
                                            .26,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all(
                                                  AppPadding.p12),
                                              height: MediaQuery.of(context)
                                                      .copyWith()
                                                      .size
                                                      .height *
                                                  .05,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    "Select Image",
                                                    overflow:
                                                        TextOverflow.visible,
                                                    style: getRegularSalsaStyle(
                                                        color:
                                                            ColorManager.black,
                                                        fontSize: FontSize.s16),
                                                  ),
                                                  IconButton(
                                                      padding:
                                                          EdgeInsets.all(0),
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
                                                        controller
                                                            .getImageFromCamera();

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
                                            Container(
                                              width: 21.85.w,
                                              decoration: BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorManager.grey),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          3.r)),
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
                                              width: 9.w,
                                            ),
                                          ],
                                        );
                                      }),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 89.w,
                            ),
                            Container(
                              height: 17,
                              width: 86,
                              child: FlexText(
                                title: "Duration",
                                style: getRegularSalsaStyle(
                                    color: ColorManager.black),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.bottomSheet(Container(
                                  height:
                                      MediaQuery.of(context).size.height * .3,
                                  color: ColorManager.yellow,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .1,
                                      ),
                                      Container(
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .1,
                                        child: TextField(
                                          onChanged: (value) {
                                            controller.duration = value;
                                            controller.update();
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ));
                              },
                              child: Container(
                                height: 17,
                                width: 86,
                                child: FlexText(
                                  title: controller.duration + " days",
                                  style: getRegularSalsaStyle(
                                      color: ColorManager.black),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 13.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(AvavilabilityBottomSheet(
                              onTap: () {
                                controller.availabilityFrom =
                                    avavilabilityFrom != null
                                        ? avavilabilityFrom
                                        : DateTime.now();
                                controller.availabilityTo =
                                    avavilabilityTo != null
                                        ? avavilabilityTo
                                        : DateTime.now();
                                controller.update();
                                Get.back();
                              },
                            ));
                            avavilabilityFrom = null;
                            avavilabilityTo = null;
                          },
                          child: _budget(
                              ImageStrings.avavilability,
                              "Timing",
                              "From: " +
                                  DateFormat('M/dd k:mm a')
                                      .format(controller.availabilityFrom!) +
                                  " - " +
                                  "To: " +
                                  DateFormat('M/dd k:mm a')
                                      .format(controller.availabilityTo!)),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        GestureDetector(
                          onTap: () {
                            Get.bottomSheet(BudgetBottomSheet(onTap: () {
                              controller.budgetFrom = budgetFrom != null
                                  ? budgetFrom
                                  : controller.budgetFrom;
                              controller.budgetTo = budgetTo != null
                                  ? budgetTo
                                  : controller.budgetTo;
                              controller.update();
                              Get.back();
                            }));
                            budgetFrom = null;
                            budgetTo = null;
                          },
                          child: _budget(
                              ImageStrings.budget,
                              "Budget",
                              controller.budgetFrom! +
                                  " AED" +
                                  "-" +
                                  controller.budgetTo! +
                                  " AEd"),
                        ),
                        SizedBox(
                          height: 12.h,
                        ),
                        _budget(ImageStrings.location, "location",
                            controller.serviceProviderModel.location),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: List.generate(
                              2,
                              (index) => Container(
                                    height: 22.h,
                                    width: 73.77.w,
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 85.w : 10.w),
                                    decoration: BoxDecoration(
                                        color: ColorManager.primary,
                                        border: Border.all(
                                            color: ColorManager.black),
                                        boxShadow: [_boxShadow()],
                                        borderRadius:
                                            BorderRadius.circular(30.r)),
                                    child: GestureDetector(
                                      onTap: () {
                                        index == 1
                                            ? controller.send(
                                                jobModel,
                                                userModel.userId,
                                              )
                                            : Get.bottomSheet(_review(
                                                userModel.userName, jobModel));
                                      },
                                      child: Container(
                                        height: 17.h,
                                        width: 65.75.w,
                                        alignment: Alignment.center,
                                        child: FlexText(
                                          title:
                                              index == 0 ? "Review" : "Reply",
                                          style: getRegularSalsaStyle(
                                              color: ColorManager.black),
                                        ),
                                      ),
                                    ),
                                  )),
                        ),
                      ],
                    ),
            );
          });
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

  _review(String userName, JobModel jobModel) {
    return GetBuilder<ServiceProviderViewModel>(builder: (controller) {
      return Container(
        margin: EdgeInsets.only(top: 19.h),
        height: 497.h,
        width: 382.w,
        decoration: BoxDecoration(
            color: ColorManager.textBackground,
            border: Border.all(
              width: 4.w,
              color: ColorManager.yellow,
            ),
            borderRadius: BorderRadius.circular(90.r),
            boxShadow: [_boxShadow()]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 24.h,
            ),
            Container(
              height: 38.h,
              width: 242.w,
              margin: EdgeInsets.only(left: 60.w),
              decoration: BoxDecoration(
                  color: ColorManager.filterItemColor,
                  border: Border.all(color: ColorManager.black),
                  boxShadow: [_boxShadow()],
                  borderRadius: BorderRadius.circular(30.r)),
              alignment: Alignment.bottomLeft,
              child: Row(
                children: [
                  SizedBox(
                    width: 19.w,
                  ),
                  Container(
                    width: 152.w,
                    margin: EdgeInsets.only(bottom: 5.h),
                    child: FlexText(
                      title: userName,
                      style: getRegularSalsaStyle(
                          color: ColorManager.black, fontSize: FontSize.s36),
                    ),
                  ),
                  Container(
                    height: 26.h,
                    width: 63.w,
                    decoration: BoxDecoration(
                      color: ColorManager.well,
                      borderRadius: BorderRadius.circular(90),
                    ),
                    child: Center(
                      child: FlexText(
                        title: "well",
                        style: getRegularSalsaStyle(
                            color: ColorManager.black, fontSize: FontSize.s18),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10.h,
            ),
            Container(
              height: 205.h,
              width: 344.w,
              margin: EdgeInsets.only(left: 17.w),
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  border: Border.all(color: ColorManager.yellow),
                  boxShadow: [_boxShadow()],
                  borderRadius: BorderRadius.circular(30.r)),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 47.w, vertical: 22.h),
                child: FlexText(
                  title: jobModel.jobDetail,
                  style: getMPlus1cStyle(
                      color: ColorManager.black, fontSize: FontSize.s24),
                ),
              ),
            ),
            SizedBox(
              height: 15.h,
            ),
            Container(
              height: 44.h,
              width: 331.w,
              margin: EdgeInsets.only(left: 25.w),
              decoration: BoxDecoration(
                  border: Border.all(
                    width: 2.w,
                    color: ColorManager.lightBlue,
                  ),
                  borderRadius: BorderRadius.circular(30.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                    jobModel.images.length,
                    (indexR) => Container(
                          height: 24.h,
                          width: 21.85.w,
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorManager.grey)),
                          margin: EdgeInsets.symmetric(
                              vertical: 10.h, horizontal: 5.w),
                          child: Image.network(
                            jobModel.images[indexR],
                            fit: BoxFit.fill,
                          ),
                        )),
              ),
            ),
            SizedBox(
              height: 23.h,
            ),
            _budget(
              ImageStrings.avavilability,
              HomeStrings.availability,
              "From: " +
                  DateFormat('M/dd k:mm a').format(
                    DateTime.parse(
                      jobModel.availabilityFrom,
                    ),
                  ) +
                  " To:" +
                  DateFormat('M/dd k:mm a').format(
                    DateTime.parse(
                      jobModel.availabilityTo,
                    ),
                  ),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 15.h,
              child: _budget(
                  ImageStrings.budget,
                  HomeStrings.budget,
                  controller
                          .getBudget(jobModel.budgetFrom, jobModel.budgetTo)
                          .toString() +
                      " AED"),
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 15.h,
              child: _budget(ImageStrings.location, HomeStrings.location,
                  jobModel.location),
            ),
            SizedBox(
              height: 18.h,
            ),
          ],
        ),
      );
    });
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

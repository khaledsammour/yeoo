import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/auth/serviceProviderModel.dart';
import 'package:yeeo/pressentation/control/menuView.dart';
import 'package:yeeo/pressentation/control/userControl/chat/chatView.dart';
import 'package:yeeo/pressentation/control/userControl/controlViewModel.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/serviceProvider/replyModel.dart';
import 'package:yeeo/pressentation/user/inventoryViewModel.dart';
import 'package:yeeo/pressentation/user/userView.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';
import 'package:yeeo/pressentation/widget/loadingWidget.dart';
import 'package:yeeo/pressentation/widget/ratingView.dart';

class InventoryView extends StatelessWidget {
  const InventoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: GetBuilder<InventoryViewModel>(
        init: InventoryViewModel(),
        builder: (controller) => controller.loading.value
            ? LoadingWidget()
            : Column(
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
                    height: 35.h,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * .08,
                    child: Row(
                      children: [
                        Spacer(
                          flex: 40,
                        ),
                        Column(
                          children: [
                            Spacer(
                              flex: 15,
                            ),
                            controller.filter
                                ? Flexible(
                                    flex: 38,
                                    fit: FlexFit.tight,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width *
                                          .6,
                                    ),
                                  )
                                : Container(
                                    height: 38.h,
                                    width: 227.w,
                                    decoration: BoxDecoration(
                                        color: ColorManager.myProposed,
                                        borderRadius:
                                            BorderRadius.circular(19)),
                                    child: Center(
                                      child: Text(
                                        "My proposed jobs",
                                        style: getMPlusStyle(
                                            color: ColorManager.black,
                                            fontSize: FontSize.s24),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                        Spacer(
                          flex: 44,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * .2,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  controller.filter = !controller.filter;
                                  controller.update();
                                },
                                child: SizedBox(
                                    height: 28.h,
                                    width: 74.w,
                                    child: Image.asset(
                                      ImageStrings.filter,
                                      fit: BoxFit.fill,
                                    )),
                              ),
                              Spacer(
                                flex: 15,
                              ),
                            ],
                          ),
                        ),
                        Spacer(
                          flex: 44,
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: controller.filter ? 3 : 48,
                  ),
                  Flexible(
                      flex: 570,
                      child: SingleChildScrollView(
                          child: controller.filter
                              ? _filter()
                              : controller.likeSelected
                                  ? _likedServices()
                                  : controller.filterServices
                                          .containsValue(true)
                                      ? _filtred()
                                      : _all()))
                ],
              ),
      ),
    );
  }

  _all() {
    return GetX<InventoryViewModel>(
        init: InventoryViewModel(),
        builder: (controller) {
          return Column(
            children: [
              controller.swimming.length == 0
                  ? SizedBox(
                      height: 0,
                    )
                  : GestureDetector(
                      onTap: () {
                        controller.service[HomeStrings.swimmingPool] =
                            !controller.service[HomeStrings.swimmingPool]!;
                        controller.update();
                      },
                      child: _inventoryItem("swimming pool"),
                    ),
              controller.service[HomeStrings.swimmingPool]!
                  ? _inventory(
                      controller.swimming,
                    )
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
                        controller.service[HomeStrings.insect] =
                            !controller.service[HomeStrings.insect]!;
                        controller.update();
                      },
                      child: _inventoryItem("insect."),
                    ),
              controller.service[HomeStrings.insect]!
                  ? _inventory(
                      controller.insect,
                    )
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
                        controller.service[HomeStrings.cons] =
                            !controller.service[HomeStrings.cons]!;
                        controller.update();
                      },
                      child: _inventoryItem("const."),
                    ),
              controller.service[HomeStrings.cons]!
                  ? _inventory(
                      controller.constr,
                    )
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
                        controller.service[HomeStrings.tech] =
                            !controller.service[HomeStrings.tech]!;
                        controller.update();
                      },
                      child: _inventoryItem("tech."),
                    ),
              controller.service[HomeStrings.tech]!
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
                        controller.service[HomeStrings.lands] =
                            !controller.service[HomeStrings.lands]!;
                        controller.update();
                      },
                      child: _inventoryItem("lands"),
                    ),
              controller.service[HomeStrings.lands]!
                  ? _inventory(
                      controller.lands,
                    )
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
                        controller.service[HomeStrings.carp] =
                            !controller.service[HomeStrings.carp]!;
                        controller.update();
                      },
                      child: _inventoryItem("carps."),
                    ),
              controller.service[HomeStrings.carp]!
                  ? _inventory(
                      controller.carp,
                    )
                  : SizedBox(
                      height: 1,
                    ),
              SizedBox(
                height: 6.h,
              ),
            ],
          );
        });
  }

  _filtred() {
    return GetBuilder<InventoryViewModel>(
        init: InventoryViewModel(),
        builder: (controller) {
          return Column(
            children: [
              controller.filterServices[HomeStrings.swimmingPool]!
                  ? controller.swimming.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.swimmingPool] =
                                    !controller
                                        .service[HomeStrings.swimmingPool]!;
                                controller.update();
                              },
                              child: _inventoryItem("swimming pool"),
                            ),
                            controller.service[HomeStrings.swimmingPool]!
                                ? _inventory(
                                    controller.swimming,
                                  )
                                : SizedBox(
                                    height: 0.h,
                                  )
                          ],
                        )
                  : SizedBox(
                      height: 0.h,
                    ),
              SizedBox(
                height: 6.h,
              ),
              controller.filterServices[HomeStrings.insect]!
                  ? controller.insect.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.insect] =
                                    !controller.service[HomeStrings.insect]!;
                                controller.update();
                              },
                              child: _inventoryItem("insect."),
                            ),
                            controller.service[HomeStrings.insect]!
                                ? _inventory(
                                    controller.insect,
                                  )
                                : SizedBox(
                                    height: 0.h,
                                  ),
                          ],
                        )
                  : SizedBox(
                      height: 0.h,
                    ),
              SizedBox(
                height: 6.h,
              ),
              controller.filterServices[HomeStrings.cons]!
                  ? controller.constr.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.cons] =
                                    !controller.service[HomeStrings.cons]!;
                                controller.update();
                              },
                              child: _inventoryItem("const."),
                            ),
                            controller.service[HomeStrings.cons]!
                                ? _inventory(
                                    controller.constr,
                                  )
                                : SizedBox(
                                    height: 0.h,
                                  ),
                          ],
                        )
                  : SizedBox(
                      height: 0.h,
                    ),
              SizedBox(
                height: 6.h,
              ),
              controller.filterServices[HomeStrings.tech]!
                  ? controller.tech.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.tech] =
                                    !controller.service[HomeStrings.tech]!;
                                controller.update();
                              },
                              child: _inventoryItem("tech."),
                            ),
                            controller.service[HomeStrings.tech]!
                                ? _inventory(
                                    controller.tech,
                                  )
                                : SizedBox(
                                    height: 1,
                                  ),
                          ],
                        )
                  : SizedBox(
                      height: 0.h,
                    ),
              SizedBox(
                height: 6.h,
              ),
              controller.filterServices[HomeStrings.lands]!
                  ? controller.lands.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.lands] =
                                    !controller.service[HomeStrings.lands]!;
                                controller.update();
                              },
                              child: _inventoryItem("lands"),
                            ),
                            controller.service[HomeStrings.lands]!
                                ? _inventory(
                                    controller.lands,
                                  )
                                : SizedBox(
                                    height: 1,
                                  ),
                          ],
                        )
                  : SizedBox(
                      height: 0.h,
                    ),
              SizedBox(
                height: 6.h,
              ),
              controller.filterServices[HomeStrings.carp]!
                  ? controller.carp.length == 0
                      ? SizedBox(
                          height: 0,
                        )
                      : Column(
                          children: [
                            GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.carp] =
                                    !controller.service[HomeStrings.carp]!;
                                controller.update();
                              },
                              child: _inventoryItem("carps."),
                            ),
                            controller.service[HomeStrings.carp]!
                                ? _inventory(
                                    controller.carp,
                                  )
                                : SizedBox(
                                    height: 1,
                                  ),
                          ],
                        )
                  : SizedBox(
                      height: 0.h,
                    ),
              SizedBox(
                height: 6.h,
              ),
            ],
          );
        });
  }

  _filter() {
    return Builder(builder: (context) {
      return GetBuilder<InventoryViewModel>(
          init: InventoryViewModel(),
          builder: (controller) {
            return Container(
              height: 203.h,
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              decoration: BoxDecoration(
                  border: Border.all(color: ColorManager.yellow, width: 3),
                  boxShadow: [_boxShadow()],
                  color: ColorManager.whiteWithOpecity1,
                  borderRadius: BorderRadius.circular(30)),
              child: Column(
                children: [
                  SizedBox(
                    height: 22.h,
                  ),
                  Container(
                    height: 22.17.h,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Row(
                                children: [
                                  SizedBox(
                                    width: index == 0 ? 22.w : 8.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      index == 0
                                          ? controller.filterServices[
                                                  HomeStrings.swimmingPool] =
                                              !controller.filterServices[
                                                  HomeStrings.swimmingPool]!
                                          : index == 1
                                              ? controller.filterServices[HomeStrings.insect] =
                                                  !controller.filterServices[
                                                      HomeStrings.insect]!
                                              : controller.filterServices[HomeStrings.cons] =
                                                  !controller.filterServices[
                                                      HomeStrings.cons]!;

                                      controller.update();
                                    },
                                    child: Container(
                                      width: 111.w,
                                      decoration: BoxDecoration(
                                          color: index == 0
                                              ? controller.filterServices[
                                                      HomeStrings.swimmingPool]!
                                                  ? ColorManager.myProposed
                                                  : ColorManager.filterItemColor
                                              : index == 1
                                                  ? controller.filterServices[
                                                          HomeStrings.insect]!
                                                      ? ColorManager.myProposed
                                                      : ColorManager
                                                          .filterItemColor
                                                  : controller.filterServices[
                                                          HomeStrings.cons]!
                                                      ? ColorManager.myProposed
                                                      : ColorManager
                                                          .filterItemColor,
                                          border: Border.all(
                                            color: ColorManager.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          boxShadow: [_boxShadow()]),
                                      child: Center(
                                        child: FlexText(
                                          title: controller
                                              .filterServices.entries
                                              .elementAt(index)
                                              .key,
                                          style: getMPlus1cStyle(
                                              color: ColorManager.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 14.83.h,
                  ),
                  Container(
                    height: 22.17.h,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Row(
                                children: [
                                  SizedBox(
                                    width: index == 0 ? 22.w : 8.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      index == 0
                                          ? controller.filterServices[
                                              HomeStrings
                                                  .tech] = !controller
                                              .filterServices[HomeStrings.tech]!
                                          : index == 1
                                              ? controller.filterServices[HomeStrings.lands] =
                                                  !controller.filterServices[
                                                      HomeStrings.lands]!
                                              : controller.filterServices[HomeStrings.carp] =
                                                  !controller.filterServices[
                                                      HomeStrings.carp]!;
                                      controller.update();
                                    },
                                    child: Container(
                                      width: 111.w,
                                      decoration: BoxDecoration(
                                          color: index == 0
                                              ? controller.filterServices[
                                                      HomeStrings.tech]!
                                                  ? ColorManager.myProposed
                                                  : ColorManager.filterItemColor
                                              : index == 1
                                                  ? controller.filterServices[
                                                          HomeStrings.lands]!
                                                      ? ColorManager.myProposed
                                                      : ColorManager
                                                          .filterItemColor
                                                  : controller.filterServices[
                                                          HomeStrings.carp]!
                                                      ? ColorManager.myProposed
                                                      : ColorManager
                                                          .filterItemColor,
                                          border: Border.all(
                                            color: ColorManager.black,
                                          ),
                                          borderRadius:
                                              BorderRadius.circular(30.r),
                                          boxShadow: [_boxShadow()]),
                                      child: Center(
                                        child: FlexText(
                                          title: controller
                                              .filterServices.entries
                                              .elementAt(index + 3)
                                              .key,
                                          style: getMPlus1cStyle(
                                              color: ColorManager.black),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 19.83.h,
                  ),
                  Container(
                    height: 47.h,
                    child: Row(
                      children: List.generate(
                          2,
                          (index) => Row(
                                children: [
                                  SizedBox(
                                    width: index == 0 ? 121.w : 87.w,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      controller.filterTypeIndex == index
                                          ? controller.filterTypeIndex = null
                                          : controller.filterTypeIndex = index;
                                      controller.update();
                                    },
                                    child: Column(
                                      children: [
                                        Container(
                                          height: 32.h,
                                          width: 41.w,
                                          decoration: BoxDecoration(
                                              color:
                                                  controller.filterTypeIndex ==
                                                          index
                                                      ? ColorManager.myProposed
                                                      : ColorManager
                                                          .filterItemColor,
                                              border: Border.all(
                                                color: ColorManager.black,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(30.r),
                                              boxShadow: [_boxShadow()]),
                                          child: Center(
                                            child: FlexText(
                                              title: controller
                                                  .filterType.entries
                                                  .elementAt(index)
                                                  .key,
                                              style: getMPlus1cStyle(
                                                  color: ColorManager.black),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          height: 15.h,
                                          child: Center(
                                            child: FlexText(
                                              title: controller
                                                  .filterType.entries
                                                  .elementAt(index)
                                                  .value,
                                              style: getMPlus1cStyle(
                                                  color: ColorManager.black,
                                                  fontSize: FontSize.s10),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                    ),
                  ),
                  SizedBox(
                    height: 11.h,
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

  _inventory(
    List<ReplyModel> replyModel,
  ) {
    return Builder(builder: (context) {
      return GetBuilder<InventoryViewModel>(
          init: InventoryViewModel(),
          builder: (controller) {
            return Column(
              children: List.generate(
                  replyModel.length,
                  (index) => replyModel[index].accepted == "true"
                      ? controller.filterTypeIndex == 1 ||
                              controller.filterTypeIndex == null
                          ? _accepted(replyModel[index].userName)
                          : SizedBox(
                              height: 0.h,
                            )
                      : replyModel[index].reported == "true"
                          ? _reported(
                              replyModel[index].userName, replyModel[index])
                          : controller.filterTypeIndex == 0 ||
                                  controller.filterTypeIndex == null
                              ? Container(
                                  margin: EdgeInsets.only(top: 20.h),
                                  height: 422.h,
                                  width: 414.w,
                                  decoration: BoxDecoration(
                                      color: ColorManager.myProposed,
                                      border: Border.all(
                                        color: ColorManager.itemBorder,
                                      ),
                                      borderRadius: BorderRadius.circular(30),
                                      boxShadow: [_boxShadow()]),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: 10.91.h,
                                      ),
                                      Container(
                                        height: 36.04.h,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            SizedBox(
                                              width: 71.w,
                                            ),
                                            Container(
                                              height: 36.04.h,
                                              width: 113.w,
                                              alignment: Alignment.bottomLeft,
                                              child: FlexText(
                                                title:
                                                    replyModel[index].userName,
                                                style: getRegularSalsaStyle(
                                                    color: ColorManager.black,
                                                    fontSize: FontSize.s36),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 32.w,
                                            ),
                                            Container(
                                              height: 14.74.h,
                                              width: 64.w,
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
                                            SizedBox(
                                              width: 34.w,
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                replyModel[index].reported =
                                                    "true";
                                                controller.update();
                                              },
                                              child: Container(
                                                width: 15.w,
                                                height: 12.h,
                                                child: Image.asset(
                                                  ImageStrings.flag,
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 73.w),
                                        height: 15.56.h,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: List.generate(
                                              4,
                                              (index) => Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: ColorManager
                                                            .starColor,
                                                        size: 15.w,
                                                      ),
                                                      SizedBox(
                                                        width: 5.w,
                                                      )
                                                    ],
                                                  )),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 9.49.h,
                                      ),
                                      Container(
                                        height: 147.h,
                                        child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: List.generate(
                                                replyModel[index].images.length,
                                                (indexI) => SizedBox(
                                                      width: 134.w,
                                                      child: Image.network(
                                                        replyModel[index]
                                                            .images[indexI],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    )),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      Container(
                                        height: 52.h,
                                        width: 397.w,
                                        child: FlexText(
                                          title: replyModel[index].jobDetail,
                                          style: getMPlus1cStyle(
                                              color: ColorManager.black),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 21.h,
                                      ),
                                      SizedBox(
                                        height: 14.h,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 68.w,
                                            ),
                                            Container(
                                              width: 15.w,
                                              child: Image.asset(
                                                ImageStrings.avavilability,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 7.w,
                                            ),
                                            Container(
                                              width: 86.w,
                                              child: FlexText(
                                                title: HomeStrings.availability,
                                                style: getMPlusStyle(
                                                    color: ColorManager.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 15.w,
                                            ),
                                            Container(
                                              width: 64.w,
                                              child: FlexText(
                                                title: "calendar",
                                                style: getMPlusStyle(
                                                    color: ColorManager.black),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 60.w,
                                            ),
                                            Container(
                                              width: 14.w,
                                              child: Image.asset(
                                                ImageStrings.dropDownArrow,
                                                color: Colors.blue,
                                                fit: BoxFit.fill,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 9.83.h,
                                      ),
                                      SizedBox(
                                        height: 15.h,
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
                                        height: 8.83.h,
                                      ),
                                      SizedBox(
                                        height: 15.h,
                                        child: _budget(
                                            ImageStrings.location,
                                            HomeStrings.location,
                                            replyModel[index].location),
                                      ),
                                      SizedBox(
                                        height: 21.h,
                                      ),
                                      SizedBox(
                                        height: 24.93.h,
                                        child: Row(
                                          children: [
                                            SizedBox(
                                              width: 129.w,
                                            ),
                                            Container(
                                              width: 145.w,
                                              decoration: BoxDecoration(
                                                color: ColorManager.primary,
                                                borderRadius:
                                                    BorderRadius.circular(30.r),
                                                border: Border.all(
                                                    color: ColorManager.black),
                                              ),
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    width: 9.w,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      replyModel[index]
                                                          .accepted = "true";
                                                      controller.accepted(
                                                          
                                                          replyModel[index]);
                                                      controller.update();
                                                    },
                                                    child: Container(
                                                      width: 59.w,
                                                      height: 27.h,
                                                      child: FlexText(
                                                        title: "Accept",
                                                        style: getMPlus1cStyle(
                                                            color: ColorManager
                                                                .green,
                                                            fontSize:
                                                                FontSize.s18),
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5.w,
                                                  ),
                                                  Container(
                                                      width: 0.w,
                                                      child: FlexText(
                                                        title: "|",
                                                        style: getMPlus1cStyle(
                                                            color: ColorManager
                                                                .black),
                                                      )),
                                                  SizedBox(
                                                    width: 8.w,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      Get.dialog(
                                                          _cancelDialog(
                                                              "Reject"),
                                                          barrierColor:
                                                              ColorManager
                                                                  .primary
                                                                  .withOpacity(
                                                                      0));
                                                    },
                                                    child: Container(
                                                      width: 55.w,
                                                      height: 27.h,
                                                      child: FlexText(
                                                        title: "Reject",
                                                        style: getMPlus1cStyle(
                                                            color: ColorManager
                                                                .red,
                                                            fontSize:
                                                                FontSize.s18),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            SizedBox(
                                              width: 38.w,
                                            ),
                                            Column(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    if (replyModel[index]
                                                        .like
                                                        .contains(controller
                                                            .userModel
                                                            .userId)) {
                                                      replyModel[index]
                                                          .like
                                                          .remove(controller
                                                              .userModel
                                                              .userId);
                                                      controller.like(
                                                          replyModel[index]);
                                                      controller.update();
                                                    } else {
                                                      replyModel[index]
                                                          .like
                                                          .add(controller
                                                              .userModel
                                                              .userId);
                                                      controller.like(
                                                          replyModel[index]);
                                                      controller.update();
                                                    }
                                                  },
                                                  child: Container(
                                                      height: 18.73.h,
                                                      width: 18.07.w,
                                                      child: Image.asset(replyModel[
                                                                  index]
                                                              .like
                                                              .contains(
                                                                  controller
                                                                      .userModel
                                                                      .userId)
                                                          ? ImageStrings.liked
                                                          : ImageStrings.like)),
                                                ),
                                                Spacer(
                                                  flex: 5,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(
                                  height: 0.h,
                                )),
            );
          });
    });
  }

  _likedServices() {
    return GetBuilder<InventoryViewModel>(
        init: InventoryViewModel(),
        builder: (controller) {
          return SingleChildScrollView(
            child: controller.filter
                ? _filter()
                : Column(
                    children: [
                      controller.swimming
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .length ==
                              0
                          ? SizedBox(
                              height: 0,
                            )
                          : GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.swimmingPool] =
                                    !controller
                                        .service[HomeStrings.swimmingPool]!;
                                controller.update();
                              },
                              child: _inventoryItem("swimming pool"),
                            ),
                      controller.service[HomeStrings.swimmingPool]!
                          ? _inventory(
                              controller.swimming
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .toList(),
                            )
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.insect
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .length ==
                              0
                          ? SizedBox(
                              height: 0,
                            )
                          : GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.insect] =
                                    !controller.service[HomeStrings.insect]!;
                                controller.update();
                              },
                              child: _inventoryItem("insect."),
                            ),
                      controller.service[HomeStrings.insect]!
                          ? _inventory(
                              controller.insect
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .toList(),
                            )
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.constr
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .length ==
                              0
                          ? SizedBox(
                              height: 0,
                            )
                          : GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.cons] =
                                    !controller.service[HomeStrings.cons]!;
                                controller.update();
                              },
                              child: _inventoryItem("const."),
                            ),
                      controller.service[HomeStrings.cons]!
                          ? _inventory(
                              controller.constr
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .toList(),
                            )
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.tech
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .length ==
                              0
                          ? SizedBox(
                              height: 0,
                            )
                          : GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.tech] =
                                    !controller.service[HomeStrings.tech]!;
                                controller.update();
                              },
                              child: _inventoryItem("tech."),
                            ),
                      controller.service[HomeStrings.tech]!
                          ? _inventory(
                              controller.tech
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .toList(),
                            )
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.lands
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .length ==
                              0
                          ? SizedBox(
                              height: 0,
                            )
                          : GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.lands] =
                                    !controller.service[HomeStrings.lands]!;
                                controller.update();
                              },
                              child: _inventoryItem("lands"),
                            ),
                      controller.service[HomeStrings.lands]!
                          ? _inventory(
                              controller.lands
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .toList(),
                            )
                          : SizedBox(
                              height: 1,
                            ),
                      SizedBox(
                        height: 6.h,
                      ),
                      controller.carp
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .length ==
                              0
                          ? SizedBox(
                              height: 0,
                            )
                          : GestureDetector(
                              onTap: () {
                                controller.service[HomeStrings.carp] =
                                    !controller.service[HomeStrings.carp]!;
                                controller.update();
                              },
                              child: _inventoryItem("carps."),
                            ),
                      controller.service[HomeStrings.carp]!
                          ? _inventory(
                              controller.carp
                                  .where((p0) => p0.like
                                      .contains(controller.userModel.userId))
                                  .toList(),
                            )
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

  _cancelDialog(String name) {
    return Builder(builder: (context) {
      return Container(
          margin: EdgeInsets.symmetric(
            vertical: MediaQuery.of(context).size.height * .39,
            horizontal: MediaQuery.of(context).size.width * .03,
          ),
          decoration: BoxDecoration(
              color: ColorManager.primary,
              border: Border.all(color: ColorManager.black),
              borderRadius: BorderRadius.circular(30.r),
              boxShadow: [_boxShadow()]),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * .05,
              ),
              Text(
                "Are you sure you want\nto $name?",
                style: getMPlus1cStyle(
                    color: ColorManager.black, fontSize: FontSize.s24),
              ),
              SizedBox(
                height: 2,
              ),
              Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * .42,
                    right: MediaQuery.of(context).size.width * .2),
                decoration: BoxDecoration(
                    color: ColorManager.primary,
                    border: Border.all(color: ColorManager.black),
                    borderRadius: BorderRadius.circular(30.r)),
                child: Center(
                  child: Text(
                    name,
                    style: getMPlus1cStyle(
                        color: ColorManager.red, fontSize: FontSize.s18),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * .01,
              ),
            ],
          ));
    });
  }

  _accepted(String name) {
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
                          title: name,
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
            GetBuilder<ControlViewModel>(
                init: ControlViewModel(),
                builder: (Controlcontroller) {
                  return GestureDetector(
                    onTap: () {
                      Controlcontroller.currentScreen = ChatView();

                      Controlcontroller.update();
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
                        Get.dialog(
                            GetBuilder<InventoryViewModel>(
                                init: InventoryViewModel(),
                                builder: (controller) {
                                  return RatingView(
                                    userName: name,
                                    callAnswerRate:
                                        controller.callAnswerRate.toDouble(),
                                    serviceRate:
                                        controller.serviceRate.toDouble(),
                                    priceRate: controller.priceRate.toDouble(),
                                    timeRate: controller.timeRate.toDouble(),
                                    onChangedcallAnswerRate: (p0) {
                                      controller.callAnswerRate = p0.toInt();
                                      controller.update();
                                    },
                                    onChangedserviceRate: (p0) {
                                      controller.serviceRate = p0.toInt();
                                      controller.update();
                                    },
                                    onChangedpriceRate: (p0) {
                                      controller.priceRate = p0.toInt();
                                      controller.update();
                                    },
                                    onChangedtimeRate: (p0) {
                                      controller.timeRate = p0.toInt();
                                      controller.update();
                                    },
                                  );
                                }),
                            barrierColor: ColorManager.primary.withOpacity(0));
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
                      onTap: () {
                        Get.dialog(_cancelDialog("Cancel"),
                            barrierColor: ColorManager.primary.withOpacity(0));
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
          width: 68.w,
        ),
        Container(
          height: 13.92.h,
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
          height: 13.92.h,
          width: 86.w,
          child: FlexText(
            title: name,
            style: getMPlusStyle(color: ColorManager.black),
          ),
        ),
        SizedBox(
          width: 13.w,
        ),
        Container(
          height: 14.h,
          width: 126.w,
          child: FlexText(
            title: value,
            style: getMPlusStyle(color: ColorManager.black),
          ),
        ),
      ],
    );
  }

  _inventoryItem(String name) {
    return Row(
      children: [
        Container(
          height: 37.h,
          width: 243.w,
          decoration: BoxDecoration(color: ColorManager.yellow),
          child: Row(
            children: [
              Spacer(
                flex: 13,
              ),
              Flexible(
                flex: 166,
                fit: FlexFit.tight,
                child: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: FlexText(
                    title: name,
                    style: getMPlusStyle(
                        color: ColorManager.black, fontSize: FontSize.s24),
                  ),
                ),
              ),
              Spacer(
                flex: 15,
              ),
              Flexible(
                flex: 30,
                fit: FlexFit.tight,
                child: Column(
                  children: [
                    Spacer(
                      flex: 12,
                    ),
                    Flexible(
                      flex: 11,
                      child: Image.asset(
                        ImageStrings.inventoryItem,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Spacer(
                      flex: 14,
                    ),
                  ],
                ),
              ),
              Spacer(
                flex: 15,
              )
            ],
          ),
        ),
        Spacer(
          flex: 143,
        )
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

  _reported(String name, ReplyModel replyModel) {
    return GetBuilder<InventoryViewModel>(
        init: InventoryViewModel(),
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
                        replyModel.reported = "false";
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
}

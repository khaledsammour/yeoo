import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';

DateTime? avavilabilityFrom, avavilabilityTo;

class AvavilabilityBottomSheet extends StatelessWidget {
  const AvavilabilityBottomSheet({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final Function()? onTap;
  @override
  Widget build(BuildContext context) {
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
                      "Select avavilabilty dates",
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
              GestureDetector(
                onTap: () => Get.bottomSheet(_selectAvavilabilityFrom()),
                child: Container(
                  height: MediaQuery.of(context).copyWith().size.height * .2,
                  child: Row(
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width * .4,
                        color: ColorManager.sendBackground,
                        child: Center(
                          child: FlexText(
                            title: "Avavilability From",
                            style: getBoldStyle(color: ColorManager.black),
                          ),
                        ),
                      ),
                      Spacer(
                        flex: 1,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * .4,
                        color: ColorManager.sendBackground,
                        child: GestureDetector(
                          onTap: () {
                            Get.bottomSheet(_selectAvavilabilityTo());
                          },
                          child: Center(
                            child: FlexText(
                              title: "Avavilability To",
                              style: getBoldStyle(color: ColorManager.black),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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

  _selectAvavilabilityFrom() {
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
                    FlexText(
                      title: "Select avavilabilty dates From",
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
                  onDateTimeChanged: (value) {
                    avavilabilityFrom = value;
                  },
                  minuteInterval: 1,
                  mode: CupertinoDatePickerMode.dateAndTime,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
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

  _selectAvavilabilityTo() {
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
                    FlexText(
                      title: "Select avavilabilty dates To",
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
                  onDateTimeChanged: (value) {
                    avavilabilityTo = value;
                  },
                  minuteInterval: 1,
                  mode: CupertinoDatePickerMode.dateAndTime,
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.back();
                },
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

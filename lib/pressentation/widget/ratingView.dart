import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';

class RatingView extends StatelessWidget {
  const RatingView(
      {Key? key,
      required this.onChangedcallAnswerRate,
      required this.onChangedserviceRate,
      required this.onChangedpriceRate,
      required this.onChangedtimeRate,
      required this.userName,
      required this.callAnswerRate,
      required this.serviceRate,
      required this.priceRate,
      required this.timeRate})
      : super(key: key);
  final double callAnswerRate, serviceRate, priceRate, timeRate;
  final String userName;
  final Function(double)? onChangedcallAnswerRate;
  final Function(double)? onChangedserviceRate;
  final Function(double)? onChangedpriceRate;
  final Function(double)? onChangedtimeRate;
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(
          vertical: MediaQuery.of(context).size.height * .252,
          horizontal: MediaQuery.of(context).size.width * .1,
        ),
        decoration: BoxDecoration(
            color: ColorManager.primary,
            border: Border.all(color: ColorManager.black),
            borderRadius: BorderRadius.circular(30.r),
            boxShadow: [_boxShadow()]),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  width: 36.w,
                ),
                Container(
                  height: 40.h,
                  width: 113.w,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        height: 26.h,
                        width: 113.w,
                        alignment: Alignment.bottomLeft,
                        child: FlexText(
                            title: userName,
                            textAlign: TextAlign.end,
                            style: getRegularSalsaStyle(
                                color: ColorManager.black,
                                fontSize: FontSize.s36)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: List.generate(
                            4,
                            (index) => Icon(
                                  Icons.star,
                                  color: ColorManager.starColor,
                                  size: 12.h,
                                )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  width: 34.w,
                ),
                Container(
                  height: 15.h,
                  width: 64.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(90.r),
                    color: ColorManager.well,
                  ),
                  child: FlexText(
                    title: "Well",
                    style: getRegularSalsaStyle(
                      color: ColorManager.black,
                      fontSize: FontSize.s18,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: 43.w,
                ),
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    width: 33.w,
                    child: Image.asset(
                      ImageStrings.x,
                      color: ColorManager.red,
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              height: 7.h,
            ),
            Container(
              height: 1.h,
              color: ColorManager.black,
            ),
            SizedBox(
              height: 45.h,
            ),
            _ratingItem("Call answer", callAnswerRate, onChangedcallAnswerRate),
            SizedBox(
              height: 11.h,
            ),
            _ratingItem("Service", serviceRate, onChangedserviceRate),
            SizedBox(
              height: 11.h,
            ),
            _ratingItem("Price", priceRate, onChangedpriceRate),
            SizedBox(
              height: 11.h,
            ),
            _ratingItem("Time", timeRate, onChangedtimeRate),
            SizedBox(
              height: 32.h,
            ),
            Material(
              color: ColorManager.primary,
              child: Container(
                height: 97.h,
                width: 242.w,
                decoration: BoxDecoration(
                    color: ColorManager.myProposed,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [_boxShadow()]),
                child: TextFormField(
                  style: getMPlus1cStyle(color: ColorManager.black),
                  onChanged: (v) {},
                  keyboardType: TextInputType.multiline,
                  maxLines: 12,
                  decoration: InputDecoration(
                    hintText: "How good they are!",
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(20.h),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 24.h,
            ),
            Container(
              height: 25,
              width: 153.w,
              decoration: BoxDecoration(
                  color: ColorManager.primary,
                  border: Border.all(
                    color: ColorManager.black,
                  ),
                  borderRadius: BorderRadius.circular(30.r)),
              child: Center(
                child: FlexText(
                  title: "Rate",
                  style: getMPlus1cStyle(
                      color: ColorManager.black, fontSize: FontSize.s24),
                ),
              ),
            ),
          ],
        ));
  }

  _ratingItem(name, value, onChanged) {
    return Container(
      height: 15.h,
      child: Row(
        children: [
          SizedBox(
            width: 12.w,
          ),
          Container(
            width: 100.w,
            child: FlexText(
                title: name, style: getMPlus1cStyle(color: ColorManager.black)),
          ),
          Material(
            child: Container(
              width: 153.w,
              height: 15.h,
              decoration: BoxDecoration(border: Border.all()),
              child: SliderTheme(
                data: SliderThemeData(
                  trackHeight: 14.h,
                  trackShape: RectangularSliderTrackShape(),
                  overlayShape: SliderComponentShape.noOverlay,
                  valueIndicatorShape: SliderComponentShape.noOverlay,
                  thumbShape: SliderComponentShape.noThumb,
                  activeTrackColor: ColorManager.ratingColor,
                  inactiveTrackColor: ColorManager.primary,
                  valueIndicatorColor: ColorManager.red,
                  thumbColor: ColorManager.black,
                ),
                child: Slider(
                  min: 0,
                  max: 100,
                  value: value,
                  onChanged: onChanged,
                ),
              ),
            ),
          ),
          SizedBox(
            width: 12.w,
          ),
          Container(
            width: 28.w,
            child: FlexText(
                title: value.toInt().toString() + "%",
                style: getRegularSalsaStyle(color: ColorManager.black)),
          ),
        ],
      ),
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

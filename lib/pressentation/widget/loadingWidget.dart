import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 200.h,
        width: 200.w,
        child: Shimmer.fromColors(
          child: Image.asset(ImageStrings.bigPolygon),
          baseColor: ColorManager.grey,
          highlightColor: ColorManager.yellow,
          period: Duration(milliseconds: 500),
        ),
      ),
    );
  }
}

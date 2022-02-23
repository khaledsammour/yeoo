import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';

class PicView extends StatelessWidget {
  const PicView({
    Key? key,
    required this.itemCount,
    required this.path,
  }) : super(key: key);
  final int itemCount;

  final List<dynamic> path;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            PhotoViewGallery.builder(
                itemCount: itemCount,
                backgroundDecoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100.r)),
                builder: (context, index) {
                  return PhotoViewGalleryPageOptions(
                    imageProvider: FileImage(
                      File(
                        path[index],
                      ),
                    ),
                  );
                }),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                margin: EdgeInsets.only(top: AppMargin.m20.h),
                height: 60.h,
                width: 50.w,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(width: 3.w),
                    color: ColorManager.yellow),
                child: Image.asset(ImageStrings.x),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

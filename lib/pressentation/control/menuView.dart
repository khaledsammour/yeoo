import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stringsManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';
import 'package:yeeo/pressentation/resource/valuesManager.dart';
import 'package:yeeo/pressentation/widget/flexText.dart';

class MenuView extends StatelessWidget {
  const MenuView({Key? key, required this.onLogOut}) : super(key: key);
  final Function()? onLogOut;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 11.h,
          ),
          Container(
            height: 36.h,
            width: 129.w,
            margin: EdgeInsets.only(left: 132.w),
            child: FlexText(
              title: "My account",
              style: getMPlus1cStyle(
                  color: ColorManager.black, fontSize: FontSize.s24),
            ),
          ),
          SizedBox(
            height: 79.h,
          ),
          _menuItems(title: "History"),
          SizedBox(
            height: 87.h,
          ),
          _menuItems(title: "settings"),
          SizedBox(
            height: 71.h,
          ),
          _menuItems(title: "Guide"),
          SizedBox(
            height: 7.h,
          ),
          _menuItems(title: "About Yeeo"),
          SizedBox(
            height: 12.h,
          ),
          _menuItems(
            title: "Log out",
            onTap: onLogOut,
          ),
        ],
      ),
    );
  }

  _menuItems({title, Function()? onTap}) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        child: Container(
          height: 55,
          decoration: BoxDecoration(
              color: ColorManager.primary,
              border: Border.symmetric(
                  horizontal: BorderSide(color: ColorManager.grey, width: 1))),
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 56.w,
                ),
                SizedBox(
                  width: 123.w,
                  child: FlexText(
                      title: title,
                      style: getMPlus1cStyle(
                          color: ColorManager.black, fontSize: FontSize.s24)),
                ),
                SizedBox(
                  width: 190.w,
                ),
                Container(
                  height: 20.35.h,
                  width: 27.47.w,
                  child: Image.asset(
                    ImageStrings.menuItemPolygon,
                    fit: BoxFit.fill,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

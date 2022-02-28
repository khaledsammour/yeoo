import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:yeeo/pressentation/resource/colorManager.dart';
import 'package:yeeo/pressentation/resource/stylesManager.dart';

class FlexTextFiled extends StatelessWidget {
  const FlexTextFiled({
    Key? key,
    required this.textInputType,
    required this.autofillHints,
    required this.onChanged,
    this.onEyeTap,
    required this.left,
    this.obscureText = false,
    this.width = 199,
    this.height = 27,
    this.password = false,
    required this.validator,
  }) : super(key: key);
  final TextInputType textInputType;
  final String autofillHints;
  final bool obscureText;
  final double left;
  final double width;
  final double height;
  final String? Function(String?)? validator;
  final Function(String) onChanged;
  final Function()? onEyeTap;
  final bool password;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: left.w),
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: ColorManager.black),
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: const [
            BoxShadow(
                color: Colors.black26, blurRadius: 6, offset: Offset(0, 2))
          ]),
      child: TextFormField(
        validator: validator,
        onChanged: onChanged,
        keyboardType: textInputType,
        obscureText: obscureText,
        style: getMeduimStyle(color: ColorManager.black),
        autofillHints: [autofillHints],
        decoration: InputDecoration(
          border: InputBorder.none,
          suffixIcon: password
              ? IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Container(
                    child: Icon(
                      Icons.remove_red_eye,
                      size: 20,
                      color:
                          obscureText ? ColorManager.grey : ColorManager.blue,
                    ),
                  ),
                  onPressed: onEyeTap,
                )
              : SizedBox(
                  height: 0.h,
                ),
          contentPadding:
              EdgeInsets.symmetric(vertical: height.h / 2.h, horizontal: 5.w),
        ),
      ),
    );
  }
}

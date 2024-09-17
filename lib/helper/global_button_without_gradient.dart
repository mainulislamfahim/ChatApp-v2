import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../gen/colors.gen.dart';
import 'app_text_style.dart';

Widget globalButtonWithoutGradient(
    {required VoidCallback onTap,
    required String text,
    Color? shadowColor,
    double? height,
    double? blurRadius,
    double? width,
    double? fontSize,
    BorderRadius? borderRadius,
    Color? borderColor,
      Color? fontColor,
      Color? btnColor,
      FontWeight? fontWeight,
    }) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 45.h,
      width: width ?? Get.width,
      decoration: BoxDecoration(
        color:  btnColor ?? ColorName.primaryColor,
        borderRadius: borderRadius ?? BorderRadius.circular(50.r),
        border: Border.all(color: borderColor ?? Colors.grey.shade100),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? Colors.transparent,
            blurRadius: blurRadius ?? 25,
            offset: const Offset(1, 2),
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: AppTextStyle(
          text: text,
          color: fontColor ?? Colors.white,
          fontSize: fontSize ?? 16.sp,
          fontWeight: fontWeight ??  FontWeight.bold,
        ),
      ),
    ),
  );
}

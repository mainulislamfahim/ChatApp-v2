import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'app_linear_gradient.dart';
import 'app_text_style.dart';

Widget globalButton(
    {required VoidCallback onTap,
    required String text,
    Color? shadowColor,
    double? height,
    double? blurRadius,
    double? width,
    double? fontSize,FontWeight? fontWeight,
    BorderRadius? borderRadius,
    LinearGradient? gradient,
    }) {
  return InkWell(
    onTap: onTap,
    child: Container(
      height: height ?? 45.h,
      width: width ?? Get.width,
      decoration: BoxDecoration(
        gradient: gradient ?? appLinearGradient(),
        borderRadius: borderRadius ?? BorderRadius.circular(50.r),
        boxShadow: [
          BoxShadow(
            color: shadowColor ?? const Color(0xff2575fc),
            blurRadius: blurRadius ?? 10,
            offset: const Offset(0, 1),
            spreadRadius: 0,
          )
        ],
      ),
      child: Center(
        child: AppTextStyle(
          text: text,
          color: Colors.white,
          fontSize: fontSize ?? 18.sp,
          fontWeight: fontWeight ?? FontWeight.w600,
        ),
      ),
    ),
  );
}

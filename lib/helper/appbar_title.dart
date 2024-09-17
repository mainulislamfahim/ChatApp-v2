import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'app_text_style.dart';

Widget appbarTitle({required String text, double? fontSize, FontWeight? fontWeight}){
  return AppTextStyle(
    text: text,
    fontSize: fontSize ?? 18.sp,
    fontWeight: fontWeight ?? FontWeight.w600,
  );
}
import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:random_avatar/random_avatar.dart';

Widget avatar({double? height, double? width}){
  return RandomAvatar(
    DateTime.now().toIso8601String(),
    height: height ?? 50.h,
    width: width ?? 52.w,
  );
}
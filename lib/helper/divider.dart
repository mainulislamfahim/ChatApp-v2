import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget customDivider({
  Color? color,
  double? paddingHorizontal}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: paddingHorizontal ?? 10.w),
    child: Divider(
      color: color ?? Colors.pink.shade50,
    ),
  );
}

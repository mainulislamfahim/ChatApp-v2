import 'package:flutter/cupertino.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../gen/colors.gen.dart';

Widget loadingAnimationWidget({
  Color? color,
  double? size,
}) {
  return Center(child: LoadingAnimationWidget.prograssiveDots(color: color ?? ColorName.primaryColor, size: size ?? 40));
}
import 'package:chatapp/app/routes/app_pages.dart';
import 'package:chatapp/gen/assets.gen.dart';
import 'package:chatapp/gen/colors.gen.dart';
import 'package:chatapp/helper/global_button_without_gradient.dart';
import 'package:chatapp/helper/sizedbox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../controllers/auth_controller.dart';

class AuthView extends GetView<AuthController> {
  const AuthView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorName.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Image.asset(
                Assets.images.chatting.path,
                height: 500.h,
              ),
              // const Spacer(),
              Align(
                  alignment: Alignment.center,
                  child: globalButtonWithoutGradient(
                      onTap: () {
                        Get.toNamed(Routes.LOGIN);
                      },
                      text: 'Sign In',
                      width: Get.width / 3,
                      height: 35.h,
                      btnColor: ColorName.green)),
              15.height,
              Align(
                alignment: Alignment.center,
                child: globalButtonWithoutGradient(
                  onTap: () {
                    Get.toNamed(Routes.REGISTER);
                  },
                  text: 'Sign Up',
                  width: Get.width / 3,
                  height: 35.h,
                  btnColor: ColorName.primaryColor,
                ),
              ),
              const Spacer(flex: 2),
            ],
          ),
        ),
      ),
    );
  }
}

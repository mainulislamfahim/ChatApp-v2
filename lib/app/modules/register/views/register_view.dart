import 'package:chatapp/gen/colors.gen.dart';
import 'package:chatapp/helper/app_text_style.dart';
import 'package:chatapp/helper/sizedbox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../controllers/register_controller.dart';

class RegisterView extends GetView<RegisterController> {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: constraints.maxHeight * 0.1),
                  SvgPicture.asset(
                    Assets.images.signup,
                    height: 200.h,
                  ),
                  SizedBox(height: constraints.maxHeight * 0.1),
                  Obx(() {
                    return CircleAvatar(
                      radius: 50,
                      backgroundColor: ColorName.gray70,
                      foregroundImage: controller.pickedImage.value != null
                          ? FileImage(controller.pickedImage.value!)
                          : null,
                    );
                  }),
                  3.height,
                  TextButton(
                    onPressed: () {
                      controller.pickImage();
                    },
                    child: AppTextStyle(
                      text: 'Add Image',
                      fontWeight: FontWeight.w500,
                      color: ColorName.primaryColor,
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: constraints.maxHeight * 0.05),
                  Column(
                    children: [
                      TextFormField(
                        controller: controller.usernameController,
                        decoration: const InputDecoration(
                          hintText: 'Username',
                          filled: true,
                          fillColor: Color(0xFFF5FCF9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0 * 1.5, vertical: 16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        onSaved: (username) {
                          // Save it
                        },
                      ),
                      10.height,
                      TextFormField(
                        controller: controller.emailController,
                        decoration: const InputDecoration(
                          hintText: 'Email',
                          filled: true,
                          fillColor: Color(0xFFF5FCF9),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.0 * 1.5, vertical: 16.0),
                          border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                          ),
                        ),
                        keyboardType: TextInputType.text,
                        onSaved: (email) {
                          // Save it
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Obx(() {
                          return TextFormField(
                            controller: controller.passwordController,
                            obscureText: controller.obscureText.value,
                            // Use a boolean variable to control visibility
                            decoration: InputDecoration(
                              hintText: 'Password',
                              filled: true,
                              fillColor: const Color(0xFFF5FCF9),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 16.0 * 1.5, vertical: 16.0),
                              border: const OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  controller.obscureText.value
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                ),
                                onPressed: () {
                                  controller.obscureText.value =
                                      !controller.obscureText.value;
                                },
                              ),
                            ),
                            onSaved: (password) {
                              // Save it
                            },
                          );
                        }),
                      ),
                      Obx(() => controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                controller.signUp(
                                  controller.usernameController.text,
                                    controller.emailController.text,
                                    controller.passwordController.text);
                              },
                              style: ElevatedButton.styleFrom(
                                elevation: 0,
                                backgroundColor: const Color(0xFF00BF6D),
                                foregroundColor: Colors.white,
                                minimumSize: const Size(double.infinity, 48),
                                shape: const StadiumBorder(),
                              ),
                              child: const Text("Sign Up"),
                            )),
                      16.height,
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'Forgot Password?',
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.64),
                                  ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Get.toNamed(Routes.LOGIN);
                        },
                        child: Text.rich(
                          const TextSpan(
                            text: "Have an account? ",
                            children: [
                              TextSpan(
                                text: "Sign In",
                                style: TextStyle(color: Color(0xFF00BF6D)),
                              ),
                            ],
                          ),
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyLarge!
                                        .color!
                                        .withOpacity(0.64),
                                  ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

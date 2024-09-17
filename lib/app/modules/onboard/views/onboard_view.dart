import 'package:chatapp/helper/sizedbox_extension.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../gen/assets.gen.dart';
import '../../../routes/app_pages.dart';
import '../../auth/widgets/PresenceService.dart';
import '../controllers/onboard_controller.dart';

class OnboardView extends GetView<OnboardController> {
  const OnboardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (_, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Column(
                  children: [
                    const Spacer(flex: 2),
                    Image.asset(Assets.images.welcomeImage.path),
                    const Spacer(flex: 3),
                    Text(
                      "Welcome to our freedom \nmessaging app",
                      textAlign: TextAlign.center,
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    Text(
                      "Freedom talk any person of your \nmother language.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .color!
                            .withOpacity(0.64),
                      ),
                    ),
                    const Spacer(flex: 3),
                  ],
                );
              } else if (snapshot.hasData) {
                final user = FirebaseAuth.instance.currentUser;
                if (user != null) {
                  PresenceService.updateUserPresence(user.uid);
                }
                Future.microtask(() => Get.toNamed(Routes.HOMEE));
                return const SizedBox();
              } else {
                Future.delayed(const Duration(seconds: 2), () => Get.toNamed(Routes.AUTH));
                return const SizedBox();
              }
            }),
      ),
    );
  }
}

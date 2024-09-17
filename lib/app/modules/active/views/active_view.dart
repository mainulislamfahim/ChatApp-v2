import 'package:chatapp/helper/sizedbox_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../helper/app_text_style.dart';
import '../../../routes/app_pages.dart';
import '../controllers/active_controller.dart';

class ActiveView extends GetView<ActiveController> {
  const ActiveView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(ActiveController());
    return Scaffold(
    body: Obx(() {
      // Check if there are active users
      if (controller.activeUsers.isEmpty) {
        return const Center(child: Text('No active users'));
      }

      // Display the list of active users
      return ListView.builder(
        itemCount: controller.activeUsers.length,
        itemBuilder: (context, index) {
          final user = controller.activeUsers[index];
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: (){
                Get.toNamed(Routes.CHAT, arguments: user.id);
              },
              borderRadius: BorderRadius.circular(30.r),
              child: Container(
                margin: const EdgeInsets.all(8),
                height: 55.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  color: ColorName.white,
                  border: Border.all(color: ColorName.gray70),
                ),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25.r,
                      backgroundImage: NetworkImage(user.imgUrl),
                    ),
                    10.width, // Spacing between avatar and text
                    AppTextStyle(
                      text: user.name.toString().capitalize!,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                    const Spacer(),
                    user.online ? 
                        Row(
                          children: [
                            const Icon(Icons.online_prediction, color: ColorName.green,size: 15),
                            2.width,
                            AppTextStyle(text: 'Online', fontSize: 12.sp,fontWeight: FontWeight.w600,)
                          ],
                        ): Row(
                      children: [
                        const Icon(Icons.online_prediction, color: ColorName.gray410,size: 15),
                        2.width,
                        AppTextStyle(text: 'Offline', fontSize: 12.sp,fontWeight: FontWeight.w600,)
                      ],
                    ),
                    15.width,
                  ],
                ),
              ),
            ),
          );
        },
      );
    }),
    );
  }
}

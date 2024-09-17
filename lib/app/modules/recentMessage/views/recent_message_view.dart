import 'package:chatapp/helper/sizedbox_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';

import '../../../../gen/colors.gen.dart';
import '../../../../helper/app_text_style.dart';
import '../../../../helper/loading_animation_widget.dart';
import '../../../routes/app_pages.dart';
import '../controllers/recent_message_controller.dart';

class RecentMessageView extends GetView<RecentMessageController> {
  const RecentMessageView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (_, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return loadingAnimationWidget();
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return AppTextStyle(
              text: 'No User Found',
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            );
          } else {
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (_, index) {
                final userData = users[index].data(); // Ensure it's a Map
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: (){
                      Get.toNamed(Routes.CHAT);
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
                            backgroundImage: NetworkImage(userData['imgUrl']),
                          ),
                          10.width, // Spacing between avatar and text
                          AppTextStyle(
                            text: userData['username'].toString().capitalize!,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

import 'package:chatapp/app/modules/active/views/active_view.dart';
import 'package:chatapp/app/modules/auth/views/auth_view.dart';
import 'package:chatapp/app/modules/homee/messageBubble.dart';
import 'package:chatapp/app/modules/recentMessage/views/recent_message_view.dart';
import 'package:chatapp/app/routes/app_pages.dart';
import 'package:chatapp/gen/colors.gen.dart';
import 'package:chatapp/helper/app_text_style.dart';
import 'package:chatapp/helper/appbar_title.dart';
import 'package:chatapp/helper/loading_animation_widget.dart';
import 'package:chatapp/helper/sizedbox_extension.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:get/get.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:tab_indicator_styler/tab_indicator_styler.dart';

import '../../../../helper/app_text_style_over_flow.dart';
import '../../../../helper/log_printer.dart';
import '../controllers/homee_controller.dart';

class HomeeView extends GetView<HomeeController> {
  const HomeeView({super.key});

  @override
  Widget build(BuildContext context) {
    const selectColor = Colors.white;
    const unselectColor = Colors.black;
    Get.put(HomeeController());
    return Scaffold(
      appBar: AppBar(
        title: appbarTitle(text: 'Home'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
              },
              icon: const Icon(
                Icons.logout,
                color: ColorName.primaryColor,
              ))
        ],
      ),
      body: Column(
        children: [
          Container(
            height: 60,

            child: Obx(() => TabBar(
              indicatorWeight: 0,
              tabAlignment: TabAlignment.fill,
              controller: controller.tabController,
              dividerColor: Colors.transparent,
              automaticIndicatorColorAdjustment: true,
              indicatorSize: TabBarIndicatorSize.tab,
              indicator: RectangularIndicator(
                color: ColorName.primaryColor,
                bottomLeftRadius: 8,
                bottomRightRadius: 8,
                topLeftRadius: 8,
                topRightRadius: 8,
                paintingStyle: PaintingStyle.fill,
              ),
              unselectedLabelColor: Colors.black,

              onTap: (index) {
                controller.updateSelectedTab(index);
              },
              tabs: [

                AppTextStyle(
                  text: 'Recent Message',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  height: 0,
                  color: controller.selectedTabIndex.value == 0
                      ? selectColor
                      : unselectColor,
                ),
                AppTextStyleOverFlow(
                  text: 'Active',
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  height: 0,
                  color: controller.selectedTabIndex.value == 1
                      ? selectColor
                      : unselectColor,
                ),
              ],
            )),
          ),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: controller.tabController,
              // physics: const ClampingScrollPhysics(),
              children: const [RecentMessageView(), ActiveView()],
            ),
          ),
        ],
      ),
    );
  }
}

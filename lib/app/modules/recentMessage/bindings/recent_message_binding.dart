import 'package:get/get.dart';

import '../controllers/recent_message_controller.dart';

class RecentMessageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RecentMessageController>(
      () => RecentMessageController(),
    );
  }
}

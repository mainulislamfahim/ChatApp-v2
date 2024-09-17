import 'package:get/get.dart';

import '../controllers/active_controller.dart';

class ActiveBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ActiveController>(
      () => ActiveController(),
    );
  }
}

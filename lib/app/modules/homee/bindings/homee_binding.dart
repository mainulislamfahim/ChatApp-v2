import 'package:get/get.dart';

import '../controllers/homee_controller.dart';

class HomeeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeeController>(
      () => HomeeController(),
    );
  }
}

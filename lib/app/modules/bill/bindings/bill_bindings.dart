import 'package:get/get.dart';
import 'package:home_services_provider/app/modules/auth/controllers/auth_controller.dart';

import '../controllers/bill_controller.dart';

class BillBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<BillController>(
      () => BillController(),
    );
  }
}

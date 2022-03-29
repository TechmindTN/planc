import 'package:get/get.dart';
import 'package:home_services_provider/app/modules/e_services/controllers/e_service_controller.dart';
import 'package:home_services_provider/app/modules/profile/controllers/profile_controller.dart';

import '../controllers/auth_controller.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthController(), permanent: true);
    Get.put(ProfileController(), permanent: true);
    Get.put(EServiceController(), permanent: true);
    // Get.lazyPut<AuthController>(
    //   () => AuthController(),
    // );
  }
}

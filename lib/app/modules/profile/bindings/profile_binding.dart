import 'package:get/get.dart';
import 'package:home_services_provider/app/modules/auth/controllers/auth_controller.dart';
import 'package:home_services_provider/app/modules/e_services/controllers/e_services_controller.dart';

import '../controllers/profile_controller.dart';

class ProfileBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<ProfileController>(
      ProfileController(),
      permanent: true
    );
    Get.put<AuthController>(
      AuthController(),
      permanent: true
    );
    Get.put<EServicesController>(
      EServicesController(),
      permanent: true
    );
    // Get.lazyPut<ProfileController>(
    //   () => ProfileController(),
    // );
    //  Get.lazyPut<AuthController>(
    //   () => AuthController(), 
    // );
  }
}

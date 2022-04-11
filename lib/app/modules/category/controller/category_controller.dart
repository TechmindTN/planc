// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_state_manager/src/simple/get_controllers.dart';
// import 'package:home_services_provider/app/models/Provider.dart';

// import '../../../../common/ui.dart';
// import '../../../Network/CategoryNetwork.dart';
// import '../../../Network/ServiceProviderNetwork.dart';
// import '../../../models/User.dart';
// import '../../../routes/app_pages.dart';
// import '../../auth/controllers/auth_controller.dart';
// import '../../e_services/controllers/e_service_controller.dart';
// import '../../e_services/controllers/e_services_controller.dart';

// class ProfileController extends GetxController {
//   EServicesController eServicesController;
//   ServiceProviderNetwork providerNetwork = ServiceProviderNetwork();
//   Rx<ServiceProvider> serviceProvider = ServiceProvider().obs;
//   Rx<User> user = User().obs;
//   @override
//   void onInit() {
//     Get.put(EServiceController());
//     serviceProvider.value = ServiceProvider(categories: []);
//     user.value = Get.find<AuthController>().currentUser.value;

//     super.onInit();
//   }

//   prepareCategories() {
//     int index = 0;
//     Get.find<EServicesController>().categories.forEach((element) {
//       if (Get.find<EServicesController>().chosencats[index]) {
//         DocumentReference categ = categoryNetwork.getCategoryRef(element.id);
//         cat.add(categ);
//       }
//       index++;
//     });
//   }

//   List<DocumentReference> cat = [];
//   CategoryNetwork categoryNetwork = CategoryNetwork();
//   Future<void> saveCategory(
//       GlobalKey<FormState> profileForm, tempProvider) async {
//     try {
//       if (profileForm.currentState.validate()) {
//         prepareCategories();
//         providerNetwork.addCategory(serviceProvider.value, cat);
//         Get.toNamed(
//           Routes.PROFILE,
//         );
//       } else {
//         Get.showSnackbar(Ui.ErrorSnackBar(
//             message:
//                 "There are errors in some fields please correct them!".tr));
//       }
//     } catch (e) {
//       print(e);
//       Get.showSnackbar(Ui.ErrorSnackBar(message: "Something was wrong".tr));
//     }
//   }
// }

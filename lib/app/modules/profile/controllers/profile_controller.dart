import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/Network/ServiceProviderNetwork.dart';
import 'package:home_services_provider/app/models/Branch.dart';
import 'package:home_services_provider/app/models/Provider.dart';
import 'package:home_services_provider/app/models/User.dart';
import 'package:home_services_provider/app/modules/auth/controllers/auth_controller.dart';
import 'package:home_services_provider/app/routes/app_pages.dart';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../auth/controllers/auth_controller.dart';

import '../../../../common/ui.dart';
// import '../../../their_models/user_model.dart';
import '../../../services/auth_service.dart';

class ProfileController extends GetxController {
  // var user = new User().obs;
  Rx<User> user = User().obs;
  Rx<ServiceProvider> serviceProvider = ServiceProvider().obs;
  final hidePassword = true.obs;
  ServiceProviderNetwork providerNetwork = ServiceProviderNetwork();
  @override
  void onInit() {
    // user.value = Get.find<AuthService>().user.value;
    // if(serviceProvider.value.)
    if (serviceProvider.value.name != '') {
      serviceProvider.value = ServiceProvider(
          description: '',
          name: '',
          website: '',
          media: [],
          categories: [],
          id: '',
          user: user.value = Get.find<AuthController>().currentUser.value,
          profile_photo: '',
          branches: [
            Branch(
                address: '',
                branch_name: '',
                city: '',
                country: '',
                id: '',
                is_main: true,
                location: null,
                open_days: {},
                phone: 00000000,
                social_media: {},
                state: '',
                zip_code: 0)
          ]);
    }
    user.value = Get.find<AuthController>().currentUser.value;

    super.onInit();
  }

  Future<String> uploadFile() async {
    AuthController authController = Get.find<AuthController>();
    final filename = basename(authController.file.path);
    final destination = "/User/Provider/Profile/$filename";
    // FirebaseStorage storage = FirebaseStorage.instance;
    // Reference refimage = storage.ref().child("/stores_main/$filename");
    final ref = FirebaseStorage.instance.ref(destination);
    UploadTask uploadtask = ref.putFile(authController.file);
    // TaskSnapshot dowurl = await (await uploadtask.whenComplete(() {}));
    final snapshot = await uploadtask.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    //var url = dowurl.toString();
    print(urlDownload);
    return urlDownload;
  }

  Future<List<String>> uploadMedia() async {
    AuthController authController = Get.find<AuthController>();
    List<String> med = [];
    authController.filel.forEach((element) async {
      final filename = basename(element.path);
      final destination = "/User/Provider/Media/$filename";
      // FirebaseStorage storage = FirebaseStorage.instance;
      // Reference refimage = storage.ref().child("/stores_main/$filename");
      final ref = FirebaseStorage.instance.ref(destination);
      UploadTask uploadtask = ref.putFile(element);
      // TaskSnapshot dowurl = await (await uploadtask.whenComplete(() {}));
      final snapshot = await uploadtask.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();
      //var url = dowurl.toString();
      print(urlDownload);
      med.add(urlDownload);
    });
    return med;
  }

  edit() async {
    try {
      print('uploading');
      List<String> data = await uploadMedia();
      print('uploaded');
      print('updating');
      Future.delayed(
          Duration(
            seconds: 10,
          ), () {
        print(data);
        Get.find<AuthController>()
            .serviceProviderServices
            .updateProvider(data, serviceProvider.value.id);
      });
      print(data);
      print(serviceProvider.value.id);
      // Get.find<AuthController>()
      //     .serviceProviderServices
      //     .updateProvider(data, serviceProvider.value.id);
      print('updated');
    } catch (e) {
      print("problem");
    }
  }

  Future<void> saveProviderForm(
      GlobalKey<FormState> profileForm, tempProvider) async {
    print('uploading');
    // String url = await uploadFile();
    List<String> med = [];
    med = await uploadMedia();
    print('uploaded');

    // mapdata['profile_photo'] = url;
    // serviceProvider.value.profile_photo = url;
    try {
      if (profileForm.currentState.validate()) {
        serviceProvider.value = tempProvider;
        print(serviceProvider.value.branches.first.branch_name);
        // serviceProvider.value.profile_photo = url;
        serviceProvider.value.media = med;
        providerNetwork.addProvider(serviceProvider.value);
        Get.toNamed(
          Routes.ROOT,
        );
      } else {
        Get.showSnackbar(Ui.ErrorSnackBar(
            message:
                "There are errors in some fields please correct them!".tr));
      }
    } catch (e) {
      print(e);
      Get.showSnackbar(Ui.ErrorSnackBar(message: "Something was wrong".tr));
    }
  }

  void saveProfileForm(GlobalKey<FormState> profileForm) {
    if (profileForm.currentState.validate()) {
      profileForm.currentState.save();
      user.refresh();
      Get.showSnackbar(
          Ui.SuccessSnackBar(message: "Profile saved successfully".tr));
    } else {
      Get.showSnackbar(Ui.ErrorSnackBar(
          message: "There are errors in some fields please correct them!".tr));
    }
  }

  void resetProfileForm(GlobalKey<FormState> profileForm) {
    profileForm.currentState.reset();
  }
}
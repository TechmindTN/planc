import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:home_services_provider/app/Network/CategoryNetwork.dart';
import 'package:home_services_provider/app/Network/ServiceProviderNetwork.dart';
import 'package:home_services_provider/app/models/Branch.dart';
import 'package:home_services_provider/app/models/Media.dart';
import 'package:home_services_provider/app/models/Provider.dart';
import 'package:home_services_provider/app/models/User.dart';
import 'package:home_services_provider/app/modules/auth/controllers/auth_controller.dart';
import 'package:home_services_provider/app/modules/e_services/controllers/e_service_controller.dart';
import 'package:home_services_provider/app/routes/app_pages.dart';

import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import '../../auth/controllers/auth_controller.dart';

import '../../../../common/ui.dart';
// import '../../../their_models/user_model.dart';
import '../../../services/auth_service.dart';
import '../../e_services/controllers/e_services_controller.dart';

class ProfileController extends GetxController {
  // var user = new User().obs;
  Set<Marker> markers = Set();
  Rx<User> user = User().obs;
  List<DocumentReference> cat = [];
  CategoryNetwork categoryNetwork = CategoryNetwork();
  Rx<ServiceProvider> serviceProvider = ServiceProvider().obs;
  final hidePassword = true.obs;
  EServicesController eServicesController;
  ServiceProviderNetwork providerNetwork = ServiceProviderNetwork();
  LatLng position;

  @override
  void onInit() {
    Get.put(EServiceController());

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
          address: '',
          // branch_name: '',
          city: '',
          country: '',
          // id: '',
          // is_main: true,
          location: null,
          open_days: {},
          phone: 00000000,
          social_media: {},
          state: '',
          zip_code: 0);
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

  Future<List<Media>> uploadMedia() async {
    AuthController authController = Get.find<AuthController>();
    List<Media> med = [];
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
      med.add(Media(url: urlDownload, type: 'image'));
    });
    for (var e in authController.boolimg) {
      if (!e) {
        e = true;
      }
    }
    return med;
  }

  // edit(GlobalKey<FormState> profileForm) async {
  //   List<String> med = [];
  //   med = await uploadMedia();
  //   try {
  //     if (profileForm.currentState.validate()) {
  //       print('uploading');
  //       List<String> data = await uploadMedia();
  //       print('uploaded');
  //       print('updating');
  //       Future.delayed(
  //           Duration(
  //             seconds: 10,
  //           ), () {
  //         print(data);
  //         Get.find<AuthController>()
  //             .serviceProviderServices
  //             .updateProvider(data, serviceProvider.value.id);
  //       });
  //       serviceProvider.value.media = med;
  //       update();

  //       print(data);
  //       print(serviceProvider.value.id);
  //       // Get.find<AuthController>()
  //       //     .serviceProviderServices
  //       //     .updateProvider(data, serviceProvider.value.id);
  //       print('updated');
  //     } else {
  //       Get.showSnackbar(Ui.ErrorSnackBar(
  //           message:
  //               "There are errors in some fields please correct them!".tr));
  //     }
  //   } catch (e) {
  //     print("problem");
  //   }
  // }

  edit(BuildContext context) async {
    // List<String> med = [];
    // med = await uploadMedia();
    try {
      print('uploading');
      List<Media> med = await uploadMedia();
      print('uploaded pp');
      print('updating pp');
      Future.delayed(
          Duration(
            seconds: 10,
          ), () {
        print(serviceProvider.value.id);
        print("object");
        Get.find<AuthController>()
            .serviceProviderServices
            .updateProvider(med, serviceProvider.value.id, context);
      });
      update();

      // print(data);
      // print(serviceProvider.value.id);
      // Get.find<AuthController>()
      //     .serviceProviderServices
      //     .updateProvider(data, serviceProvider.value.id);
      print('updated edit pp');
    } catch (e) {
      print("problem editpp");
    }
  }

  prepareCategories() {
    int index = 0;
    Get.find<EServicesController>().categories.forEach((element) {
      if (Get.find<EServicesController>().chosencats[index]) {
        DocumentReference categ = categoryNetwork.getCategoryRef(element.id);
        cat.add(categ);
      }
      index++;
    });
  }

  Future<void> saveProviderForm(
      GlobalKey<FormState> profileForm, tempProvider) async {
    print('uploading');
    String url = await uploadFile();
    List<Media> med = [];
    med = await uploadMedia();
    print('uploaded');

    // mapdata['profile_photo'] = url;
    // serviceProvider.value.profile_photo = url;
    try {
      if (profileForm.currentState.validate()) {
        print("hello1");
        prepareCategories();
        print("hello2");
        serviceProvider.value = tempProvider;
        print("hello3");
        // print(serviceProvider.value);
        print("hello4");
        serviceProvider.value.profile_photo = url;
        print("hello5");
        serviceProvider.value.media = med;
        print("hello6");
        // serviceProvider.value.categories = cat;
        DocumentReference dr =
            await providerNetwork.addProvider(serviceProvider.value, cat);
        print("hello7");

        Future.delayed(Duration(seconds: 4), (() {
          print("docref id " + dr.id);
          serviceProvider.value.id = dr.id;
        }));

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

  // Future<void> updateProviderForm(
  //     GlobalKey<FormState> profileForm, tempProvider) async {
  //   print('updating branch');

  //   // mapdata['profile_photo'] = url;
  //   // serviceProvider.value.profile_photo = url;
  //   try {
  //     if (profileForm.currentState.validate()) {
  //       Future.delayed(
  //           Duration(
  //             seconds: 5,
  //           ), () {
  //         print(tempProvider);
  //         Get.find<AuthController>()
  //             .serviceProviderServices
  //             .updateProvider(tempProvider, serviceProvider.value.id);
  //       });
  //       print("object")
  //       update();

  //       Get.toNamed(
  //         Routes.ROOT,
  //       );
  //     } else {
  //       Get.showSnackbar(Ui.ErrorSnackBar(
  //           message:
  //               "There are errors in some fields please correct them!".tr));
  //     }
  //   } catch (e) {
  //     print(e);
  //     Get.showSnackbar(Ui.ErrorSnackBar(message: "Something was wrong".tr));
  //   }
  // }

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

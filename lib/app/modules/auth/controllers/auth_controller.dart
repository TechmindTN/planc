import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:home_services_provider/app/Network/MediaNetwork.dart';
import 'package:home_services_provider/app/Network/RoleNetwork.dart';
import 'package:home_services_provider/app/Network/ServiceProviderNetwork.dart';
import 'package:home_services_provider/app/Network/UserNetwork.dart';
import 'package:home_services_provider/app/models/Media.dart';
import 'package:home_services_provider/app/models/Provider.dart';
import 'package:home_services_provider/app/models/Role.dart';
import 'package:home_services_provider/app/models/User.dart';
import 'package:home_services_provider/app/modules/e_services/controllers/e_service_controller.dart';
import 'package:home_services_provider/app/modules/e_services/controllers/e_services_controller.dart';
import 'package:home_services_provider/app/modules/home/controllers/home_controller.dart';
import 'package:home_services_provider/app/modules/profile/controllers/profile_controller.dart';
import 'package:home_services_provider/app/their_models/role_enum.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/app_pages.dart';

class AuthController extends GetxController {
  bool loading=false;
  File file;
  File fileLL;
  SharedPreferences prefs;
  Image im = Image.network(
      'https://icon-library.com/images/no-photo-available-icon/no-photo-available-icon-20.jpg');
  List<File> filel = [];
  List<Image> iml = [];
  List<bool> boolimg = [];
  Rx<User> currentUser = User().obs;
  UserNetwork userServices = UserNetwork();
  RoleNetwork roleServices = RoleNetwork();
  MediaNetwork mediaServices = MediaNetwork();

  ServiceProviderNetwork serviceProviderServices = ServiceProviderNetwork();
  FirebaseStorage storage = FirebaseStorage.instance;

  RxString selected = RoleEnum.Entreprise.name.obs;
  final hidePassword = true.obs;
  List<Role> roles = List();
  List<User> users = List();
  List<String> emails = List();
  GetStorage box;

  Future<void> onInit() async {
    file = File('');
    // im = Image.file(file);
    // iml = [];
    // Get.put(AuthController());
    await getRoles();

    super.onInit();
  }

  updateRole(String value) {
    selected.value = value;
    update();
  }

  getProvider() async {
    try {
      Get.put(ProfileController());

      var profileController = Get.find<ProfileController>();

      profileController.serviceProvider.value =
          await serviceProviderServices.getProviderByUser(currentUser.value);
      print(profileController.serviceProvider.value.media.first.url);

      Future.delayed(Duration(seconds: 2), () {
        print("my category is " +
            profileController.serviceProvider.value.categories.length
                .toString());
      });
      print('getting provider');
      print(
          'provider is ' + profileController.serviceProvider.value.description);
      print('provider is ' + profileController.serviceProvider.value.city);
      if (profileController.serviceProvider.value.profile_photo != null &&
          profileController.serviceProvider.value.profile_photo != "") {
        im = Image.network(
            profileController.serviceProvider.value.profile_photo);

        // iml = profileController.serviceProvider.value.media;
      }
      if (profileController.serviceProvider.value.media != null &&
          profileController.serviceProvider.value.media.length > 0) {
        profileController.serviceProvider.value.media.forEach((element) {
          iml.add(Image.network(element.url));
        });
      }
    } catch (e) {
      print('this is error ' + e);
    }
  }

  getRoles() async {
    roles = await roleServices.getAllRoles();
    update();
    print(roles.length);
    roles.forEach((element) {
      print(element.name);
    });
  }

  RegisterUser(User user, password2, context) async {
    try {
      bool ok = await isNewEmail(user.email);
      print('registring');
      if (regFormValid(user.email, user.password, password2, context)) {
        Role role;
        roles.forEach((element) {
          if (element.name == user.role.name) {
            role = element;
          }
        });
        print('registring');
        DocumentReference roleref = roleServices.getRoleRef(role.id);
        print('registring');
        Map<String, dynamic> mapdata = user.tofire();
        print('registring');
        mapdata['role'] = roleref;
        print('registring');
        if (ok) {
          DocumentReference val = await userServices.addUser(mapdata);
          currentUser.value = user;
          currentUser.value.id = val.id;
          loading=false;
          update();
          //  print(userServices.id);
          // role.id=roleref.id;
          //     user.id=userServices.id;
          //      currentUser.value=user;
          //      print(userServices.id);
          //      currentUser.value.id=userServices.id;
          Get.offAllNamed(Routes.INTRO);
        } else {
          loading=false;
          update();
          SnackBar snackBar = SnackBar(
            backgroundColor: Colors.red,
            content: Text('Email is required'),
          );
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
      print('object');
      loading=false;
      update();
    } catch (e) {
      loading=false;
      update();
      // printError();
      SnackBar snackBar = SnackBar(
        content: Text('Something is wrong please try again'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print('error: ' + e);
    }
  }



changeImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile pickedimage =
        await _picker.pickImage(source: ImageSource.gallery);
    file = File(pickedimage.path);
    CroppedFile croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    File f=File(croppedFile.path);
    file=f;
    // file.path=croppedFile.path;
    im = Image.file(f);
    update();
    print("this");
    print(im);

    //       storeimage=Container(
    //         height: 150,
    //         child: Image(
    //   image: FileImage(im,

    //   ),
    // ),
    //       );
    //print(storeimage);
  }


  // changeImage() async {
  //   final ImagePicker _picker = ImagePicker();

  //   final XFile pickedimage =
  //       await _picker.pickImage(source: ImageSource.gallery);
  //   file = File(pickedimage.path);
  //   im = Image.file(file);

  //   print("this");
  //   print(im);

  //   update();
  //   //       storeimage=Container(
  //   //         height: 150,
  //   //         child: Image(
  //   //   image: FileImage(im,

  //   //   ),
  //   // ),
  //   //       );
  //   //print(storeimage);
  // }


  changeCameraImage() async {
    final ImagePicker _picker = ImagePicker();

    final XFile pickedimage =
        await _picker.pickImage(source: ImageSource.camera);
    file = File(pickedimage.path);
    CroppedFile croppedFile = await ImageCropper().cropImage(
      sourcePath: file.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.deepOrange,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    );
    File f=File(croppedFile.path);
    file=f;
    // file.path=croppedFile.path;
    im = Image.file(f);
    update();
    print("this");
    print(im);

    //       storeimage=Container(
    //         height: 150,
    //         child: Image(
    //   image: FileImage(im,

    //   ),
    // ),
    //       );
    //print(storeimage);
  }


  addImage() async {
    final ImagePicker _picker = ImagePicker();

    final List<XFile> pickedimages = await _picker.pickMultiImage();
    pickedimages.forEach((element) {
      filel.add(File(element.path));
      // fileLL = File(element.path);
      iml.add(Image.file(filel.last));
      boolimg.add(false);
    });

    print("this");
    print(iml);

    update();
  }

  deleteImage(Media m) async {
    mediaServices.deleteMedia(
        m.id, Get.find<ProfileController>().serviceProvider.value.id);

    update();
  }

  login(String email, String password, context) async {
    try {
      print('a');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      if (formIsValid(email, password, context)) {
        print('b');
        currentUser.value =
            await userServices.getUserByEmailPassword(email, password);
        currentUser.value.printUser();

        update();
        loading=false;
      }
    } catch (e) {
      print('User doesn\'t exist');
      loading=false;
      SnackBar snackBar = SnackBar(
        content: Text('Email or password is wrong'),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    try {
      await getProvider();
      await Get.find<HomeController>().getIntervention();
      prefs.setString('email', email);
      prefs.setString('password', password);
    } catch (e) {
      print(e);
    }
  }

  getAllUsers() async {
    users = await userServices.getUsersList();
    users.forEach((element) {
      emails.add(element.email);
    });
  }

  isNewEmail(email) async {
    // List<User> users=await userServices.getUsersList();
    print(users.length);
    // users.forEach((element) {if(element.email==email){
    //   return false;
    // }});
// for(int i=0;i<users.length;i++){
//   if(users[i].email==email){
//     return false;
//   }
// }

//   return true;
    if (emails.contains(email)) {
      return false;
    } else {
      return true;
    }
  }

  formIsValid(String email, String password, context) {
    SnackBar snackBar;
    if (email == null || email.isEmpty) {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Email is required'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (password == null || password.isEmpty) {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Password is required'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (!email.isEmail) {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please provide a valid email'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }

  regFormValid(String email, String password, String password2, context) {
    SnackBar snackBar;
    if (email == null || email.isEmpty) {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Email is required'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    else{
      if(!email.isEmail){
        snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please provide a valid email'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
      }
    }
    if (password == null || password.isEmpty) {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Password is required'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    if (password.length < 8) {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Password length must be more than 8 characters'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    if (!password.contains(RegExp(r'[A-Z]')) &&
        !password.contains(RegExp(r'[a-z]'))) {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Password must contain at least 1 character'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }
    
    if (password != password2) {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Password confirm doesn\'t match the password'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    if (!email.isEmail) {
      snackBar = SnackBar(
        backgroundColor: Colors.red,
        content: Text('Please provide a valid email'),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      return false;
    }

    return true;
  }
}

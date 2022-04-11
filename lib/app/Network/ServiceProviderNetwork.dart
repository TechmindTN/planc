import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:home_services_provider/app/Network/BranchNetwork.dart';
import 'package:home_services_provider/app/Network/CategoryNetwork.dart';
import 'package:home_services_provider/app/Network/MediaNetwork.dart';
import 'package:home_services_provider/app/Network/UserNetwork.dart';
import 'package:home_services_provider/app/models/Category.dart';
import 'package:home_services_provider/app/models/Provider.dart';
import 'package:home_services_provider/app/models/User.dart';

class ServiceProviderNetwork {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference providersRef =
      FirebaseFirestore.instance.collection('Provider');
  UserNetwork userServices = UserNetwork();
  MediaNetwork mediaServices = MediaNetwork();

  CategoryNetwork categoryServices = CategoryNetwork();
  BranchNetwork branchServices = BranchNetwork();
  // UserNetwork userServices = UserNetwork();

  Future<List<ServiceProvider>> getProvidersList() async {
    int index = 0;
    List<ServiceProvider> providers = [];

// if(providers.isNotEmpty){
//   providers.clear();
// }

    QuerySnapshot snapshot = await providersRef.get();
    var list = snapshot.docs.map((e) => e.data()).toList();
    snapshot.docs.forEach((element) async {
      ServiceProvider serviceProvider = ServiceProvider.fromFire(element);
      providers.add(serviceProvider);
      providers[index].id = element.id;
      // serviceProvider.id = element.id;

      //get Branches
      // serviceProvider.branches =
      //     await branchServices.getBranchListByProvider(providers[index].id);

      // get category
      List<dynamic> drList = element['categories'];
      List<Category> categories = [];
      serviceProvider.categories = categories;

      drList.forEach((value) async {
        Category category = Category(name: '', parent: null, id: value.id);
        category = await categoryServices.getCategoryById(category.id ?? '');
        serviceProvider.categories.add(category);
        print(serviceProvider.categories.first.name);
      });

      //get user
      DocumentReference dr = element['user'];
      User user = User(
          id: dr.id,
          creation_date: Timestamp.now(),
          email: '',
          last_login: Timestamp.now(),
          password: '',
          username: '');
      user = await userServices.getUserById(user.id ?? '');
      serviceProvider.user = user;
      // serviceProvider.user = user;

      serviceProvider.categories = categories;

      index++;
    });

    return providers;
  }

  addProvider(ServiceProvider serviceProvider, List<DocumentReference> cat) {
    Map<String, dynamic> mapdata = serviceProvider.tofire();
    // mapdata.addAll(serviceProvider.branches.first.tofire());
    print('our user is ' + UserNetwork.dr.id);
    mapdata['user'] = UserNetwork.dr;
    mapdata['categories'] = cat;
    providersRef.add(mapdata).then((value) {
      print('provider added');
      // branchServices.addBranch(serviceProvider.branches.first, value.id);
    });
  }

  updateProvider(List<dynamic> data, id, BuildContext context) {
    List<Map<String, dynamic>> mediaMapList = [];
    data.forEach((element) {
      mediaMapList.add({"url": element, "type": "image"});
    });

    // serviceProvider.media.forEach((element) {
    //       Map<String, dynamic> mediamap =element.tofire();
    //       mediaMapList.add(mediamap);
    //  });
    //       mediaServices.addMedia(mediaMapList, value.id);
    //   print('media list length '+mediaMapList.length.toString());

    Map<String, dynamic> mapdata = {'media': data};
    providersRef.doc(id).update(mapdata).then((value) {
      print('provider updated');
      SnackBar snack = SnackBar(
        content: Text("Profile Successfully updated".tr),
        backgroundColor: Colors.green,
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
    }).catchError((error) {
      SnackBar snack = SnackBar(
        content: Text("There is a problem".tr),
        backgroundColor: Colors.red,
      );
      ScaffoldMessenger.of(context).showSnackBar(snack);
      print('Can not update provider');
    });
    mediaServices.addMedia(mediaMapList, id);
  }

  Future<ServiceProvider> getProviderByUser(User user) async {
    try {
      print('hello from network');

      ServiceProvider serviceProvider;
      DocumentReference userref = await userServices.getUserRef(user.id);
      QuerySnapshot snapshot =
          await providersRef.where('user', isEqualTo: userref).get();
      // snapshot..docs.first;
      // DocumentSnapshot snapshot = await providersRef.doc(id).get();
      print('hello from network 2');

      serviceProvider = ServiceProvider.fromFire(snapshot.docs.first.data());
      print('hello from network 3');

      serviceProvider.id = snapshot.docs.first.id;
      print('hello from network 4');

      //get media
      serviceProvider.media =
          await mediaServices.getMediaListByProvider(serviceProvider.id);
      print('hello from network 5');

      //get Branches
      // // serviceProvider.branches =
      // //     await branchServices.getBranchListByProvider(snapshot.docs.first.id);
      // print('branches done');
      // get category

      // getMyCategories();

      List<Category> categories = [];
      List<dynamic> drList = snapshot.docs.first['categories'];
      drList.forEach((element) async {
        Category category = await categoryServices.getCategoryById(element.id);
        categories.add(category);
      });
      serviceProvider.categories = categories;

//       // // print('branches done 1');
//       List<Category> categories = [];
// //       serviceProvider.categories = categories;
// // // print(drList.length);
//       drList.forEach((value) async {
// //       //   List<Category> subCategories = [];

// //         // Category category = Category(name: '', parent: null, id: value.id);
// // Category category=Category.fromFire(value);
// // print("category name "+category.name);
// // // print(object)
// // serviceProvider.categories.add(category);
// //       });
//         categories =
//             await categoryServices.getCategoriesByProvider(value.id ?? '');
//       //   serviceProvider.categories.addAll(subCategories);
//         print("cat length "+categories.length.toString());
//         Future.delayed(Duration(seconds: 10),(){
//                   print("cat length "+categories.length.toString());

//         });
//       });
//       serviceProvider.categories=categories;
//               print("cat length "+categories.length.toString());

      //  print(serviceProvider.categories!.length);
      // serviceProvider.categories.forEach((element) {
      //   print(element.name);
      // });
      // print("my name is "+serviceProvider.categories.first.name);
      return serviceProvider;
    } catch (e) {
      print('error in network ' + e);
    }
  }

  Future<ServiceProvider> getProviderById(String id) async {
    ServiceProvider serviceProvider;
    DocumentSnapshot snapshot = await providersRef.doc(id).get();
    serviceProvider = ServiceProvider.fromFire(snapshot.data());
    serviceProvider.id = snapshot.id;

    // get category
    List<dynamic> drList = snapshot['categories'];
    List<Category> categories = [];
    serviceProvider.categories = categories;
// print(drList.length);
    drList.forEach((value) async {
      List<Category> subCategories = [];
      Category category = Category(name: '', parent: null, id: value.id);
      subCategories =
          await categoryServices.getCategoriesByProvider(category.id ?? '');

      serviceProvider.categories.addAll(subCategories);
      print(serviceProvider.categories.length);
    });
    //  print(serviceProvider.categories!.length);
    serviceProvider.categories.forEach((element) {
      print(element.name);
    });

    //get Branches
    // serviceProvider.branches =
    //     await branchServices.getBranchListByProvider(serviceProvider.id);

    //get user
    DocumentReference dr = snapshot['user'];
    User user = User(
        id: dr.id,
        creation_date: Timestamp.now(),
        email: '',
        last_login: Timestamp.now(),
        password: '',
        username: '');

    user = await userServices.getUserById(user.id ?? '');
    serviceProvider.user = user;
    // serviceProvider.user = user;

    serviceProvider.categories = categories;

    return serviceProvider;
  }
}

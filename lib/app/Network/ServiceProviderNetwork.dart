import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_services_provider/app/Network/BranchNetwork.dart';
import 'package:home_services_provider/app/Network/CategoryNetwork.dart';
import 'package:home_services_provider/app/Network/UserNetwork.dart';
import 'package:home_services_provider/app/models/Category.dart';
import 'package:home_services_provider/app/models/Provider.dart';
import 'package:home_services_provider/app/models/User.dart';

class ServiceProviderNetwork {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference providersRef =
      FirebaseFirestore.instance.collection('Provider');
  UserNetwork userServices = UserNetwork();
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
      serviceProvider.branches =
          await branchServices.getBranchListByProvider(providers[index].id);

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
    mapdata.addAll(serviceProvider.branches.first.tofire());
    print('our user is ' + UserNetwork.dr.id);
    mapdata['user'] = UserNetwork.dr;
    mapdata['categories'] = cat;
    providersRef.add(mapdata).then((value) {
      print('provider added');
      branchServices.addBranch(serviceProvider.branches.first, value.id);
    });
  }

  updateProvider(data, id) {
    Map<String, dynamic> mapdata = {'media': data};
    providersRef
        .doc(id)
        .update(mapdata)
        .then((value) => print('provider updated'))
        .catchError((error) {
      print('Can not update provider');
    });
  }

  Future<ServiceProvider> getProviderByUser(User user) async {
    try {
      print('hello from network');

      ServiceProvider serviceProvider;
      DocumentReference userref = await userServices.getUserRef(user.id);
      QuerySnapshot snapshot =
          await providersRef.where('user', isEqualTo: userref).get();
      print('hello from network 2');
      // snapshot..docs.first;
      // DocumentSnapshot snapshot = await providersRef.doc(id).get();
      serviceProvider = ServiceProvider.fromFire(snapshot.docs.first.data());
      serviceProvider.id = snapshot.docs.first.id;

      //get Branches
      serviceProvider.branches =
          await branchServices.getBranchListByProvider(snapshot.docs.first.id);
      print('branches done');
      // get category

      // List<dynamic> drList = snapshot.docs.first['categories'];
      // // print('branches done 1');
      // List<Category> categories = [];
      // serviceProvider.categories = categories;
// print(drList.length);
      // drList.forEach((value) async {
      //   List<Category> subCategories = [];

      //   Category category = Category(name: '', parent: null, id: value.id);

      //   subCategories =
      //       await categoryServices.getCategoriesByProvider(category.id ?? '');
      //   serviceProvider.categories.addAll(subCategories);
      //   print(serviceProvider.categories.length);
      // });
      //  print(serviceProvider.categories!.length);
      // serviceProvider.categories.forEach((element) {
      //   print(element.name);
      // });
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
    serviceProvider.branches =
        await branchServices.getBranchListByProvider(serviceProvider.id);

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

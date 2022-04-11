import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_services_provider/app/models/Branch.dart';
import 'package:home_services_provider/app/models/Category.dart';
import 'package:home_services_provider/app/models/Media.dart';
import 'package:home_services_provider/app/models/User.dart';

class ServiceProvider {
  String id;
  String name;
  String description;
  String website;
  List<Media> media;
  String profile_photo;
  User user;
  // String branch_name;
  Map<String, dynamic> open_days;
  String address;
  String city;
  String country;
  String state;
  int zip_code;
  GeoPoint location;
  Map<String, dynamic> social_media;
  int phone;
  // bool is_main;
  List<Category> categories;
  double rate;


  ServiceProvider({
    this.id,
    this.name,
    this.description,
    this.rate,
    this.website,
    this.media,
    this.profile_photo,
    this.user,
    this.categories,
    this.open_days,
    this.address,
    this.city,
    this.country,
    this.state,
    this.zip_code,
    this.location,
    this.social_media,
    this.phone,
  });

  Map<String, dynamic> tofire() => {
        'name': name,
        'rate': rate ?? 0,
        'description': description,
        'website': website,
        // 'media': media,
        'profile_photo': profile_photo,
        'categories': categories,
        //  'branch_name': branch_name,
        'open_days': open_days,
        'address': address,
        'city': city,
        'country': country,
        'state': state,
        'zip_code': zip_code,
        'location': location,
        'social_media': social_media,
        'phone': phone
      };

  ServiceProvider.fromFire(fire)
      : name = fire['name'],
        // rate = fire['rate'],
        description = fire['description'],
        website = fire['website'],
        address = fire['address'],
        city = fire['city'],
        country = fire['country'],
        state = fire['satete'],
        zip_code = fire['zip_code'],
        location = fire['location'],
        social_media = fire['social_media'],
        phone = fire['phone'],
        // // media = fire['media'],
        // id = null,
        profile_photo = fire['profile_photo'];

  printProvider() {
    print(this.id);
    print(this.name);
    print(this.description);
    print(this.website);
    print(this.rate);

    this.media.forEach((element) {
      print(element);
    });
    print(this.profile_photo);
    Future.delayed(Duration(seconds: 2), () {
      this.user.printUser();
      this.categories.forEach((element) {
        element.printCategory();
      });
      // this.branches.forEach((element) {
      //   element.printBranch();
      // });
    });
  }
}

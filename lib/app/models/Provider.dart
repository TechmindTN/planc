import 'package:home_services_provider/app/models/Branch.dart';
import 'package:home_services_provider/app/models/Category.dart';
import 'package:home_services_provider/app/models/User.dart';

class ServiceProvider {
  String id;
  String name;
  String description;
  String website;
  List<dynamic> media;
  String profile_photo;
  User user;
  List<Category> categories;
  List<Branch> branches;

  ServiceProvider(
      {this.id,
      this.name,
      this.description,
      this.website,
      this.media,
      this.profile_photo,
      this.user,
      this.categories,
      this.branches});

  Map<String, dynamic> tofire() => {
        'name': name,
        'description': description,
        'website': website,
        'media': media,
        'profile_photo': profile_photo,
        'categories': categories,
      };

  ServiceProvider.fromFire(fire)
      : name = fire['name'],
        description = fire['description'],
        website = fire['website'],
        media = fire['media'],
        id = null,
        profile_photo = fire['profile_photo'];

  printProvider() {
    print(this.id);
    print(this.name);
    print(this.description);
    print(this.website);
    this.media.forEach((element) {
      print(element);
    });
    print(this.profile_photo);
    Future.delayed(Duration(seconds: 2), () {
      this.user.printUser();
      this.categories.forEach((element) {
        element.printCategory();
      });
      this.branches.forEach((element) {
        element.printBranch();
      });
    });
  }
}

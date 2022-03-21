import 'package:flutter/material.dart';

import '../../common/ui.dart';
import 'e_service_model.dart';
import 'parents/model.dart';

class Category extends Model {
  String name;
  String image;
  Color color;
  List<EService> services;
  List<Category> subCategories;

  Category({this.name, this.image, this.color, this.services});

  Category.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    image = json['image'];
    color = Ui.parseColor(json['color'].toString()).withOpacity(1);
    if (json['services'] != null) {
      services = <EService>[];
      json['services'].forEach((v) {
        services.add(EService.fromJson(v));
      });
    }
    if (json['sub_categories'] != null) {
      subCategories = <Category>[];
      json['sub_categories'].forEach((v) {
        subCategories.add(Category.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['name'] = this.name;
    data['image'] = this.image;
    data['color'] = this.color.toString();
    if (this.services != null) {
      data['services'] = this.services.map((v) => v.toJson()).toList();
    }
    if (this.subCategories != null) {
      data['sub_categories'] = this.subCategories.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

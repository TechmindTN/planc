import 'package:flutter/material.dart';

import 'parents/model.dart';

class Statistic extends Model {
  String id;
  String value;
  String description;
  Color textColor;
  Color backgroundColor;

  Statistic({this.id, this.value, this.description, this.textColor, this.backgroundColor});

  Statistic.fromJson(Map<String, dynamic> jsonMap) {
    try {
      id = jsonMap['id'];
      value = jsonMap['value'].toString() ?? '0';
      description = jsonMap['description'].toString() ?? '';
    } catch (e) {
      id = '';
      value = '0';
      description = '';
      print(e);
    }
  }

  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["value"] = value;
    map["description"] = description;
    return map;
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserModel {
  String name;
  var score = '0'.obs;
  TextEditingController scoreController;

  UserModel({this.name, this.score, this.scoreController});

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      score: json['score'] as RxString,
      scoreController: json['scoreController'] as TextEditingController,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "score": score,
        "scoreController": scoreController,
      };
}

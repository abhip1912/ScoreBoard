import 'package:get/get.dart';

class UserModel {
  String name;
  var score = '0'.obs;

  UserModel({this.name, this.score});

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'] as String,
      score: json['score'] as RxString,
    );
  }

  Map<String, dynamic> toJson() => {
        "name": name,
        "score": score,
      };
}

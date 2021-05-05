import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorebord/page/model/model.dart';

class HomeController extends GetxController {
  TextEditingController nameConroller, scoreController;
  var name = 'Add vlaue'.obs;
  var score = '0'.obs;
  UserModel user;
  var userList = <UserModel>[].obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameConroller = TextEditingController();
    scoreController = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nameConroller.dispose();
    scoreController.dispose();
  }

  UserModel addName() {
    print('before $userList');
    if (nameConroller.text.isNotEmpty) {
      return user = UserModel(
        name: nameConroller.text,
        score: int.parse(score.value),
      );

      print('after $userList');
    }
  }

  void scorePluse() {
    if (scoreController.text.isNotEmpty) {
      int temp1 = int.parse(score.value);
      int temp2 = int.parse(scoreController.text);
      print(score.value);
      print(scoreController.text);
      score.value = (temp1 + temp2).toString();
    }
    // print('20' + '$score');
  }

  void scoreMinus() {
    if (scoreController.text.isNotEmpty) {
      int temp1 = int.parse(score.value);
      int temp2 = int.parse(scoreController.text);
      print(score.value);
      print(scoreController.text);
      score.value = (temp1 - temp2).toString();
    }

    print('$score');
  }
}

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
        score: score,
      );
    } else {
      return user;
    }
  }

  scorePluse(int index) {
    if (scoreController.text.isNotEmpty) {
      int temp1 = int.parse(userList[index].score.toString());
      int temp2 = int.parse(scoreController.text);
      print('after');
      print(userList[index].score);
      temp1 = (temp1 + temp2);
      userList[index].score.value = temp1.toString();
    }
  }

  void scoreMinus(int index) {
    if (scoreController.text.isNotEmpty) {
      int temp1 = int.parse(userList[index].score.toString());
      int temp2 = int.parse(scoreController.text);
      print('after');
      print(userList[index].score);
      temp1 = (temp1 - temp2);
      userList[index].score.value = temp1.toString();
    }
  }
}

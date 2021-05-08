import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorebord/page/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  TextEditingController nameController;
  var name = 'Add vlaue'.obs;
  UserModel user;
  var userList = <UserModel>[].obs;
  final _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController = TextEditingController();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    nameController.dispose();
  }

  UserModel addName() {
    print('before $userList');
    if (nameController.text.isNotEmpty) {
      user = UserModel(
        name: nameController.text,
        score: '0',
        scoreController: TextEditingController(),
      );
      addData();
      return user;
    } else {
      return null;
    }
  }

  void addData() {
    _firestore.collection('data').add(user.toJson());
  }

  void getData() {
    _firestore.collection('data').snapshots();
  }

  scorePluse(int index) {
    if (userList[index].scoreController.text.isNotEmpty) {
      int temp1 = int.parse(userList[index].score);
      int temp2 = int.parse(userList[index].scoreController.text);
      temp1 = (temp1 + temp2);
      user = UserModel(
          name: userList[index].name,
          score: temp1.toString(),
          scoreController: userList[index].scoreController);
      userList[index] = user;
    }
  }

  void scoreMinus(int index) {
    if (userList[index].scoreController.text.isNotEmpty) {
      int temp1 = int.parse(userList[index].score);
      int temp2 = int.parse(userList[index].scoreController.text);
      temp1 = (temp1 - temp2);
      user = UserModel(
          name: userList[index].name,
          score: temp1.toString(),
          scoreController: userList[index].scoreController);
      userList[index] = user;
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorebord/page/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeController extends GetxController {
  TextEditingController nameController;
  var name = 'Add vlaue'.obs;
  UserModel user;
  var userList = <UserModel>[].obs;
  var list = <UserModel>[].obs;
  final firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    nameController = TextEditingController();
    // demo();
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
      // userList.add(user);
      addData();
      // return user;
    } else {
      return null;
    }
  }

  void addData() {
    firestore.collection('data').add(user.toJson());
  }

  // Stream getData() {
  //   final data = firestore.collection('data').snapshots();
  //   return data;
  // }

  // Future<void> demo() async {
  //   final data = await firestore.collection('data').get().then((value) {
  //     value.docs.forEach((element) {
  //       final user = UserModel(
  //         name: element.data()['name'],
  //         score: element.data()['score'],
  //       );
  //       userList.clear();
  //       userList.add(user);
  //     });
  //   });
  // }

  scorePluse(int index) {
    print(userList[index].scoreController.text);
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

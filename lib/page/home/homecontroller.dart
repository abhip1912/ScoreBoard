import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorebord/page/model/model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeController extends GetxController {
  TextEditingController nameController;
  UserModel user;
  var userList = <UserModel>[].obs;
  final firestore = FirebaseFirestore.instance;
  bool isLightTheam = true;

  @override
  void onInit() {
    super.onInit();
    print('init is called.');
    nameController = TextEditingController();
  }

  @override
  void onClose() {
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

      return user;
    } else {
      return null;
    }
  }

  void addData(dynamic user) {
    firestore.collection('data').doc('${user.name}').set(user.toJson());
  }

  Stream getData() {
    final data = firestore.collection('data').snapshots();
    return data;
  }

  List<UserModel> logic(AsyncSnapshot snapshot) {
    final List<UserModel> list = [];
    snapshot.data.docs.forEach((element) {
      final user = UserModel(
        name: element.data()['name'],
        score: element.data()['score'],
        scoreController: TextEditingController(),
      );
      list.add(user);
    });
    return list;
  }

  void remove(int index) {
    firestore.collection('data').doc('${userList[index].name}').delete();
  }

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

      firestore
          .collection('data')
          .doc('${userList[index].name}')
          .update(user.toJson());
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

      firestore
          .collection('data')
          .doc('${userList[index].name}')
          .update(user.toJson());
    }
  }
}

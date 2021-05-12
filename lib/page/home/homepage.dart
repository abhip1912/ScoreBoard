import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scorebord/page/home/homecontroller.dart';
import 'package:scorebord/page/model/model.dart';
import 'package:scorebord/widget/roundIconButton.dart';
import 'package:scorebord/widget/bottomsheet.dart';
import 'package:scorebord/widget/communmodual.dart';
import 'package:get/get.dart';
import 'package:scorebord/widget/reuseblecard.dart';

class Home extends StatelessWidget {
  HomeController homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: RonudIconButton(
            icon: Icons.add,
            onPressed: () {
              Get.bottomSheet(
                BottomShit(),
                isDismissible: false,
                enableDrag: true,
              ).then(
                (value) {
                  if (value != null) {
                    homeController.userList.add(value);
                  }
                },
              );
            }),
        title: Text(
          'ScoreBorad',
        ),
        centerTitle: true,
        actions: [buildIconButton()],
      ),
      body:
          // StreamBuilder(
          //   stream: homeController.getData(),
          //   builder: (context, snapshot) {
          //     if (!snapshot.hasData) {
          //       return Center(
          //         child: CircularProgressIndicator(
          //           backgroundColor: Colors.lightBlueAccent,
          //         ),
          //       );
          //     }
          //     final members = snapshot.data.docs;
          //     for (var member in members) {
          //       final userName = member.data()['name'];
          //       final userScore = member.data()['score'];
          //       final user = UserModel(
          //           name: userName,
          //           score: userScore,
          //           scoreController: TextEditingController());
          //       homeController.userList.add(user);
          //     }
          //     return Obx(() {
          //       return ListView.builder(
          //           itemCount: homeController.userList.length,
          //           itemBuilder: (context, index) {
          //             return                 });
          //     });
          //     //
          //   },
          // ),
          FutureBuilder(
        future: FirebaseFirestore.instance.collection('data').get(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            snapshot.data.docs.forEach((element) {
              final user = UserModel(
                name: element.data()['name'],
                score: element.data()['score'],
              );

              homeController.list.add(user);
            });

            homeController.userList = homeController.list;
            print(homeController.userList);
            return Obx(() {
              return ListView.builder(
                  itemCount: homeController.userList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ReusableCard(
                          colour: Colors.blue,
                          cardChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name : ${homeController.userList[index].name}',
                                style: TextStyle(fontSize: 25),
                              ),
                              SizedBox(
                                height: 20,
                                width: 10000,
                                child: Divider(
                                  height: 10,
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Obx(() {
                                        return Container(
                                          width: 120,
                                          child: Text(
                                            'Score : ${homeController.userList[index].score} ',
                                            style: TextStyle(fontSize: 22),
                                          ),
                                        );
                                      })
                                    ],
                                  ),
                                  SizedBox(
                                    width: 70,
                                  ),
                                  Row(
                                    children: [
                                      RonudIconButton(
                                          color: Colors.white24,
                                          iconColor: Colors.white,
                                          icon: Icons.add,
                                          onPressed: () {
                                            homeController.scorePluse(index);
                                            homeController
                                                .userList[index].scoreController
                                                .clear();
                                          }),
                                      Card(
                                        elevation: 4,
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              left: 5,
                                              right: 5,
                                              top: 5,
                                              bottom: 3),
                                          height: 35,
                                          width: 55,
                                          child: TextFormField(
                                            style: scoreTextfieldStyle,
                                            controller: homeController
                                                .userList[index]
                                                .scoreController,
                                            keyboardType: TextInputType.number,
                                          ),
                                        ),
                                      ),
                                      RonudIconButton(
                                          color: Colors.white24,
                                          iconColor: Colors.white,
                                          icon: Icons.remove,
                                          onPressed: () {
                                            homeController.scoreMinus(index);
                                            homeController
                                                .userList[index].scoreController
                                                .clear();
                                          }),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    );
                  });
            });
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}

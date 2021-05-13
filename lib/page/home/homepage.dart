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
                    homeController.addData(value);
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
      body: StreamBuilder(
        stream: homeController.getData(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            var list = homeController.logic(snapshot);

            homeController.userList.value = list;
            print(homeController.userList);
            return Obx(() {
              return ListView.builder(
                  itemCount: homeController.userList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ReusableCard(
                          colour: Colors.blue,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Name : ${homeController.userList[index].name}',
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: Colors.black54,
                                      ),
                                      onPressed: () {
                                        homeController.remove(index);
                                        print('after removing list');
                                        print(homeController.userList);
                                      })
                                ],
                              ),
                              SizedBox(
                                height: 0,
                                width: 10000,
                                child: Divider(
                                  height: 10,
                                  thickness: 3,
                                  color: Colors.white,
                                ),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    children: [
                                      Obx(() {
                                        return Text(
                                          'Score : ${homeController.userList[index].score} ',
                                          style: TextStyle(fontSize: 22),
                                        );
                                      })
                                    ],
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
                                            maxLength: 3,
                                            decoration: InputDecoration(
                                                counterText: ''),
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

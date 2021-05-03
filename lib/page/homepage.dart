import 'package:flutter/material.dart';
import 'package:scorebord/widget/bottomsheet.dart';
import 'package:scorebord/widget/communmodual.dart';
import 'package:scorebord/widget/reuseblecard.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: Scaffold(
        appBar: AppBar(
          actions: [buildIconButton()],
        ),
        body:
            // ReusableCard(colour: Colors.black38),

            Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            Get.bottomSheet(
              BottomShit(), // isDismissible: false,
              enableDrag: false,
            );
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      ),
    );
  }
}

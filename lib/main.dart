import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:scorebord/page/home/homebinding.dart';
import 'package:scorebord/page/home/homepage.dart';
import 'package:scorebord/widget/constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Constants.prefs = await SharedPreferences.getInstance();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: Constants.prefs.getBool("isLight") == true
          ? ThemeData.light()
          : ThemeData.dark(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      initialRoute: 'Home',
      getPages: [
        GetPage(name: 'Home', page: () => Home(), binding: HomeBinding())
      ],
    );
  }
}

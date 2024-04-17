import 'package:appchat/screen/Home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // REMPLACER materials par getmaterial pour utiliser le routage 
      navigatorKey:Get.key,
      //pour enlever le badges de bug
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      title: "ODC App",
    );
  }
}

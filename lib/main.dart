// import 'package:appchat/screen/Home.dart';
import 'package:appchat/dao/user_dao.dart';
import 'package:appchat/entity/user_entity.dart';
import 'package:appchat/screen/Home.dart';
import 'package:appchat/screen/database.dart';
import 'package:appchat/screen/login.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  await database.utilisateurDao
      .insertUtilisateur(new Utilisateur(nom: 'koulibaly', prenom: "mory"));

  // List<Utilisateur> users = await database.utilisateurDao.findAllUser();

  // for (var user in users) {
  //   print(user.nom);
  // }
  print(await database.utilisateurDao.findAllUser());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      // REMPLACER materials par getmaterial pour utiliser le routage
      navigatorKey: Get.key,
      //pour enlever le badges de bug
      debugShowCheckedModeBanner: false,
      home: const LoginPage(),
      title: "ODC App",
    );
  }
}
// getwidget 4.0.0 => composant(package comme boostrap pour flutter)
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  List users = [
    {"nom": 'koulibaly', 'image': "assets/images/avatar.jpg", 'status': true},
    {"nom": 'Diaby', 'image': "assets/images/avatar2.jpg", 'status': true},
    {"nom": 'youla', 'image': "assets/images/avatar3.jpg", 'status': false},
    {"nom": 'diallo', 'image': "assets/images/avatar.jpg", 'status': true},
    {"nom": 'diallo', 'image': "assets/images/avatar.jpg", 'status': true}
  ];
  TextEditingController textController =
      TextEditingController(); // Ajout du contrôleur de texte

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexColor("#12141D"),
      appBar: AppBar(
        backgroundColor: Colors.white12,
        elevation: 0,
        toolbarHeight: 69,
        actions: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                color: HexColor("#A855F7"),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              height: 2,
              width: 55,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
        centerTitle: true,
        title: Text("Genius class"),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: AssetImage("assets/images/avatar.jpg"),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
            height: 150,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: List.generate(users.length, (index) {
                return createavatar(user: users[index]);
              }),
            ),
          )
        ],
      )),
    );
  }
}

Widget createavatar({required Map user}) {
  return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Stack(children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: AssetImage(user['image']),
            ),
            user["status"]
                ? Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 22,
                      width: 22,
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ))
                : const SizedBox(),
            user["status"]
                ? Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                    ))
                : const SizedBox()
          ]),
        ),
        Text(user["nom"], style: TextStyle(color: Colors.white, fontSize: 18))
      ]));
}

class HexColor extends Color {
  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll("#", "");
    if (hexColor.length == 6) {
      hexColor = "FF" + hexColor;
    }
    return int.parse(hexColor, radix: 16);
  }

  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));
}


// Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: TextField(
//           controller: textController, // Utilisation du contrôleur de texte
//           decoration: InputDecoration(
//             hintText: 'Search',
//             fillColor: Colors.white,
//             hintStyle: TextStyle(color: HexColor("#A855F7")),
//             border: OutlineInputBorder(),
//           ),
//           onChanged: (text) {
//             // Fonction appelée à chaque changement dans le champ de saisie
//             print('Nouveau texte : $text');
//           },
//         ),
//       ),
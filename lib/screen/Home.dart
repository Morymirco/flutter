import 'package:appchat/screen/message.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:appchat/models/user.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

//on install le package avec flutter pub add get
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  // List users = [
  //   {"nom": 'koulibaly', 'image': "assets/images/avatar.jpg", 'status': true},
  //   {"nom": 'Diaby', 'image': "assets/images/avatar2.jpg", 'status': true},
  //   {"nom": 'youla', 'image': "assets/images/avatar3.jpg", 'status': false},
  //   {"nom": 'diallo', 'image': "assets/images/avatar.jpg", 'status': true},
  //   {"nom": 'diallo', 'image': "assets/images/avatar.jpg", 'status': true}
  // ];

  List<User> users = [];

  TextEditingController textController =
      TextEditingController(); // Ajout du contrôleur de texte
  List messages = [];

  int pageCount = 1;
  PagingController<int, User> pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    //la methode

    // messages = [
    //   {
    //     'user': users[0],
    //     'message': "Félicitations ",
    //     'heure': "16:12",
    //     'status': 1
    //   },
    //   {
    //     'user': users[1],
    //     'message': "bonjour a tout le monde ",
    //     'heure': "16:12",
    //     'status': 4
    //   },
    //   {
    //     'user': users[2],
    //     'message': "hellow world ",
    //     'heure': "16:12",
    //     'status': 5
    //   },
    // ];
    pagingController.addPageRequestListener((pageKey) {
      getUsersList(page: pageKey);
    });
  }

  void getUsersList({int page = 1}) {
    getUsers(page: page, pagingController: pagingController);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

// on declare la variable avant la class build
  double fontSize = 20;
  @override
  Widget build(BuildContext context) {
    // scaffold pour cender la fenetre en deux parties appbar et body(page)
    return Scaffold(
      backgroundColor: HexColor("#12141D"),
      appBar: AppBar(
        backgroundColor: Colors.white12,
        // pour enlever le hr(ligne) par default de appbar
        elevation: 0,
        //la hauteur
        toolbarHeight: 69,
        // La propriété actions de AppBar en Flutter permet d'ajouter des actions à droite de la barre d'applications. Ces actions sont généralement des icônes ou des widgets interactifs qui effectuent des actions spécifiques lorsqu'ils sont appuyés.
        actions: [
          Padding(
            padding: EdgeInsets.all(5),
            child: Container(
              decoration: BoxDecoration(
                color: HexColor("#A855F7"),
                borderRadius: BorderRadius.all(Radius.circular(40)),
              ),
              height: 60,
              width: 66,
              child: Center(
                child: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
        // pour centrer le titre de la appnav
        centerTitle: true,
        title: Text(
          "Genius class",
          style: TextStyle(fontSize: 22, color: Colors.white),
        ),
        // La propriété leading de AppBar en Flutter permet d'ajouter un widget à gauche de la barre d'applications. Cela est souvent utilisé pour afficher un bouton de retour ou un widget interactif qui effectue une action lorsque l'utilisateur le touche.
        // GestureDetector => gestionnaire d'evenement
        leading: GestureDetector(
          onTap: () => {
            setState(() {
              if (fontSize > 40) {
                fontSize = 20;
              }
              fontSize = fontSize + 4;
            }),
          },
          child: CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage("assets/images/avatar.jpg"),
          ),
        ),
      ),
      body: SingleChildScrollView(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            child: PagedListView(
              scrollDirection: Axis.horizontal,
              pagingController: pagingController,
              builderDelegate: PagedChildBuilderDelegate<User>(
                  firstPageProgressIndicatorBuilder: (context) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 15,
                      ),
                      CircularProgressIndicator(
                        backgroundColor: Colors.cyan,
                      )
                    ],
                  ),
                );
              }, firstPageErrorIndicatorBuilder: (context) {
                return Text("Error");
              }, itemBuilder: (context, item, index) {
                return createavatar(user: item);
              }),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              "Messages",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: fontSize,
                  fontWeight: FontWeight.bold),
            ),
          ),
          ListView(
            shrinkWrap: true,
            children: List.generate(messages.length, (index) {
              return GestureDetector(
                child: createmessage(message: messages[index]),
                onTap: () {
                  print("Message");
                  //Get.offAll => supprime toutes les pages precedents (sans retour possible)
                  Get.to(() => MessagePage(
                        message: messages[index],
                      ));
                  // Get.off(() => MessagePage());
                  // chargement sans possibilite de retour
                },
              );
            }),
          )
        ],
      )),
    );
  }
}

Widget createmessage({required Map message}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 5, left: 8, right: 8),
    child: ListTile(
      textColor: const Color.fromARGB(255, 222, 208, 208),
      title: Text(message['user']['nom'],
          style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle:
          Text(message['message'], style: TextStyle(color: Colors.white38)),
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: AssetImage(message['user']['image']),
      ),
      trailing: Column(
        children: [
          Text(message['heure']),
          SizedBox(
            height: 4,
          ),
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(
                color: HexColor("#301c70"),
                borderRadius: BorderRadius.all(Radius.circular(15))),
            child: Center(
              child: Text(message["status"].toString()),
            ),
          )
        ],
      ),
    ),
  );
}

Widget createavatar({required User user}) {
  return Padding(
      padding: EdgeInsets.all(10),
      child: Column(children: [
        Padding(
          padding: EdgeInsets.all(5),
          child: Stack(children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(user.image),
            ),
            true
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
            true
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
        Text("${user.firstName} ${user.lastName}",
            style: TextStyle(
                color: Color.fromARGB(255, 175, 148, 148), fontSize: 18))
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

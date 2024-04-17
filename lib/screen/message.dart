import 'package:flutter/material.dart';

//on install le package avec flutter pub add get
class MessagePage extends StatefulWidget {
  MessagePage(
      {super.key, required this.message}); //on lui passer ici au constructeur
// on declare le message ici
  late Map message;
  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
    // sinon on initialise message ici
    // late msg =widget.message;
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
          title: Text(widget.message['user']['nom']),
          backgroundColor: Colors.white12,
        ),
        body: Center(
            child: ListView(
          children: [
            const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  "Message",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold),
                )),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  widget.message['message'],
                  style: const TextStyle(
                      color: Colors.white38,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                )),
            ElevatedButton(
              // pour accer a la variable declarer dans l'autre class on precede  de widget
              child: const Text("repondre"),
              // on pourra l'utiliser comme suit msg['user']['nom']
              onPressed: () => false,
            ),
          ],
        )));
  }
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

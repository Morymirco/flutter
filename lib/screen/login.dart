import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:getwidget/components/button/gf_button.dart';
import 'package:getwidget/getwidget.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/route_manager.dart';
import 'package:getwidget/getwidget.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  void login({required Map data}) async {
    var dioClient = new dio.Dio();

    try {
      dio.Response response =
          await dioClient.post("https://reqres.in/api/login", data: data);
    } catch (e) {
      Get.snackbar("Erreur", "Email ou mot de passe invalide",
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          icon: Icon(Icons.error));
    }
  }

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

  final _formKey = GlobalKey<FormBuilderState>();
  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: BoxDecoration(
      //     image: DecorationImage(
      //   fit: BoxFit.cover,
      //   image: AssetImage("assets/images/b.jpg"),
      // )),
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              "Geniusclass",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Colors.black,
            elevation: 2,
          ),
          backgroundColor: Colors.black.withOpacity(0.4),
          body: ListView(
            children: [
              Padding(
                padding: EdgeInsets.all(15),
                child: FormBuilder(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Connexion ",
                        style: TextStyle(fontSize: 29, color: Colors.white),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      FormBuilderTextField(
                        name: 'email',
                        validator: FormBuilderValidators.required(),
                        style: TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: 'Email',
                            labelStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.lock),
                            prefixIconColor: HexColor("#301c70")),
                        // filled: true,
                        // fillColor: Colors.white,
                        // pour ajouter une arriere plan au input (tranparent par defaut)
                      ),
                      const SizedBox(height: 10),
                      FormBuilderTextField(
                        style: TextStyle(color: Colors.white),
                        name: 'password',
                        cursorColor: Colors.white,
                        decoration: InputDecoration(
                            labelText: 'Password',
                            focusColor: Colors.white,
                            // hintText: "Enter your password",
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            // enabledBorder: UnderlineInputBorder(),
                            labelStyle: TextStyle(
                                color: Colors.white54,
                                fontSize: 24,
                                fontWeight: FontWeight.bold),
                            prefixIcon: Icon(Icons.lock),
                            prefixIconColor: HexColor("#301c70")),
                        obscureText: true,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // Padding(
                      //     padding: EdgeInsets.all(10),
                      //     child: GFButton(
                      //         shape: GFButtonShape.pills,
                      //         fullWidthButton:
                      //             true, // pour que le button prenne 100% de la largeur
                      //         onPressed: () => {false},
                      //         // type: GFButtonType.outline,
                      //         size: GFSize.MEDIUM,
                      //         color: HexColor("#301c70"),
                      //         text: "connexion")),
                      MaterialButton(
                        color: HexColor("#301c70"),
                        minWidth: 250,
                        height: 50,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        onPressed: () {
                          // Validate and save the form values

                          if (_formKey.currentState!.saveAndValidate()) {
                            print(_formKey.currentState!.value);
                            login(data: _formKey.currentState!.value);
                          } else {
                            print("Error");
                          }
                          debugPrint(_formKey.currentState?.value.toString());

                          // On another side, can access all field values without saving form with instantValues
                          _formKey.currentState?.validate();
                          debugPrint(
                              _formKey.currentState?.instantValue.toString());
                        },
                        child: const Text(
                          'Sign up',
                          style: TextStyle(color: Colors.white, fontSize: 22),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const Text(
                        "--OR--",
                        style: TextStyle(color: Colors.white, fontSize: 22),
                      ),
                      Padding(
                          padding: EdgeInsets.all(20),
                          child: GFButton(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                const Text("Sign up With Google",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 18)),
                                Image.network(
                                  "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c1/Google_%22G%22_logo.svg/768px-Google_%22G%22_logo.svg.png",
                                  height: 25,
                                )
                              ],
                            ),
                            shape: GFButtonShape.pills,
                            fullWidthButton:
                                true, // pour que le button prenne 100% de la largeur
                            onPressed: () => {false},
                            type: GFButtonType.outline,
                            size: GFSize.LARGE,
                            color: HexColor("#301c70"),
                          )),
                      Padding(
                        padding: EdgeInsets.only(top: 20),
                        child: const Text("Already have an account ",
                            style:
                                TextStyle(color: Colors.white, fontSize: 28)),
                      )
                    ],
                  ),
                ),
              ),
            ],
          )
//             child: Column(
//               // crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "Create for",
//                   style: TextStyle(fontSize: 29),
//                 ),
//                 FormBuilder(
//     key: _formKey,
//     child:  FormBuilderTextField(
//         name: 'text',
//         onChanged: (val) {
//             print(val); // Print the text value write into TextField
//         },
//     ),
// )
//               ],
//             )),
          ),
    );
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

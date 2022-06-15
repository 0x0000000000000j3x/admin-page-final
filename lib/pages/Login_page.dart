import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'Widgets/them_helper.dart';
import 'Widgets/Header_widget.dart';
import 'AdminPage.dart';

late UserCredential userCredential;
TextEditingController crc = TextEditingController();

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  CollectionReference feedbacksRef =
      FirebaseFirestore.instance.collection("feedback");

  @override
  Widget build(BuildContext context) {
    showLoading(context) {
      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("please wait"),
              content: Container(
                  height: 50,
                  child: Center(
                    child: CircularProgressIndicator(),
                  )),
            );
          });
    }

    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Stack(
                children: [
                  Container(
                      height: h * 0.32,
                      child: HeaderWidget(
                        h * 0.33,
                        false,
                        Icons.person,
                      )),
                  Center(
                    child: Container(
                        height: h * 0.25,
                        width: w * 0.2,
                        child: Center(
                          child: Image(
                            image: AssetImage("img/LogoWhite.png"),
                          ),
                        )),
                  ),
                ],
              ),
              SafeArea(
                child: Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    margin: EdgeInsets.fromLTRB(20, 10, 20, 10),
                    //The login form
                    child: Column(
                      children: [
                        //  Container(
                        //     padding: EdgeInsets.all(10),
                        //     decoration: BoxDecoration(
                        //       borderRadius: BorderRadius.circular(100),
                        //       border: Border.all(
                        //           width: 5, color: Colors.white),
                        //       color: Colors.white,
                        //       boxShadow: [
                        //         BoxShadow(
                        //           color: Colors.black12,
                        //           blurRadius: 20,
                        //           offset: const Offset(5, 5),
                        //         ),
                        //       ],
                        //     ),
                        //     child: Icon(
                        //       Icons.person,
                        //       color: Colors.grey.shade900,
                        //       size: 80.0,
                        //     ),
                        //   ),
                        //   SizedBox(height:10),
                        Container(
                            height: h * 0.12,
                            child:
                                Image(image: AssetImage("img/blueLogo.png"))),
                        Text(
                          "Enter as an Admin",
                          style: TextStyle(color: Colors.grey),
                        ),
                        // Text(
                        //   "DocTell",
                        //   style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
                        // ),
                        SizedBox(
                          height: h * 0.015,
                        ),
                        Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                SizedBox(
                                  height: h * 0.03,
                                ),
                                TextFormField(
                                  controller: crc,
                                  obscureText: true,
                                  decoration: ThemHelper().textInputDecoration(
                                      'Password', 'Enter your password'),
                                  validator: (val) {
                                    if (val!.isEmpty) {
                                      return "Please enter your password";
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  height: h * 0.018,
                                ),
                                Container(
                                  decoration:
                                      ThemHelper().buttonBoxDecoration(context),
                                  child: ElevatedButton(
                                    style: ThemHelper().buttonStyle(),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.fromLTRB(40, 10, 40, 10),
                                      child: Text(
                                        'Enter'.toUpperCase(),
                                        style: TextStyle(
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white),
                                      ),
                                    ),
                                    onPressed: () async {
                                      if (_formKey.currentState!.validate()) {
                                        try {
                                          showLoading(context);
                                          userCredential = await FirebaseAuth
                                              .instance
                                              .signInWithEmailAndPassword(
                                                  email:
                                                      "adminedoctel@gmail.com",
                                                  password: crc.text);
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          AdminPage()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        } on FirebaseAuthException catch (e) {
                                          if (e.code == 'user-not-found') {
                                            Navigator.of(context).pop();
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return ThemHelper().alartDialog(
                                                    "Erreur:",
                                                    "No user found for that email.",
                                                    context);
                                              },
                                            );
                                            print(
                                                'No user found for that email.');
                                          } else if (e.code ==
                                              'wrong-password') {
                                            Navigator.of(context).pop();

                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return ThemHelper().alartDialog(
                                                    "Erreur:",
                                                    "Wrong password provided for that user.",
                                                    context);
                                              },
                                            );
                                            print(
                                                'Wrong password provided for that user.');
                                          }
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ))
                      ],
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  buttonBoxDecoration(BuildContext context) {}
}

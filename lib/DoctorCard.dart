import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:page_admin/pages/Widgets/Doctors.dart';
import '../../model/doctors.dart';
import 'package:http/http.dart' as http;

class DoctorCard extends StatefulWidget {
  final Doctor doc;
  const DoctorCard({Key? key, required this.doc}) : super(key: key);

  @override
  State<DoctorCard> createState() => _DoctorCardState();
}

class _DoctorCardState extends State<DoctorCard> {
  Future sendEmail({
    required String name,
    required String email,
    required String subject,
    required String message,
  }) async {
    final serviceId = 'service_84c3qe6';
    final templateId = 'template_tob5xuj';
    final userId = '2B6983MMP0B4nUe8r';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'user_name': name,
          'user_email': email,
          'user_subject': subject,
          'user_message': message,
        }
      }),
    );
    print("yeeeeeeeeeeeeeeeeeeeeeeeeeees");
  }

  get doc => doc;
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

  @override
  Widget build(BuildContext context) {
    double hight = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      // onTap :(){
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => DoctorPage()),
      //   );
      // },
      child: Material(
          child: SizedBox(
            width: width * 0.85,
            height: hight * 0.26,
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Stack(children: <Widget>[
                Material(
                  elevation: 3,
                  shadowColor: const Color.fromARGB(255, 255, 255, 255),
                  borderRadius: BorderRadius.circular(19),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Column(
                                // This is The description Of the Card
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 9.0, right: 3, left: 9, top: 9),
                                      child: Text(
                                        widget.doc.nameofthedoctor,
                                        style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.w800),
                                      )),
                                  Padding(
                                      padding: const EdgeInsets.only(
                                          bottom: 7.50, right: 3, left: 9),
                                      child: Text(
                                        widget.doc.categorie,
                                        style: const TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w700),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 7.5, right: 3, left: 9),
                                    child: Row(
                                      // This is The Location
                                      children: [
                                        const Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Image(
                                                image: AssetImage(
                                                    'assets/images/LocationLogo.png'))),
                                        Text(
                                          widget.doc.place,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        top: 7.5, right: 3, left: 9),
                                    child: Row(
                                      //this is the phone number
                                      children: [
                                        const Padding(
                                            padding: EdgeInsets.only(right: 5),
                                            child: Icon(Icons.phone)),
                                        Text(
                                          widget.doc.telephone,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              color: Colors.grey),
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Padding(
                              padding:
                              EdgeInsets.only(bottom: 7.0, right: 10, left: 9),
                            ),
                          ],
                        ),
                        const Padding(padding: EdgeInsets.all(8)),
                        Column(
                          children: [
                            SizedBox(
                              // this is the button's design
                              height: MediaQuery.of(context).size.height * 0.034,
                              child: Row(
                                children: [
                                  SizedBox(
                                    width: width * 0.04,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        print(widget.doc.nameofthedoctor);
                                        //TODO: Put the code in case the doctor is ACCEPTED here
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Confirmation:"),
                                                content: Text(
                                                    "Do you want to accept this doctor?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text("CANCEL")),
                                                  TextButton(
                                                      onPressed: () async {
                                                        showLoading(context);
                                                        await FirebaseFirestore
                                                            .instance
                                                            .collection("Docuser")
                                                            .doc(widget.doc.uid)
                                                            .update({
                                                          "isAccepted": true,
                                                        });
                                                        sendEmail(
                                                            name:
                                                            widget.doc
                                                                .nameofthedoctor,
                                                            email:
                                                            widget.doc
                                                                .email,
                                                            subject:
                                                            "DocTel team : replay",
                                                            message: "You have been accepted to our application\nYou have the access now to doctel!");
                                                        Navigator.of(context).pop();

                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text("SUBMIT"))
                                                ],
                                              );
                                            });
                                        // await FirebaseFirestore.instance
                                        //     .collection("Docuser")
                                        //     .doc(widget.doc.uid)
                                        //     .update({
                                        //   "isAccepted": true,
                                        // });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(Colors.green),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30.0))),
                                      ),
                                      child: const Text(
                                        "Accept",
                                        style: TextStyle(fontFamily: 'Montserrat'),
                                      )),
                                  SizedBox(
                                    width: width * 0.04,
                                  ),
                                  ElevatedButton(
                                      onPressed: () async {
                                        //TODO: Put the code in case the doctor is REFUSED here
                                        print(widget.doc.nameofthedoctor);
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Text("Confirmation:"),
                                                content: Text(
                                                    "Do you want to refuse this doctor?"),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text("CANCEL")),
                                                  TextButton(
                                                      onPressed: () async {
                                                        showLoading(context);

                                                        var notref =
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            'Docuser');
                                                        notref
                                                            .where('owner',
                                                            isEqualTo: widget
                                                                .doc.uid)
                                                            .get()
                                                            .then((value) {
                                                          for (var element
                                                          in value.docs) {
                                                            notref
                                                                .doc(element.id)
                                                                .delete();
                                                          }
                                                        });
                                                        sendEmail(
                                                            name:
                                                            widget.doc
                                                                .nameofthedoctor,
                                                            email:
                                                            widget.doc
                                                                .email,
                                                            subject:
                                                            "DocTel team : replay",
                                                            message: "You have not been accepted to our application unfortunately!");
                                                        Navigator.of(context).pop();

                                                        Navigator.of(context).pop();
                                                      },
                                                      child: Text("SUBMIT"))
                                                ],
                                              );
                                            });
                                      },
                                      style: ButtonStyle(
                                        backgroundColor:
                                        MaterialStateProperty.all(Colors.red),
                                        shape: MaterialStateProperty.all(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(30.0))),
                                      ),
                                      child: const Text(
                                        "Refuse",
                                        style: TextStyle(fontFamily: 'Montserrat'),
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ]),
                ),
                FractionalTranslation(
                  translation: Offset(2.01, 0.4),
                  child: Container(
                    //This is The Photo of The Card

                    decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(100)),
                    child: ClipOval(
                      child: widget.doc.urlpic != ""
                          ? Image.network(
                        widget.doc.urlpic!,
                        width: 100,
                        height: 100,
                        fit: BoxFit.cover,
                      )
                          : Icon(
                        Icons.person,
                        size: 100,
                        color: Colors.grey.shade400,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          )),
    );
  }
}

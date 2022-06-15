import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:page_admin/pages/Login_page.dart';
import 'AdminPage.dart';
class Feedbacks extends StatefulWidget {
  Feedbacks ({Key? key}) : super(key: key);

  @override
  State<Feedbacks> createState() => _FeedbacksState();
}

class _FeedbacksState extends State<Feedbacks> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigoAccent,
        title: Text('Feedbacks',style: TextStyle(fontFamily: 'Montserrat',)),
        centerTitle: true,
      ),
      body: ListView(

        children: [
              DataTable(horizontalMargin: 50,
                columns: [
                  DataColumn(label: Text(
                      'Feedbacks',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  )),
                  DataColumn(label: Text(
                      'Ratings',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)
                  )),
                ],
                rows: [],
              ),

          Container(

            child: FutureBuilder<QuerySnapshot>(
              future: LoginPageState().feedbacksRef.get(),
              builder: (context,snapshot) {
                if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return DataTable(
                          columns: [
                            DataColumn(label: Text(
                                '',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)
                            )),
                            DataColumn(label: Text(
                                '',
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold)
                            )),
                          ],
                          rows: [DataRow(cells: [
                            DataCell(Text(
                                "${snapshot.data!.docs[index]['feedback']}")),
                            DataCell(Text(
                                "${snapshot.data!.docs[index]['rating']}")),
                          ]),
                          ],
                        );
                      }

                    //if (snapshot.connectionState==ConnectionState.waiting) {return Text('Loading...');}


                  );
                }else {
                  return const Center(child: CircularProgressIndicator());
                }
              }
              ),

    ),

        ],
      ));

  }
}

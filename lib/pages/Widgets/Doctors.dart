import 'package:cloud_firestore/cloud_firestore.dart';

class Doctor {

  late String nameofthedoctor;
  late String categorie;
  late String place;
  late String telephone;
  late String urlpic;
    late String uid;
        late String email;



  Doctor(this.nameofthedoctor,this.telephone,this.categorie, this.place,this.urlpic,this.uid,this.email);


}
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:page_admin/pages/Login_page.dart';
import 'package:firebase_core/firebase_core.dart';
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDeEr3hrN8NLPX0q61ytUVfMRjIV_AGNew",
        appId: "1:236121457754:web:0376549f83f124ed150463",
        messagingSenderId: "236121457754",
        projectId: "doctel-65452",
        storageBucket: "doctel-65452.appspot.com",

  ));
  runApp(const LoginDoctell());
}

class LoginDoctell extends StatelessWidget {

  const LoginDoctell({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color _PrimaryColor = HexColor("#397EF5");
    Color _accentColor = HexColor("#397EF5");
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Admin page',
      theme: ThemeData(
        primaryColor: _PrimaryColor,
        scaffoldBackgroundColor: Colors.grey.shade100,
        colorScheme: ColorScheme.fromSwatch().copyWith(secondary: _accentColor),
        primarySwatch: Colors.grey,
      ),
      home: LoginPage(),
    );
  }
}



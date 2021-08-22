import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:myapp/globalVariables.dart';

import 'fetchdata/fetchdata.dart';
import 'homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(body: Login()),
    );
  }
}

class Login extends StatefulWidget {
  @override
  _LoginViewState createState() => _LoginViewState();
}

List beforeworkBudget;
List afterworkBudget;
List evaluateGrades;
List overallGrades;

class _LoginViewState extends State<Login> {
  bool _showPassword = false;
  final auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final mathText = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Matematik \n med piraterne",
          textAlign: TextAlign.center,
          style: GoogleFonts.montserrat(color: Colors.black, fontSize: 40),
        )
      ],
    );
    final imageLogo =
        Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Image.asset(
        'asset/logo.png',
        fit: BoxFit.contain,
        height: 400,
      ),
    ]);
    final emailField = SizedBox(
      width: 450,
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        style: TextStyle(
          color: Colors.black,
        ),
        cursorColor: Colors.black,
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.email,
            color: Colors.grey,
          ),
          contentPadding:
              new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: greenColor, width: 2.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
            borderSide: BorderSide(color: Colors.black, width: 1.0),
          ),
          labelText: 'mail@mail.dk',
          labelStyle: TextStyle(fontFamily: "Montserrat", color: Colors.grey),
          hintText: 'email',
          hintStyle: TextStyle(fontFamily: "Montserrat", color: Colors.black),
        ),
      ),
    );

    final passwordField = SizedBox(
        width: 450,
        child: Column(
          children: <Widget>[
            TextFormField(
              obscureText: true,
              controller: _passwordController,
              style: TextStyle(
                color: Colors.black,
              ),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.visibility),
                  color: Colors.grey,
                  onPressed: () {
                    setState(() => this._showPassword = !this._showPassword);
                  },
                ),
                contentPadding:
                    new EdgeInsets.symmetric(vertical: 25.0, horizontal: 10.0),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: greenColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                labelText: 'password',
                labelStyle:
                    TextStyle(fontFamily: "Montserrat", color: Colors.grey),
                hintText: 'password',
                hintStyle:
                    TextStyle(fontFamily: "Montserrat", color: Colors.black),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(2.0),
            ),
          ],
        ));

    final fields = Padding(
      padding: EdgeInsets.only(top: 10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          imageLogo,
          SizedBox(height: 20),
          mathText,
          SizedBox(height: 50),
          emailField,
          SizedBox(height: 20),
          passwordField,
        ],
      ),
    );

    final loginButton = Material(
      elevation: 5.0,
      borderRadius: BorderRadius.circular(45.0),
      color: greenColor,
      child: MaterialButton(
        minWidth: 350.0,
        height: 100.0,
        child: Text(
          "Login",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: ButtonText,
            color: Colors.white,
            fontFamily: "Montserrat",
          ),
        ),
        onPressed: () async {
          try {
            // ignore: deprecated_member_use
            final User user =
                (await FirebaseAuth.instance.signInWithEmailAndPassword(
              email: _emailController.text,
              password: _passwordController.text,
            ))
                    .user;
            if (user != null) {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String userID = user.uid;
              prefs.setString('userid', userID);
              print(userID);
              prefs.setString('displayName', user.displayName);
              prefs.setString('email', user.email);
              print(user.email);
              fetcUserGameOne();
              fetcUserGameTwo();
              fetcUserGameThree();
              fetcUserGameFour();
              fetcUserGameFive();
              fetcUserGameSix();
              fetcUserGameSeven();
              fetcUserGameEight();
              fetcUserGameNine();
              fetcUserGameTen();
              fetcUserGameEleven();
              fetcUserGameTwelve();
              fetcUserGameThirteen();
              fetcUserGameFourteen();
              fetcUserGameFifteen();
              fetcUserGameSixteen();
              fetcQuizOne();
              fetcQuizTwo();
              fetcQuizThree();
              fetcQuizFour();

              CollectionReference users =
                  FirebaseFirestore.instance.collection('Users');
              username = user.email;

              username = user.email;

              // ignore: deprecated_member_use
              users
                  .where("email", isEqualTo: user.email)
                  .get()
                  .then((querySnapshot) {
                querySnapshot.docs.forEach((result) {
                  print(prefs.getString("Skole"));

                  prefs.setString("Admin", result.data()["Admin"]);
                  if (result.data()["Admin"] != null) {
                    prefs.setString("Skole", result.data()["school"]);
                    print(prefs.getString("Skole"));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Homepage(),
                      ),
                    );
                    fetcUserClasses(prefs.getString("Skole"));
                  } else {
                    print("got here too");
                  }
                });
              });
            }
          } catch (e) {
            print(e);
            _emailController.text = "";
            _passwordController.text = "";
          }
        },
      ),
    );

    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        loginButton,
        SizedBox(height: 20),
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[],
        ),
      ],
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Container(
            height: mq.size.height,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                fields,
                Padding(
                  padding: EdgeInsets.only(bottom: 150),
                  child: bottom,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

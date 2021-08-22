import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/globalVariables.dart';
import 'package:myapp/homepage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';

class Register extends StatefulWidget {
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _passwordController1 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    future:
    Firebase.initializeApp();
    void showAlertDialog(BuildContext context) {}
    final mathText = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Tilføj elev",
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
        ));

    final passwordField = SizedBox(
        width: 450,
        child: Column(
          children: <Widget>[
            TextFormField(
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
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: greenColor, width: 2.0),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  borderSide: BorderSide(color: Colors.black, width: 1.0),
                ),
                labelText: 'kode',
                labelStyle:
                    TextStyle(fontFamily: "Montserrat", color: Colors.grey),
                hintText: 'kode',
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
          SizedBox(height: 20),
        ],
      ),
    );

    final loginButton = SizedBox(
        width: 450,
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(25.0),
          color: greenColor,
          child: MaterialButton(
            minWidth: 350.0,
            height: 100.0,
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
            child: Text(
              "Opret en mere",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 25),
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("email", _emailController.text);
              prefs.setString("password", _passwordController.text);

              try {
                // ignore: deprecated_member_use
                final User user =
                    (await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                ))
                        .user;
                if (user != null) {
                  CollectionReference users =
                      FirebaseFirestore.instance.collection('Users');
                  // Call the user's CollectionReference to add a new user
                  users
                      .add({
                        "PrivatBruger": "0",
                        "skole": prefs.getString("Skole"),
                        "klasse": "",
                        "email": _emailController.text,
                      })
                      .then((value) => print("User Added"))
                      .catchError(
                          (error) => print("Failed to add user: $error"));

                  _emailController.clear();
                  _passwordController.clear();
                }
              } catch (e) {
                print(e);
                String error = e.toString();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(error),
                        ),
                      );
                    });

                _emailController.text = "";
                _passwordController.text = "";
              }
            },
          ),
        ));

    final doneButton = SizedBox(
        width: 450,
        child: Material(
          elevation: 5.0,
          borderRadius: BorderRadius.circular(25.0),
          color: greenColor,
          child: MaterialButton(
            minWidth: 350.0,
            height: 100.0,
            padding: EdgeInsets.fromLTRB(10.0, 15.0, 10.0, 15.0),
            child: Text(
              "Det var den sidste",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 25),
            ),
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              prefs.setString("email", _emailController.text);
              prefs.setString("password", _passwordController.text);

              try {
                // ignore: deprecated_member_use
                final User user =
                    (await FirebaseAuth.instance.createUserWithEmailAndPassword(
                  email: _emailController.text,
                  password: _passwordController.text,
                ))
                        .user;
                if (user != null) {
                  CollectionReference users =
                      FirebaseFirestore.instance.collection('Users');
                  // Call the user's CollectionReference to add a new user
                  users
                      .add({
                        "PrivatBruger": "0",
                        "skole": prefs.getString("Skole"),
                        "klasse": "",
                        "email": _emailController.text,
                      })
                      .then((value) => print("User Added"))
                      .catchError(
                          (error) => print("Failed to add user: $error"));

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Homepage(),
                    ),
                  );
                }
              } catch (e) {
                print(e);
                String error = e.toString();
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Container(
                          child: Text(error),
                        ),
                      );
                    });

                _emailController.text = "";
                _passwordController.text = "";
              }
            },
          ),
        ));
    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        loginButton,
        SizedBox(height: 20),
        doneButton,
        Padding(
          padding: EdgeInsets.all(8.0),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            MaterialButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Homepage(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );

    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'asset/logo.png',
              fit: BoxFit.contain,
              height: 50,
            ),
          ],
        ),
        iconTheme: IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(36),
          child: Container(
            height: mq.size.height * 1.2,
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

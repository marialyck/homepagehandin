import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/globalVariables.dart';
import 'package:myapp/homepage.dart';
import 'package:myapp/subPages/addstudent.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

import '../widgets.dart';

class RegisterClass extends StatefulWidget {
  @override
  _RegisterClass createState() => _RegisterClass();
}

class _RegisterClass extends State<RegisterClass> {
  bool _showPassword = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _yearController = TextEditingController();
  TextEditingController _letterController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    future:
    void showAlertDialog(BuildContext context) {}
    final mathText = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Tilføj klasse",
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
    final yearfield = SizedBox(
        width: 450,
        child: TextFormField(
          controller: _yearController,
          keyboardType: TextInputType.number,
          style: TextStyle(
            color: Colors.black,
          ),
          cursorColor: Colors.black,
          decoration: InputDecoration(
            suffixIcon: Icon(
              Icons.tag,
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
            labelText: 'startår',
            labelStyle: TextStyle(fontFamily: "Montserrat", color: Colors.grey),
            hintText: 'Hvilket år startede eleverne i 0.?',
            hintStyle: TextStyle(fontFamily: "Montserrat", color: Colors.black),
          ),
        ));

    final letterField = SizedBox(
        width: 450,
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _letterController,
              style: TextStyle(
                color: Colors.black,
              ),
              cursorColor: Colors.black,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: Icon(Icons.sort_by_alpha),
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
                labelText: 'bogstav',
                labelStyle:
                    TextStyle(fontFamily: "Montserrat", color: Colors.grey),
                hintText: 'A, B, C?',
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
          yearfield,
          SizedBox(height: 20),
          letterField,
          SizedBox(height: 20),
        ],
      ),
    );

    final addClassButton = SizedBox(
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
                "Opret en mere klasse",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.montserrat(color: Colors.white, fontSize: 25),
              ),
              onPressed: () async {
                try {
                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  CollectionReference users =
                      FirebaseFirestore.instance.collection('Classes');
                  // Call the user's CollectionReference to add a new user
                  users
                      .add({
                        "Klasse": _yearController.text,
                        "skole": prefs.getString("Skole"),
                        "letter": _letterController.text,
                      })
                      .then((value) => print("class Added"))
                      .catchError(
                          (error) => print("Failed to add user: $error"));
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
                }
                _yearController.clear();
                _letterController.clear();
              }),
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
              "Det var den sidste, opret elever nu",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(color: Colors.white, fontSize: 25),
            ),
            onPressed: () async {
              try {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                CollectionReference users =
                    FirebaseFirestore.instance.collection('Classes');
                // Call the user's CollectionReference to add a new user
                users
                    .add({
                      "Klasse": _yearController.text,
                      "skole": prefs.getString("Skole"),
                      "letter": _letterController.text,
                    })
                    .then((value) => print("class Added"))
                    .catchError((error) => print("Failed to add user: $error"));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Register(),
                  ),
                );
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
              }
            },
          ),
        ));
    final bottom = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        addClassButton,
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

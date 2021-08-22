import 'dart:convert';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/globalVariables.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets.dart';
import 'package:intl/intl.dart';

class Classes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
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
            body: ListViewHomeLayout()));
  }
}

DateTime now = DateTime.now();

class ListViewHomeLayout extends StatefulWidget {
  @override
  ListViewHome createState() {
    return new ListViewHome();
  }
}

class ListViewHome extends State<ListViewHomeLayout> {
  void initState() {
    getSP();
    super.initState();
  }

  bool isLoaded = false;
  void getSP() async {
    String formattedYear = DateFormat('yyyy').format(now);

    int counterYear = int.parse(formattedYear);
    var prefs = await SharedPreferences.getInstance();

    setState(() => isLoaded = true);

    setState(() {
      classes = prefs.getStringList("Klasse") ?? classes;
      List p = classes.map((e) => int.parse(e)).toList();
      print(p);
      for (int i = 0; i < p.length; i++) {
        realclass.add(counterYear - p[i]);
        print(realclass);
      }
    });

    setState(() {
      years = prefs.getStringList("Klasse") ?? classes;
    });
    setState(() {
      letter = prefs.getStringList("Letter") ?? letter;
    });
  }

  final icons = [Icons.person];
  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? CircularProgressIndicator()
        : ListView.builder(
            itemCount: classes.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                onTap: () async {},
                title: Text(
                  "Klasse: " +
                      realclass[index].toString() +
                      ". " +
                      letter[index],
                  style:
                      GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
                  textAlign: TextAlign.center,
                ),
                subtitle: Container(
                    child: (Column(children: <Widget>[
                  Text(
                    "Start år: " + years[index],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.montserrat(color: Colors.black),
                  ),
                ]))),
                leading: Icon(
                  Icons.group,
                  color: purpleColor,
                ),
              ));
            });
  }
}

List years = ["bla"];
List classes = ["bla"];
List letter = ["bla"];
List realclass = [];

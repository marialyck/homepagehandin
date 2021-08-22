import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:myapp/globalVariables.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class ResultDetails extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    'assets/Logo_2020_04_Sort.png',
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
    var prefs = await SharedPreferences.getInstance();
    indexSales = prefs.getString("indexSales") ?? indexSales;

    readyshop = prefs.getString("ready") ?? readyshop;
    brand = prefs.getString("brand") ?? brand;

    day = prefs.getStringList("datesshop") ?? day;
    talentshop = prefs.getStringList("talentshop") ?? talentshop;
    shopcomments = prefs.getStringList("shopcomments") ?? shopcomments;
    shopothers = prefs.getStringList("shopothers") ?? shopothers;

    budgetinitial = prefs.getStringList("startBudgetshop") ?? budgetinitial;
    budgetend = prefs.getStringList("endBudgetshop") ?? budgetend;
    setState(() => isLoaded = true);
  }

  final icons = [Icons.person];
  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? CircularProgressIndicator()
        : ListView.builder(
            itemCount: day.length,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    FlatButton(
                      onPressed: () => {},
                      color: Colors.white,
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        // Replace with a Row for horizontal icon + text
                        children: <Widget>[
                          Icon(
                            Icons.arrow_left,
                            size: 30,
                          ),
                          Text("Tilbage",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.black,
                                  fontFamily: 'NunitoSansBold')),
                        ],
                      ),
                    ),
                  ],
                );
              }
              SizedBox(height: 20);
              if (index == 1) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(width: 200),
                    OutlinedButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    super.widget));

                        /*Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Talentsstatistics()),
                        );*/
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0))),
                      ),
                      child: Text('Hent data',
                          style: TextStyle(
                              fontSize: 30.0,
                              color: Colors.black,
                              fontFamily: 'NunitoSansBold')),
                    ),
                  ],
                );
              }
              SizedBox(height: 20);
              if (index == 2) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                      child: Text("Index: " + indexSales,
                          style: TextStyle(
                              fontSize: 30.0,
                              color: greenColor,
                              fontFamily: 'NunitoSansBold')),
                    ),

                    SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                      child: Text("Brand præsentation: " + brand,
                          style: TextStyle(
                              fontSize: 30.0,
                              color: greenColor,
                              fontFamily: 'NunitoSansBold')),
                    ),

                    SizedBox(height: 20),
                    OutlinedButton(
                      onPressed: () {},
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0))),
                      ),
                      child: Text("Butik klar: " + readyshop,
                          style: TextStyle(
                              fontSize: 30.0,
                              color: greenColor,
                              fontFamily: 'NunitoSansBold')),
                    ),

                    SizedBox(height: 20),

                    //Image.asset("An image"),
                  ],
                );
              }
              SizedBox(height: 20);
              return Card(
                  child: ListTile(
                onTap: () {
                  setState(() {});
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(day[index] + ' valgt!'),
                  ));
                },
                title: Container(
                  child: (Column(
                    children: <Widget>[
                      Text(
                        day[index],
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        day[index],
                        textAlign: TextAlign.center,
                      ),
                    ],
                  )),
                ),
                subtitle: Container(
                    child: (Column(
                  children: <Widget>[
                    Text("Talent: " + talentshop[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                            fontFamily: 'NunitoSansBold')),
                    Text("Kommentar til dagen: " + shopcomments[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: greenColor,
                            fontFamily: 'NunitoSansBold')),
                    Text("Andre kommentar: " + shopothers[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 15.0,
                            color: greenColor,
                            fontFamily: 'NunitoSansBold')),
                    Text("Start budget: " + budgetinitial[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                            fontFamily: 'NunitoSansBold')),
                    Text("Slut budget: " + budgetend[index],
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Colors.black,
                            fontFamily: 'NunitoSansBold'))
                  ],
                ))),
                leading: Icon(Icons.comment),
              ));
            });
  }
}

List shops = ["bla"];
List shopothers = ["bla"];
List talentshop = ["bla"];
List day = ["bla"];
String indexSales = "bla";
String brand = "bla";
String readyshop = "bla";
List shopcomments = ["bla"];
List budgetinitial = ["bla"];
List budgetend = ["bla"];

import 'package:flutter/material.dart';
import 'package:myapp/subPages/resultDetails.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../widgets.dart';

class Results extends StatelessWidget {
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
            body: ListViewHomeLayout()

            //ListViewHome(),

            ));
  }
}

class ListViewHomeLayout extends StatefulWidget {
  @override
  ListViewHome createState() {
    return new ListViewHome();
  }
}

String pickedShop;

class ListViewHome extends State<ListViewHomeLayout> {
  void initState() {
    getSP();
    super.initState();
  }

  bool isLoaded = false;
  void getSP() async {
    var prefs = await SharedPreferences.getInstance();
    _name = prefs.getStringList("DKShop") ?? _name;
    _shops = prefs.getStringList("DKShopuserlist") ?? _name;
    setState(() => isLoaded = true);
  }

  //Not dynamic MF anymore!!!! MUAHAHAHAHAHA

  @override
  Widget build(BuildContext context) {
    return !isLoaded
        ? CircularProgressIndicator()
        : ListView.builder(
            itemCount: _name.length,
            itemBuilder: (context, index) {
              return Card(
                  child: ListTile(
                onTap: () async {
                  //setState(() async {});

                  SharedPreferences prefs =
                      await SharedPreferences.getInstance();
                  FirebaseFirestore.instance
                      .collection("DKBeforeWork")
                      .where("Butik Navn", isEqualTo: _name[index])
                      .get()
                      .then(((querySnapshot) {
                    readyShop = querySnapshot.docs
                        .map((e) => (e.data()["Butik klar "].toString()))
                        .toList();
                    brandIntro = querySnapshot.docs
                        .map((e) => (e.data()["Brand præsentation"].toString()))
                        .toList();
                    missing = querySnapshot.docs
                        .map((e) => (e.data()["Mangler følgende"].toString()))
                        .toList();
                  }));
                  print(missing);
                  final List<int> before =
                      readyShop.map((e) => int.parse(e)).toList();

                  final List<int> after =
                      brandIntro.map((e) => int.parse(e)).toList();

                  int sumreadyShop = before.fold(0, (p, c) => p + c);
                  int sumbrandIntro = after.fold(0, (p, c) => p + c);

                  double readySum = sumreadyShop / readyShop.length;
                  double brandintrosum = sumbrandIntro / brandIntro.length;
                  String tostringready = readySum.toStringAsFixed(2);
                  print(tostringready);
                  prefs.setString("ready", tostringready);

                  String tostringbrand = brandintrosum.toStringAsFixed(2);
                  print(tostringbrand);
                  prefs.setString("brand", tostringbrand);

                  FirebaseFirestore.instance
                      .collection("DKAfterWork")
                      .where("Butik: ", isEqualTo: _name[index])
                      .get()
                      .then((querySnapshot) {
                    querySnapshot.docs.forEach((result) {
                      //result.data()["Navn"];
                      initialnummber = querySnapshot.docs
                          .map((e) =>
                              (e.data()["Oprindeligt Budget"].toString()))
                          .toList();
                      finishednumber = querySnapshot.docs
                          .map((e) =>
                              (e.data()["Afsluttende Budget"].toString()))
                          .toList();
                      dates = querySnapshot.docs
                          .map((e) => (e.data()["Dato og tid "].toString()))
                          .toList();
                      others = querySnapshot.docs
                          .map((e) => (e.data()["Andet"].toString()))
                          .toList();
                      comments = querySnapshot.docs
                          .map((e) =>
                              (e.data()["Kommentar til dagen"].toString()))
                          .toList();

                      talent = querySnapshot.docs
                          .map((e) => (e.data()["Talent "].toString()))
                          .toList();
                    });

                    prefs.setStringList("datesshop", dates);
                    prefs.setStringList("talentshop", talent);
                    prefs.setStringList("shopcomments", comments);
                    prefs.setStringList("shopothers", others);

                    prefs.setStringList("startBudgetshop", initialnummber);
                    prefs.setStringList("endBudgetshop", finishednumber);

                    prefs.remove("index");
                    final List<int> before =
                        initialnummber.map((e) => int.parse(e)).toList();

                    final List<int> after =
                        finishednumber.map((e) => int.parse(e)).toList();

                    int sumbefore = before.fold(0, (p, c) => p + c);
                    int sumafter = after.fold(0, (p, c) => p + c);

                    double index = sumafter / sumbefore * 100;

                    String tostring = index.toStringAsFixed(2);

                    prefs.setString("indexSales", tostring);
                    print(tostring);
                  });

                  pickedShop = _name[index].toString();
                  prefs.setString("selectedShop", pickedShop);
                  Scaffold.of(context).showSnackBar(SnackBar(
                    content: Text(_name[index] + ' valgt!'),
                  ));

                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ResultDetails()),
                  );
                },
                title: Text(
                  _name[index],
                  textAlign: TextAlign.center,
                ),
                leading: Icon(Icons.storefront),
              ));
            });
  }
}

List _name = ["bla", "bla", "bla", "bla", "bla", "bla", "bla"];
List _shops = ["bla", "bla", "bla", "bla", "bla", "bla", "bla"];
List initialnummber = ["bla"];
List finishednumber = ["bla"];
List dates = ["bla"];
List talent = ["bla"];
List others = ["bla"];
List comments = ["bla"];
List readyShop = ["bla"];
List brandIntro = ["bla"];
List missing = ["bla"];

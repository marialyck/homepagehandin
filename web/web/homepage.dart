import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'globalVariables.dart';
import 'firstPageConstructors/Initials.dart';
import 'widgets.dart';

class Homepage extends StatefulWidget {
  @override
  _Homepage createState() => _Homepage();
}

class _Homepage extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Matematik med piraterne",
                textAlign: TextAlign.center,
                style:
                    GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
              )
            ],
          ),
          iconTheme: IconThemeData(color: greenColor),
          backgroundColor: Colors.white,
          actions: [
            PopupMenuButton(
              icon: Icon(Icons.more_vert),
              itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                const PopupMenuItem(
                  value: 0,
                  child: ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: greenColor,
                    ),
                    title: Text('Log ud'),
                  ),
                ),
              ],
              onSelected: (result) {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyApp()),
                );
              },
            ),
          ],
        ),
        body: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              alignment: Alignment(10, 10),
              child: Schoolname(),
            ),
            SizedBox(height: 20),
            SizedBox(height: 10),
          ],
        ));
  }
}

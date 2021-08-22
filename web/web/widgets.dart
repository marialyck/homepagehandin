import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myapp/globalVariables.dart';
import 'package:myapp/subPages/addclass.dart';
import 'package:myapp/subPages/addstudent.dart';
import 'package:myapp/subPages/classes.dart';
import 'package:myapp/subPages/results.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'homepage.dart';
import 'main.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              ' ',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
                color: greenColor,
                image: DecorationImage(
                    fit: BoxFit.fill, image: AssetImage('asset/bgr_3.png'))),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
              color: greenColor,
            ),
            title: Text(
              'Hjem',
              style: GoogleFonts.montserrat(color: Colors.black),
            ),
            onTap: () async => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Homepage()))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.group,
              color: purpleColor,
            ),
            title: Text(
              'Klasse',
              style: GoogleFonts.montserrat(color: Colors.black),
            ),
            onTap: () async => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Classes()))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.face,
              color: darkBlueColor,
            ),
            title: Text(
              'Elever',
              style: GoogleFonts.montserrat(color: Colors.black),
            ),
            onTap: () => {
              //fetcUserData(),
            },
          ),
          ListTile(
            leading: Icon(
              Icons.gamepad,
              color: blueColor,
            ),
            title: Text(
              'Spil',
              style: GoogleFonts.montserrat(color: Colors.black),
            ),
            onTap: () async => {
              //fetcShops(),
              /*Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Shops()))*/
            },
          ),
          ListTile(
            leading: Icon(
              Icons.help,
              color: redColor,
            ),
            title: Text(
              'Quizzer',
              style: GoogleFonts.montserrat(color: Colors.black),
            ),
            onTap: () async => {
              //fetcUserData(),

              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Results()))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.add,
              color: orangeColor,
            ),
            title: Text(
              'Tilføj klasse',
              style: GoogleFonts.montserrat(color: Colors.black),
            ),
            onTap: () async => {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => RegisterClass()))
            },
          ),
          ListTile(
            leading: Icon(
              Icons.person_add,
              color: pinkColor,
            ),
            title: Text(
              'Tilføj elever',
              style: GoogleFonts.montserrat(color: Colors.black),
            ),
            onTap: () async => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Register()))
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text(
              'Log ud',
              style: GoogleFonts.montserrat(color: Colors.black),
            ),
            onTap: () async => {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => MyApp()))
            },
          ),
        ],
      ),
    );
  }
}

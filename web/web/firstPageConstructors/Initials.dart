import 'package:shared_preferences/shared_preferences.dart';
import '../globalVariables.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Schoolname extends StatefulWidget {
  @override
  _SchoolnameState createState() {
    return new _SchoolnameState();
  }
}

class _SchoolnameState extends State<Schoolname> {
  String schoolname = "skole";
  void getSchoolname() async {
    var prefs = await SharedPreferences.getInstance();

    setState(() {
      schoolname = prefs.getString("Skole");
    });
  }

  @override
  Widget build(BuildContext context) {
    getSchoolname();
    return Container(
      alignment: Alignment(-0.95, -0.95),
      child: Text(
        "Skole: " + schoolname,
        style: GoogleFonts.montserrat(color: Colors.black, fontSize: 20),
      ),
    );
  }
}

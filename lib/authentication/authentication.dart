import 'package:flutter/material.dart';
import 'package:irdc_attendance/authentication/SignupScreen.dart';
import 'package:irdc_attendance/authentication/loginScreen.dart';

class authentication extends StatefulWidget {
  @override
  _authenticationState createState() => _authenticationState();
}

class _authenticationState extends State<authentication> {
  bool showsignin = true;
  void toggleview() {
    setState(() {
      showsignin = !showsignin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showsignin) {
      return Login_page(toggleview: toggleview);
    } else {
      return register(toggleview: toggleview);
    }
  }
}

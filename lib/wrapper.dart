import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:irdc_attendance/authentication/authentication.dart';
import 'package:irdc_attendance/home/Confirm_Signout.dart';
import 'package:irdc_attendance/home/Home_page.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class wrapper extends StatelessWidget {
  const wrapper({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    if (user == null) {
      return authentication();
    } else {
      // return Home();
      return choose() == null ? Home() : Signout();
    }
  }
}

choose() async {
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  var Name = sharedPreferences.getString('name');
}

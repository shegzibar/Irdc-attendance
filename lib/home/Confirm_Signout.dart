import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irdc_attendance/Services/auth.dart';
import 'package:irdc_attendance/Services/database.dart';
import 'package:irdc_attendance/home/Home_page.dart';

class Signout extends StatefulWidget {
  const Signout({Key key}) : super(key: key);

  @override
  _Confirm_SignoutState createState() => _Confirm_SignoutState();
}

class _Confirm_SignoutState extends State<Signout> {
  int attend = 0;
  String userid = "";
  Authservice _auth = Authservice();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    inputData();
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  void inputData() {
    final user = auth.currentUser;
    userid = user.uid;

    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          'IRDC',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              height: 300.0.h,
              width: 300.0.w,
              child: Icon(
                Icons.check_circle_outline,
                size: 150.sm,
                color: Colors.blue,
              ),
            ),
            SizedBox(
              width: 65.0.w,
            ),
            SizedBox(height: 150.h),
            Row(
              children: [
                SizedBox(
                  width: 45.0.w,
                ),
                Container(
                  width: 300.0.w,
                  height: 50.0.h,
                  child: OutlineButton(
                      onPressed: () async {
                        await DatabaseService(uid: userid).updateattend(attend);
                        Navigator.pop(context);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Home()));
                      },
                      child: Text(
                        'Sign out',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                      )),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

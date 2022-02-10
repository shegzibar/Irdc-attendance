import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:irdc_attendance/Services/auth.dart';
import 'package:irdc_attendance/Services/database.dart';
import 'package:irdc_attendance/home/Confirm_Signout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irdc_attendance/model/user_model.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String result = "IRDC Qrcode Scanner";
  Authservice _auth = Authservice();
  String data = "";
  String name = "APP";
  int attend = 1;
  String userid = "";
  Future<void> _getdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var Name = sharedPreferences.setString('name', name);
  }

  Future getQrscanner() async {
    var camerstatus = await Permission.camera.status;
    if (camerstatus.isGranted) {
      String qrdata = await scanner.scan();
      print(qrdata);
      if (qrdata == "http://welcome") {
        await DatabaseService(uid: userid).updateattend(attend);
        inputData();
        Navigator.pop(context);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Signout()));
      }
    } else {
      var isGranted = await Permission.camera.request();
      if (isGranted.isGranted) {
        String qrdata = await scanner.scan();
        print(qrdata);
        if (qrdata == "http://welcome") {
          await DatabaseService(uid: userid).updateattend(attend);
          inputData();
          Navigator.pop(context);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Signout()));
        }
      }
    }
  }

  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    inputData();
  }

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
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 40.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 80.0.w,
                ),
                Container(
                  height: 300.0.h,
                  width: 300.0.w,
                  child: Image(
                    image: AssetImage('assets/qrcode(2).jpg'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20.0.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 65.0.w,
                ),
                SizedBox(
                  height: 200.h,
                  child: Text(
                    'Scan qrcode to attend',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0.sp,
                      color: Colors.blue,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 30.0.h,
            ),
            Row(
              children: [
                SizedBox(
                  width: 45.0.w,
                ),
                Container(
                  width: 400.0.w,
                  height: 50.0.h,
                  child: OutlineButton(
                      onPressed: () async {
                        getQrscanner();
                        _getdata();

                        // ignore: unrelated_type_equality_checks
                      },
                      child: Text(
                        'scan',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 20.0.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(30.r)),
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

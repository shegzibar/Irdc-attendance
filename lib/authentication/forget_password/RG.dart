import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irdc_attendance/Services/auth.dart';
import 'package:irdc_attendance/authentication/loginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class received extends StatefulWidget {
  const received({Key key}) : super(key: key);

  @override
  _receivedState createState() => _receivedState();
}

class _receivedState extends State<received> {
  Authservice _auth = Authservice();
  String email;
  Future<void> _getdata() async {
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    email = sharedPreferences.getString('email');
    setState(() {
      email;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: <Widget>[
            SizedBox(height: 0.2.sh),
            Image(
              image: AssetImage('assets/RG.jpeg'),
              width: 0.4.sw,
            ),
            SizedBox(height: 0.06.sh),
            Text(
              'Email has been sent',
              style: TextStyle(
                fontSize: 25.sp,
                letterSpacing: 0.5,
              ),
            ),
            Text(
              '\n Please check your inbox and'
              '\n \t \t \t follow the instructions',
              style: TextStyle(
                fontFamily: 'montserrat',
                fontSize: 20.sp,
              ),
            ),
            Padding(padding: EdgeInsets.only(top: 50.h)),
            SizedBox(
              height: 0.07.sh,
              width: 0.73.sw,
              child: ElevatedButton(
                child: Text(
                  'Back To Login Page',
                  style: TextStyle(
                    letterSpacing: 0.7.sp,
                    fontSize: 19.sp,
                  ),
                ),
                style: ElevatedButton.styleFrom(primary: Colors.indigo[900]),

                //-------------------- Login Page ----------------
                onPressed: () {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => Login_page()),
                      (Route<dynamic> route) => false);
                },
              ),
            ),
            Row(
              children: <Widget>[
                SizedBox(
                  width: 80.w,
                ),
                Text(
                  "\n Didn't get an email?",
                  style: TextStyle(
                    fontSize: 19.5.sp,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 27.sp, top: 20.sp),
                  child: TextButton(
                    child: Text(
                      'Resend',
                      style: TextStyle(
                        fontSize: 20.sp,
                      ),
                    ),

                    //------------------ Resend email --------------
                    onPressed: () {
                      dynamic result = _auth.passwordreset(email);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

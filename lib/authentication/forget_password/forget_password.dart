import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irdc_attendance/Services/auth.dart';
import 'package:irdc_attendance/authentication/forget_password/RG.dart';
import 'package:shared_preferences/shared_preferences.dart';

class forgetpass extends StatefulWidget {
  const forgetpass({Key key}) : super(key: key);

  @override
  _forgetpassState createState() => _forgetpassState();
}

class _forgetpassState extends State<forgetpass> {
  final _formKey = GlobalKey<FormState>();
  Authservice _auth = Authservice();
  String email = "";
  String error = "";
  Future<void> _getdata() async {
    
    final SharedPreferences sharedPreferences =
        await SharedPreferences.getInstance();
    var email1 = sharedPreferences.setString('email', email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[100],
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 50.sp, top: 90.sp),
              child: Column(
                children: <Widget>[
                  Text(
                    'Forgot your Password?\n',
                    style: TextStyle(
                      letterSpacing: 0.5.sp,
                      fontFamily: 'montserrat',
                      fontSize: 25.sp,
                    ),
                  ),

                  Text(
                    '\t \tEnter your registered email below\n'
                    'to receive password reset instruction',
                    style: TextStyle(
                      fontFamily: 'montserrat',
                      fontSize: 20.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Image(
                    image: AssetImage('assets/SG.jpeg'),
                    width: 0.45.sw,
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 15.sp, top: 70.sp),
                    child: SizedBox(
                      height: 60.h,
                      width: 350.w,
                      child: Container(
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            onChanged: (val) {
                              email = val;
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                fontSize: 20.sp,
                                color: Colors.black87,
                              ),
                              border: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white)),
                              filled: true,
                            ),
                            validator: (value) {
                              if (value.isEmpty) {
                                return "* Required";
                              } else
                                return null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Text(error),
                  //Next Button
                  Padding(
                    padding: EdgeInsets.only(left: 280.sp, top: 70.sp),
                    child: TextButton(
                      child: Text(
                        'Next >',
                        style: TextStyle(
                          fontFamily: 'montserrat',
                          fontSize: 25.sp,
                        ),
                      ),

                      //-----------Check register Email + Next Page --------
                      onPressed: () {
                        if (_formKey.currentState.validate()) {
                          dynamic result = _auth.passwordreset(email);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => received(),
                              ));
                          if (result == null) {
                            setState(() {
                              error = "Something went wrong please try again ";
                            });
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

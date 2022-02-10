import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irdc_attendance/Services/auth.dart';
import 'forget_password/forget_password.dart';

class Login_page extends StatefulWidget {
  final Function toggleview;
  const Login_page({Key key, this.toggleview}) : super(key: key);

  @override
  _Login_pageState createState() => _Login_pageState();
}

class _Login_pageState extends State<Login_page> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  bool valuefirst = false;
  bool valuesecond = false;
  bool _Pass = true;
  String email = "";
  String password = "";
  String error = "";
  Authservice _auth = Authservice();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          SizedBox(height: 40.h),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image(
                image: AssetImage('assets/irdc-logo.png'),
                width: 250.w,
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Container(
            child: Padding(
              padding: EdgeInsets.only(left: 60.sp),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(height: 40.h),

                    Padding(
                      padding: EdgeInsets.fromLTRB(6.sp, 0, 70.sp, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 20.0),
                                  prefixIcon: Icon(
                                    Icons.person_outline_rounded,
                                    color: Colors.blue,
                                  ),
                                  hintText: 'Enter your email',
                                  hintStyle: TextStyle(
                                    fontSize: 17.4.sp,
                                    letterSpacing: 1,
                                  ),
                                  labelText: 'email',
                                  labelStyle: TextStyle(
                                    fontSize: 23.sp,
                                    color: Colors.black87,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(),
                                  filled: true,
                                ),
                                onChanged: (val) {
                                  email = val;
                                },
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "please type your email";
                                  } else
                                    return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 40.h,
                            ),
                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 20.0, horizontal: 20.0),
                                  hintText: 'Enter password',
                                  hintStyle: TextStyle(
                                    fontSize: 17.sp,
                                    letterSpacing: 1,
                                  ),
                                  alignLabelWithHint: true,
                                  labelText: 'Password\n',
                                  labelStyle: TextStyle(
                                    fontSize: 23.sp,
                                    color: Colors.black87,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(),
                                  filled: true,

                                  //Display Password Button
                                  prefixIcon: Icon(
                                    Icons.lock_open,
                                    color: Colors.blue,
                                  ),
                                  suffixIcon: IconButton(
                                    icon: Icon(_Pass
                                        ? Icons.remove_red_eye_outlined
                                        : Icons.visibility_off),
                                    onPressed: () {
                                      setState(() {
                                        _Pass = !_Pass;
                                      });
                                    },
                                    iconSize: 30.sp,
                                  ),
                                ),
                                onChanged: (val) {
                                  password = val;
                                },
                                obscureText: _Pass,
                                validator: (value) {
                                  if (value.length < 8) {
                                    return "your password should be 8 digit long  ";
                                  } else
                                    return null;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // --------Save data option--------
                    Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Checkbox(
                              value: this.valuefirst,
                              onChanged: (bool value) {
                                setState(() {
                                  this.valuefirst = value;
                                });
                              }),
                          Text('\nRemember me',
                              style: TextStyle(
                                fontSize: 17.5.sp,
                                color: Colors.grey[700],
                              )),

                          //--------Reset Password option-------
                          Padding(
                            padding: EdgeInsets.fromLTRB(28.sp, 20.sp, 0, 0),
                            child: TextButton(
                              onPressed: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => forgetpass(),
                                    ));
                              },
                              child: Text('Forgot Password?',
                                  style: TextStyle(
                                    fontSize: 17.sp,
                                    color: Colors.blue,
                                  )),
                            ),
                          )
                        ]),

                    //Login Button
                    SizedBox(height: 30.h),
                    Padding(
                      padding: EdgeInsets.only(left: 11.sp),
                      child: SizedBox(
                        width: 0.7.sw,
                        height: 0.07.sh,
                        child: ElevatedButton(
                          child: Text(' Log in ',
                              style: TextStyle(
                                letterSpacing: 1.5,
                                fontSize: 17.sp,
                                color: Colors.white,
                              )),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.indigo[900],
                          ),
                          //-------Switch to Next Page 'Main'------
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              setState(() {
                                loading = true;
                              });
                              dynamic result = await _auth
                                  .signinwithemailandpassword(email, password);

                              if (result == null) {
                                setState(() {
                                  error =
                                      "Something went wrong please try again ";
                                  loading = false;
                                });
                              }
                            }
                          },
                        ),
                      ),
                    ),

                    //New account option
                    SizedBox(height: 25.sp),
                    Row(
                      children: <Widget>[
                        Text(
                          "\t Don't have account?",
                          style: TextStyle(
                              fontSize: 18.sp, color: Colors.grey[700]),
                        ),
                        TextButton(
                          child: Text(
                            'Create a new account',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.blue[500],
                            ),
                          ),
                          //---------Switch to Signup--------
                          onPressed: () {
                            widget.toggleview();
                          },
                        ),
                      ],
                    ),
                  ]),
            ),
          ),
          Text(
            error,
            style: TextStyle(color: Colors.red),
          ),
        ]),
      ),
      backgroundColor: Colors.grey[100],
    );
  }
}

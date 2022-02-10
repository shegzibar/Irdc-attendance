import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:irdc_attendance/Services/auth.dart';

class register extends StatefulWidget {
  final Function toggleview;
  const register({Key key, this.toggleview}) : super(key: key);

  @override
  _registerState createState() => _registerState();
}

class _registerState extends State<register> {
  bool loading = false;
  final _formKey = GlobalKey<FormState>();
  bool _pass = true;
  String username = "";
  String email = "";
  String password = "";
  String check = "";
  Authservice _auth = Authservice();
  String error = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned(
            top: 30.sp,
            left: 13.sp,
            child: IconButton(
              icon: Icon(Icons.arrow_back),

              //---------Previous Page----------
              onPressed: () {
                widget.toggleview();
              },
            ),
          ),
          Positioned(
            right: 35.sp,
            top: 75.sp,
            child: Container(
              height: 0.85.sh,
              width: 0.8.sw,
              decoration: BoxDecoration(
                color: Color(0xFF329D9C),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          Positioned(
            right: 75.sp,
            top: 105.sp,
            child: Container(
              child: Center(
                child: Column(
                  children: <Widget>[
                    Text(
                      '\n \n Create Account',
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                        color: Colors.lime[900],
                        fontFamily: 'montserrat',
                        shadows: <Shadow>[
                          Shadow(
                            offset: Offset(1.0.sp, 2.0.sp),
                            blurRadius: 3.0.sp,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8.h,
                    ),
                    Text(
                      ' __ Sign Up __',
                      style: TextStyle(
                        fontSize: 17.sp,
                        fontFamily: 'montserrat',
                        color: Colors.grey[700],
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(30, 25, 25, 0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            Container(
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    username = val;
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  prefixIcon: Icon(
                                    Icons.person_outline_rounded,
                                    color: Colors.blue,
                                  ),
                                  hintText: 'Enter your name',
                                  hintStyle: TextStyle(
                                    fontSize: 13.sp,
                                    letterSpacing: 1,
                                  ),
                                  labelText: 'Name',
                                  labelStyle: TextStyle(
                                    fontSize: 19.sp,
                                    color: Colors.black87,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  filled: true,
                                ),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return "please enter username";
                                  } else
                                    return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 27.h,
                            ),
                            Container(
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    email = val;
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  prefixIcon: Icon(
                                    Icons.alternate_email,
                                    color: Colors.blue,
                                  ),
                                  hintText: 'Enter your email',
                                  hintStyle: TextStyle(
                                    fontSize: 13.sp,
                                    letterSpacing: 1,
                                  ),
                                  labelText: 'Email',
                                  labelStyle: TextStyle(
                                    fontSize: 19.sp,
                                    color: Colors.black87,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.white),
                                  ),
                                  filled: true,
                                ),
                                //----------Check isEmpty----------
                                validator: (val) {
                                  if (val.isEmpty) {
                                    return "please enter your email";
                                  } else
                                    return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 27.h,
                            ),
                            Container(
                              child: TextFormField(
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  hintText: 'Enter the password\n',
                                  hintStyle: TextStyle(
                                    fontSize: 13.sp,
                                    letterSpacing: 1,
                                  ),
                                  alignLabelWithHint: true,
                                  labelText: 'Password\n',
                                  labelStyle: TextStyle(
                                    fontSize: 19.sp,
                                    color: Colors.black87,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(),
                                  filled: true,
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.blue,
                                  ),
                                ),
                                onChanged: (val) {
                                  setState(() {
                                    check = val;
                                  });
                                },
                                //----------Check isEmpty----------
                                obscureText: _pass,
                                validator: (val) {
                                  if (val.length < 8) {
                                    return "your password should be 8 digit long ";
                                  } else
                                    return null;
                                },
                              ),
                            ),
                            SizedBox(
                              height: 27.h,
                            ),
                            Container(
                              child: TextFormField(
                                onChanged: (val) {
                                  setState(() {
                                    password = val;
                                  });
                                },
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 10.0, horizontal: 10.0),
                                  hintText: 'Re-enter password\n',
                                  hintStyle: TextStyle(
                                    fontSize: 13.sp,
                                    letterSpacing: 1,
                                  ),
                                  alignLabelWithHint: true,
                                  labelText: 'Confirm Password\n',
                                  labelStyle: TextStyle(
                                    fontSize: 19.sp,
                                    color: Colors.black87,
                                  ),
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.always,
                                  border: OutlineInputBorder(),
                                  filled: true,

                                  //Display Password Button
                                  prefixIcon: Icon(
                                    Icons.lock_outline,
                                    color: Colors.blue,
                                  ),
                                ),
                                //----------Check isEmpty----------
                                obscureText: _pass,
                                validator: (val) {
                                  if (val.length < 6 || val != check) {
                                    return "please reenter your password correctly ";
                                  } else
                                    return null;
                                },
                              ),
                            ),
                            SizedBox(height: 32.h),
                            Padding(
                              padding: EdgeInsets.only(left: 1),
                              child: SizedBox(
                                width: 0.7.sw,
                                height: 0.05.sh,
                                child: new ElevatedButton(
                                  child: Text(
                                    ' Sign up ',
                                    style: TextStyle(
                                      letterSpacing: 2,
                                      fontSize: 17.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.blue,
                                  ),
                                  //-------Save data and switch to the Next Page------
                                  onPressed: () async {
                                    if (_formKey.currentState.validate()) {
                                      setState(() {
                                        loading = true;
                                      });
                                      dynamic result = await _auth
                                          .registerwithemailandpassword(
                                              email, password, username);
                                      if (result == null) {
                                        setState(() {
                                          error =
                                              "please supply a valide email";
                                          loading = false;
                                        });
                                      }
                                      if (result != null) {
                                        await FirebaseAuth.instance.currentUser
                                            .updateProfile(
                                                displayName: username);
                                        print(result);
                                      }
                                    }
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text(
                          "\t \t \t Have an account already?",
                          style: TextStyle(
                              fontSize: 18.sp, color: Colors.grey[700]),
                        ),
                        TextButton(
                          child: Text(
                            'Login',
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: Colors.blue[500],
                            ),
                          ),
                          //--------Switch to Login Page--------
                          onPressed: () {
                            widget.toggleview();
                          },
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Text(
                      error,
                      style: TextStyle(color: Colors.red),
                    )
                  ],
                ),
              ),
              height: 0.85.sh,
              width: 0.8.sw,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 5.sp,
                      blurRadius: 7.sp,
                    ),
                  ]),
            ),
          ),
        ],
      ),
      backgroundColor: Colors.grey[200],
    );
  }
}

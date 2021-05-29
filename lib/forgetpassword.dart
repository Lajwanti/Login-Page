import 'package:flutter/material.dart';
import 'dart:math' as math;
import 'package:login_page1/main.dart';



class forgotpass extends StatefulWidget {
  @override
  forgotpassState createState() => forgotpassState();
}

class forgotpassState extends State<forgotpass>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pases = TextEditingController();
  TextEditingController cnfmpass = TextEditingController();

  Widget inputemail(String hint) {
    return TextFormField(
      controller: email,
      // autovalidate: true,
      validator: (String value){
        if(value.isEmpty){
          return 'Ente your email';
        }
        return null;
      },
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFFACACAC), fontSize: 14),
          contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 38),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFF1F1F1)),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC7C7C7)),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          )),
    );
  }
  Widget inputpass(String hint, {bool isPass = false}) {
    return TextFormField(
      controller: pases,
      validator: (String value){
        if (value.isEmpty) {
          return "* Required";
        }
        else if (value.length < 6) {
          return "Password should be atleast 6 characters";
        } else if (value.length > 15) {
          return "Password should not be greater than 15 characters";
        }
        else
          return null;
      },
      obscureText: isPass,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFFACACAC), fontSize: 14),
          contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 38),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFF1F1F1)),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC7C7C7)),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          )),
    );
  }
  Widget inputconfirmpass(String hint, {bool isPass = false}) {
    return TextFormField(
      controller: cnfmpass,
      validator: (String value){
        if (value.isEmpty) {
          return "* Required";
        }
        else if (value.length < 6) {
          return "Password should be atleast 6 characters";
        } else if (value.length > 15) {
          return "Password should not be greater than 15 characters";
        }
        else
          return null;
      },
      obscureText: isPass,
      decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Color(0xFFACACAC), fontSize: 14),
          contentPadding: EdgeInsets.only(top: 20, bottom: 20, left: 38),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFF1F1F1)),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xFFC7C7C7)),
            borderRadius: BorderRadius.all(Radius.circular(30.0)),
          )),
    );
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      value: 0.0,
      duration: Duration(seconds: 25),
      upperBound: 1,
      lowerBound: -1,
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // if (_controller.value == 0.8) _controller.reverse();
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      body: Form(
        key: formkey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget child) {
                        return ClipPath(
                          clipper: DrawClip(_controller.value),
                          child: Container(
                            height: size.height * 0.5,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  // colors: [Color(0xFFE0647B), Color(0xFFFCDD89)]),
                                  colors: [ Color(0xFFF000066),Color(0xFF006666)]),
                            ),
                          ),
                        );
                      },
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Text(
                        'Update Page',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 46,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      'With Flutter and Dart',
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                ),
              ),
              Text(
                'Forgot Password',
                style: TextStyle(fontSize: 16),
              ),
              Container(
                width: size.width * 0.8,
                margin: EdgeInsets.only(top: 18),
                child: inputemail('Email'),
              ),
              Container(
                width: size.width * 0.8,
                margin: EdgeInsets.only(top: 18),
                child: inputpass('New Password', isPass: true),
              ),
              Container(
                width: size.width * 0.8,
                margin: EdgeInsets.only(top: 18),
                child: inputconfirmpass('Confirm New Password', isPass: true),
              ),
              Container(
                margin: EdgeInsets.only(top: 18),
                child: GestureDetector(
                  onTap: () {  if ( formkey.currentState.validate()) {
                  
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => MyHomePage()));
                  }
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class DrawClip extends CustomClipper<Path> {
  double move = 0;
  double slice = math.pi;
  DrawClip(this.move);
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height * 0.8);
    double xCenter =
        size.width * 0.5 + (size.width * 0.6 + 1) * math.sin(move * slice);
    double yCenter = size.height * 0.8 + 69 * math.cos(move * slice);
    path.quadraticBezierTo(xCenter, yCenter, size.width, size.height * 0.8);

    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true;
  }
}
import 'package:flutter/material.dart';
import 'package:login_page1/ssignup.dart';
import 'dart:math' as math;
import 'forgetpassword.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  final formkey = GlobalKey<FormState>();
  TextEditingController email = TextEditingController();
  TextEditingController pases = TextEditingController();

  
  Widget inputemail(String hint) {
    return TextFormField(
      controller: email,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your email';
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
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter your password';
        }
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

      backgroundColor: Colors.white,
      body:Form(
       key : formkey,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                child: Stack(
                  alignment: Alignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.start,
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
                                  colors: [ Color(0xFFF000066),Color(0xFF006666)]),
                            ),
                          ),
                        );
                      },
                    ),

                    Container(
                      padding: EdgeInsets.only(bottom: 60),
                      child: Text(
                        'LOGIN PAGE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 40,
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
                'Sign in to continue',
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
                child: inputpass('Password', isPass: true),
              ),
              Container(
                margin: EdgeInsets.only(top: 18),
                child:GestureDetector(
                  onTap: () {

                    if (formkey.currentState.validate()) {
                    
                      email.text = "";
                      pases.text = "";
                    }


                  },
                  child: Text('Login', style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
              ),



              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      margin: EdgeInsets.only(left: 10 ,top: 60),

                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>forgotpass()));
                          },
                          child: Text("Forgot Password?",style: TextStyle(
                              color: Color(0xFFACACAC), fontSize: 17),),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                        margin: EdgeInsets.only(right: 10,top: 60),
                        child: GestureDetector(
                          onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>signup()));
                        },
                          child: Text("Register",style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),),
                        )),
                  ),


                ],
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
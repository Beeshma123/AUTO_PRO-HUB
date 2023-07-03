import 'dart:async';


import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'login.dart';


class Splash extends StatefulWidget {
  const Splash({super.key});
  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(
        Duration(seconds: 7),
            () => Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Login1())));
  }

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child:SingleChildScrollView(
          child:Column(
              children:[
                Image.asset('assets/auto.jpeg'),
                Text("MINTO",
                  style: TextStyle(color: Colors.black87,fontSize: 30,fontStyle: FontStyle.italic,fontWeight: FontWeight.bold),)
              ]
          ),

        ),
      ),
    );
  }
}
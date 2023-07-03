import 'dart:convert';

import 'package:auto_pro/login.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';


import 'constants.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});
  @override
  State<SignUp> createState() => _SignUpState();
}
class _SignUpState extends State<SignUp> {
  var name = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var mobile = TextEditingController();

  Future<void> addData() async {
    var data = {
      "name": name.text,
      "email": email.text,
      "password": password.text,
      "mobile": mobile.text,


    };
    var response = await post(Uri.parse('${Con.url}register.php'), body: data);
    print(response.body);
    var res = jsonDecode(response.body);
    if (res['message'] == 'Added') {
      Fluttertoast.showToast(msg: 'Registration Successfull');
      Navigator.push(context, MaterialPageRoute(
        builder: (context) {
          return Login1();
        },
      ));
    } else {
      Fluttertoast.showToast(msg: 'Something went wrong');
    }
  }
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child:
            Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

              Text(
                'SignUp',
                style: TextStyle(
                    color: Color.fromARGB(255, 0, 136, 240),
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  controller: name,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    hintText: 'Enter your name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 5, 42, 208)),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Email Id';
                    }
                    return null;
                  },
                  controller: email,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    hintText: 'Enter your EmailID',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 5, 42, 208)),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  keyboardType: TextInputType.text,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 5, 42, 208)),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },
                  controller: password,
                  decoration: InputDecoration(
                    labelText: 'mobile',
                    hintText: 'Enter your mobile number',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 1, color: Color.fromARGB(255, 5, 42, 208)),
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                  obscureText: true,
                  keyboardType: TextInputType.text,
                ),
              ),
              SizedBox(height: 15),
              InkWell(
                onTap: () {
                  if (_formKey.currentState!.validate()) {
                    addData();
                  }
                },
                child: Container(
                    height: 50,
                    width: 320,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: Color.fromARGB(149, 0, 136, 240),
                    ),
                    child: Center(
                      child: Text(
                        'Sign In',
                        style: TextStyle(
                            fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    )),
              )
            ]),
          ),
        ),
      ),
    );
  }
}

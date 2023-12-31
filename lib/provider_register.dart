import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'constants.dart';
import 'login.dart';

class Provider_reg extends StatefulWidget {
  const Provider_reg({super.key});

  @override
  State<Provider_reg> createState() => _Provider_regState();
}

class _Provider_regState extends State<Provider_reg> {
  final formkey = GlobalKey< FormState>();
   String dropdownvalue = 'Kozhikode';
  var items = [
    'Kozhikode',
    'Kannur',
    'Ernakulam',
    'Kollam',
    'Palakkad',
    'Thiruvananthapuram',
    'Wayanad',
    'Alappuzha',
    'Idukki',
    'Kasaragod',
    'Kottayam',
    'Malappuram',
    'Pathanamthitta',
    'Thrissur'
  ];

  var first = TextEditingController();
  var last= TextEditingController();
  var street = TextEditingController();
  var district = TextEditingController();
  var phn = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();

  Future<void> addData() async {
    var data = {
      "first":first.text,
      "last":last.text,
      "street":street.text,
      "district":dropdownvalue,
      "phn":phn.text,
      "email":email.text,
      "password":password.text,

    };
    var res =await post(Uri.parse('${Con.url}provider_reg.php'),body: data);
    print(res.body);
        Fluttertoast.showToast(msg: 'Successfully registered...');

     Navigator.push(context, MaterialPageRoute(builder: (context) {
      return Login1();

    },));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Center(child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Text('PROVIDER REGISTRATION',style: TextStyle(color: Colors.purple,fontWeight: FontWeight.bold,fontSize: 15),),
          )),
         
           Form(
             key: formkey,
             child: Column(
               children: [
                 Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'This field is required';
                      }
                      // Validate that the input doesn't contain numbers or special characters
                      final pattern = r'^[a-zA-Z\s]+$';
                      final regExp = RegExp(pattern);
                      if (!regExp.hasMatch(value)) {
                        return 'Only alphabets and spaces are allowed';
                      }
                      return null;
                    },
                    controller: first,
                    decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Firstname')),
                  ),
          ),

           Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                // Validate that the input doesn't contain numbers or special characters
                final pattern = r'^[a-zA-Z\s]+$';
                final regExp = RegExp(pattern);
                if (!regExp.hasMatch(value)) {
                  return 'Only alphabets and spaces are allowed';
                }
                return null;
              },
              controller: last,
              decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Lastname')),
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: street,
              decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Street')),
            ),
          ),
            Padding(
            padding: const EdgeInsets.all(18.0),
            child: DropdownButtonFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Select your district';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Your District'),
              // Initial Value
              value: dropdownvalue,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue = newValue!;
                });
              },
            ),
          ),
           Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Phone number is required";
                }
                if (value.length != 10) {
                  return "Please enter a valid 10-digit phone number";
                }
                return null;
              },
              controller: phn,
              decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Phone number')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Email is required';
                } if (!RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$").hasMatch(value)) {
                  return "Please enter a valid email address";
                }
                return null;
              },
              controller: email,
              decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Email')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: password,
              decoration: InputDecoration(border: OutlineInputBorder(),  label: Text('Password')),
              obscureText: true,
            ),
          ),
               ],
             ),
           ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: ElevatedButton(onPressed: () {
              if (formkey.currentState!.validate()) {
                addData();
              };
            },
                child: Text('Register')),
          )
        
        ],
      ),
    );
  }
}
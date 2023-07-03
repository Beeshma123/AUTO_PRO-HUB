import 'dart:io';

import 'package:auto_pro/rcadd.dart';
import 'package:auto_pro/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class AddRental extends StatefulWidget {
  const AddRental({super.key});

  @override
  State<AddRental> createState() => _AddRentalState();
}

class _AddRentalState extends State<AddRental> {
  final formkey = GlobalKey< FormState>();
  XFile? pickedFile;
  File? image;

  File? pickedImage;
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
  String dropdownvalue1= 'Manual';
  var items1=['Manual','Automatic'];

  String dropdownvalue2= 'car';
  var items2=['car','bike'];

  String dropdownvalue3= 'petrol';
  var items3=['petrol','diesel','cng','electric'];

  var name = TextEditingController();
  var color = TextEditingController();
  var price = TextEditingController();
  var seat = TextEditingController();

 

  addRental(BuildContext context) async {

    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    if (pickedImage != null) {
      final data = await Services.postWithIamge(
          endPoint: 'add_rental.php',
          params: {
            'id': sp,
            "name": name.text,
            "type":dropdownvalue2,
            "gear": dropdownvalue1,
            "color": color.text,
            "fuel": dropdownvalue3,
            "price": price.text,
            "district": dropdownvalue,
            "seat": seat.text
          },
          image: pickedImage!,
          imageParameter: 'photo');

      if ((data as Map)['result'] == 'done') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Rcadd(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: 'Vehicle Added...');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Rcadd();
          },
        ));
      }
    } else {
      Fluttertoast.showToast(msg: 'Pick image ');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(22.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Upload vehicle image',
                  style: TextStyle(fontSize: 15),
                ),
                FloatingActionButton(
                  onPressed: () async {
                    File? temp = await Services.pickImage(context);
                    setState(() {
                      pickedImage = temp;
                    });
                    print(pickedImage!.path);
                  },
                  child: Icon(Icons.camera_alt),
                ),
                // image == null ? Text('no image') : Image.file(image!),
              ],
            ),
          ),
          Form(key:formkey ,
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
                    controller: name,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), label: Text('Name')),
                  ),
                ),

          Padding(
            padding: const EdgeInsets.all(25.0),
            child: DropdownButtonFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Select type of Vehicle';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Type of Vehicle'),
              // Initial Value
              value: dropdownvalue2,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items2.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue2 = newValue!;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: seat,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Seats')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: DropdownButtonFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Select type of gear';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'Type of gear'),
              // Initial Value
              value: dropdownvalue1,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items1.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue1 = newValue!;
                });
              },
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
              controller: color,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text('Color of vehicle')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text(' Price')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: DropdownButtonFormField(
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please Select fuel type';
                }
                return null;
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), labelText: 'fuel type'),
              // Initial Value
              value: dropdownvalue3,

              // Down Arrow Icon
              icon: const Icon(Icons.keyboard_arrow_down),

              // Array list of items
              items: items3.map((String items) {
                return DropdownMenuItem(
                  value: items,
                  child: Text(items),
                );
              }).toList(),
              // After selecting the desired option,it will
              // change button value to selected value
              onChanged: (String? newValue) {
                setState(() {
                  dropdownvalue3 = newValue!;
                });
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(25.0),
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
              ],
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(18.0),
          //   child: TextFormField(
          //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text('RC')),
          //   ),
          // ),
          // Padding(
          //   padding: const EdgeInsets.all(18.0),
          //   child: TextFormField(
          //     decoration: InputDecoration(border: OutlineInputBorder(),label: Text('Insurance')),
          //   ),
          // ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: InkWell(
              onTap: () {
                addRental(context);
              },
              child: Container(
                height: 50,
                child: Center(child: Text("ADD")),
                decoration: BoxDecoration(color: Colors.purple),
              ),
            ),
          )
        ],
      ),
    );
  }
}

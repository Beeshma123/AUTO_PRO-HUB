import 'dart:io';

import 'package:auto_pro/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'addrc-truck.dart';

class Addtruck extends StatefulWidget {
  const Addtruck({super.key});

  @override
  State<Addtruck> createState() => _AddtruckState();
}

class _AddtruckState extends State<Addtruck> {
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

  String dropdownvalue2= 'truck';
  var items2=['truck'];

  var name = TextEditingController();
  var gear = TextEditingController();
  var color = TextEditingController();
  var fuel = TextEditingController();
  var price = TextEditingController();
  var capacity = TextEditingController();

  addTransport(BuildContext context) async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    if (pickedImage != null) {
      print('object');
      final data = await Services.postWithIamge(
          endPoint: 'add_truck.php',
          params: {
            'id': sp,
            "name": name.text,
            "price": price.text,
            "district": dropdownvalue,
            "capacity": capacity.text
          },
          image: pickedImage!,
          imageParameter: 'photo');

      if ((data as Map)['result'] == 'done') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Rcadd_truck(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: 'Truck Added...');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Rcadd_truck();
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
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: name,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Name')),
            ),
          ),
          // Padding(
          //   padding: const EdgeInsets.all(25.0),
          //   child: DropdownButtonFormField(
          //     validator: (value) {
          //       if (value == null || value.isEmpty) {
          //         return 'Please Select type of Vehicle';
          //       }
          //       return null;
          //     },
          //     decoration: const InputDecoration(
          //         border: OutlineInputBorder(), labelText: 'Type of Vehicle'),
          //     // Initial Value
          //     value: dropdownvalue2,
          //
          //     // Down Arrow Icon
          //     icon: const Icon(Icons.keyboard_arrow_down),
          //
          //     // Array list of items
          //     items: items2.map((String items) {
          //       return DropdownMenuItem(
          //         value: items,
          //         child: Text(items),
          //       );
          //     }).toList(),
          //     // After selecting the desired option,it will
          //     // change button value to selected value
          //     onChanged: (String? newValue) {
          //       setState(() {
          //         dropdownvalue2 = newValue!;
          //       });
          //     },
          //   ),
          // ),
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: TextFormField(
              controller: capacity,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  border: OutlineInputBorder(), label: Text('Capacity')),
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
                addTransport(context);
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
import 'dart:io';

import 'package:auto_pro/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'inadd_t.dart';
import 'inadd_truck.dart';

class Rcadd_truck extends StatefulWidget {
  const Rcadd_truck({super.key});

  @override
  State<Rcadd_truck> createState() => _Rcadd_truckState();
}

class _Rcadd_truckState extends State<Rcadd_truck> {
  XFile? pickedFile;
  File? image;

  File? pickedImage;


  addRc(BuildContext context) async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    if (pickedImage != null) {
      final data = await Services.postWithIamge(
          endPoint: 'add-rc_truck.php',
          params: {
            'id': sp,
          },
          image: pickedImage!,
          imageParameter: 'photo');

      if ((data as Map)['result'] == 'done') {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Inadd_t(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: 'RC Uploaded...');
        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Inadd_truck();
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
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Upload RC',
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
            ElevatedButton(onPressed: () {
              addRc(context);
            }, child: Text('Next'))
          ]),
    );
  }
}
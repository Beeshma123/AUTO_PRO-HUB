import 'dart:io';

import 'package:auto_pro/provider_navigation.dart';
import 'package:auto_pro/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';


class Inadd_truck extends StatefulWidget {
  const Inadd_truck({super.key});

  @override
  State<Inadd_truck> createState() => _Inadd_truckState();
}

class _Inadd_truckState extends State<Inadd_truck> {
  XFile? pickedFile;
  File? image;

  File? pickedImage;

  addIn(BuildContext context) async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    if (pickedImage != null) {
      final data = await Services.postWithIamge(
          endPoint: 'inadd_truck.php',
          params: {
            'id': sp,
          },
          image: pickedImage!,
          imageParameter: 'photo');

      if ((data as Map)['result'] == 'done') {
        Fluttertoast.showToast(msg: 'Insurance Uploaded...');
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => Pro_nav(),
          ),
        );
      } else {

        Navigator.push(context, MaterialPageRoute(
          builder: (context) {
            return Pro_nav();
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
                    'Upload Insurance card',
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
              Fluttertoast.showToast(msg: 'Vehicle documents added...');
              addIn(context);
            }, child: Text('Next'))
          ]),

    );
  }
}
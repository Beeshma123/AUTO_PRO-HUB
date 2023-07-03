
import 'dart:convert';

import 'package:auto_pro/rentaltype.dart';
import 'package:auto_pro/user_navigation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'bike-view.dart';
import 'constants.dart';

class Rental_type1 extends StatefulWidget {
  const Rental_type1({super.key});

  @override
  State<Rental_type1> createState() => _Rental_type1State();
}

class _Rental_type1State extends State<Rental_type1> {
  Future<dynamic> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('district');

    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    var data={
      "loc":sp,
    };
    var response = await post(Uri.parse('${Con.url}bikelist.php'),body: data);
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bike'),
      ),
      body: Stack(
        children: [
        FutureBuilder(
          future: getData(),
          builder: (context,snap) {
             if (!snap.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Bikeview(id:'${snap.data[index]['rental_id']}');
                  },));
                },
                child: ListTile(
                  title: Text('${snap.data[index]['name']}'),
                  subtitle: Text('${snap.data[index]['price']}'),
                ),
              );
            },);
          }
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(onPressed: () {
                   
                  },child: Icon(Icons.pedal_bike),),
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Rental_type();
                    },));
                  },child: Icon(Icons.car_repair),),
                ],
              ),
            ),
             Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  FloatingActionButton(onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return User_navigation();
                    },));
                  },child: Icon(Icons.home),),
                ],
              ),
            ),
            
          ],
        )
        ],
      )
    );
  }
}
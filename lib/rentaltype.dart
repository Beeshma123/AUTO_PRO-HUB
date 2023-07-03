import 'dart:convert';

import 'package:auto_pro/user_navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'bike.dart';
import 'carview.dart';
import 'constants.dart';
import 'home.dart';

class Rental_type extends StatefulWidget {
  const Rental_type({super.key});

  @override
  State<Rental_type> createState() => _Rental_typeState();
}

class _Rental_typeState extends State<Rental_type> {

  Future<dynamic> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('district');

    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    var data={
      "loc":sp,
    };
    var response = await post(Uri.parse('${Con.url}carlist.php'),body: data);
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Car'),
      ),
      body: Stack(
        children: [
        FutureBuilder(
          future: getData(),
          builder: (context,snap) {
            if(!snap.hasData){
              return Center(child: CircularProgressIndicator(),);
            }
             if(snap.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }
            return ListView.builder(
              itemCount: snap.data.length,
              itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Carview(id:'${snap.data[index]['rental_id']}');
                  },));
                },
                child: ListTile(
                  title: Text('${snap.data[index]['name']}'),
                  subtitle: Text('${snap.data[index]['price']}'),

                  // trailing: Text('${snap.data[0]['status']}'),
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
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return Rental_type1();
                    },));
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
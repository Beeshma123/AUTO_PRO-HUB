import 'dart:convert';

import 'package:auto_pro/view_truck.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'constants.dart';

class TruckList extends StatefulWidget {
  const TruckList({super.key});

  @override
  State<TruckList> createState() => _TruckListState();
}

class _TruckListState extends State<TruckList> {
   Future<dynamic> getData() async {
     SharedPreferences spref = await SharedPreferences.getInstance();
     var sp = spref.getString('district');

     print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
     var data={
       "loc":sp,
     };
     var response = await post(Uri.parse('${Con.url}usertruckview.php'),body:data);
     print(response.body);
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }
  @override
  Widget build(BuildContext context) {
   return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        future: getData(),
        builder: (context,snap) {
           if (!snap.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          if (snap.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: snap.data.length,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return TruckView(id :'${snap.data[index]['id']}');
                  },));
                },
                child: ListTile(
                  title: Text('${snap.data[index]['name']}'),
                  subtitle: Text('${snap.data[index]['capacity']}  '),
                  // trailing: Text('date'),
              
                          ),
              );
            },
            
          );
        }
      ),
    );
  }
}
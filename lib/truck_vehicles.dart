import 'dart:convert';

import 'package:auto_pro/view_truck.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'addtransport.dart';
import 'addtruck.dart';
import 'constants.dart';

class Truck_vehicles extends StatefulWidget {
  const Truck_vehicles({super.key});

  @override
  State<Truck_vehicles> createState() => _Truck_vehiclesState();
}

class _Truck_vehiclesState extends State<Truck_vehicles> {
  Future<dynamic> getData() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    var data = {"id": sp};
    var response = await post(Uri.parse('${Con.url}trucklist.php'), body: data);
    print(response.body);
    var res = jsonDecode(response.body);

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snap) {
            if (!snap.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            if (snap.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            return Stack(
              children: [
                ListView.separated(
                    separatorBuilder: (context, index) {
                      return Divider();
                    },
                    itemCount: snap.data.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                            builder: (context) {
                              return TruckView(
                                  id: '${snap.data[index]['id']}');
                            },
                          ));
                        },
                        child: ListTile(
                          leading: Icon(
                            Icons.emoji_transportation,
                            color: Colors.black,
                          ),
                          title: Text('${snap.data[index]['name']}'),
                          subtitle: Text('${snap.data[index]['price']}'),
                          // trailing: Text('${snap.data[index]['date']}'),
                        ),
                      );
                    }),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FloatingActionButton(
                            onPressed: () {
                              Navigator.push(context, MaterialPageRoute(
                                builder: (context) {
                                  return Addtruck();
                                },
                              ));
                            },
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            );
          }),
    );
  }
}

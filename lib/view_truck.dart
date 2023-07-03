import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

import 'package:shared_preferences/shared_preferences.dart';


import 'autolist.dart';
import 'buslist.dart';
import 'constants.dart';
import 'list_truck.dart';

class TruckView extends StatefulWidget {
  TruckView({super.key, required this.id});
  String id;

  @override
  State<TruckView> createState() => _TruckViewState();
}

class _TruckViewState extends State<TruckView> {
  Future<dynamic> getData() async {
    var data = {
      "id":widget.id,
    };
    var res=await post(Uri.parse('${Con.url}bus-view.php'),body: data);
    print(res.body);
    var result = jsonDecode(res.body);
    return result;


  }

  Future<TruckList> addBook() async {
    SharedPreferences spref = await SharedPreferences.getInstance();
    var sp = spref.getString('log_id');
    print('>>>>>>>>>>>>>>>>>>>>>>>>>>>>>$sp');
    var data={
      "id":sp,
      "transport_id":widget.id,
    };
    var rs = await post(Uri.parse('${Con.url}transport-booking.php'),body: data);
    print(rs.body);
    var ras = jsonDecode(rs.body);
    // Lottie.asset('assets/image/book.json');
    Fluttertoast.showToast(msg: 'booked successfully...');
    return TruckList();
    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return Payment2(id:'${ras['price']}');
    // },));
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: FutureBuilder(
            future: getData(),
            builder: (context,snap) {
              if(!snap.hasData){
                return Center(child: CircularProgressIndicator(),);
              }
              if(snap.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView(children: [
                Container(
                  height: 250,
                  child: Image.network(
                      '${Con.img}${snap.data[0]['upload_photo']}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Center(
                      child: Text(
                        'Bus name',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                ),
                Center(
                  child: Text('Rs : ${snap.data[0]['price']}',
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                ),

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('location',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('${snap.data[0]['location']}'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('No of seats',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('${snap.data[0]['seat']}'),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('rc',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('View'),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('insurance',style: TextStyle(fontWeight: FontWeight.bold),),
                      Text('View'),
                    ],
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(18.0),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Text('licence',style: TextStyle(fontWeight: FontWeight.bold),),
                //       Text('View'),
                //     ],
                //   ),
                // ),
                InkWell(
                  onTap: () {
                    addBook();
                  },
                  child: Container(
                    height: 40,
                    child: Center(child: Text('Book',style: TextStyle(color: Colors.white),),),
                    decoration: BoxDecoration(color: Colors.purple),
                  ),
                )
              ]);
            }
        ),

      ),
    );
  }
}
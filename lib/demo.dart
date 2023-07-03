import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';


import 'constants.dart';

class Date extends StatefulWidget {
  Date({Key? key, required this.id}) : super(key: key);
  String id;
  @override
  State<Date> createState() => _DateState();
}

class _DateState extends State<Date> {
  late DateTime selectedDate = DateTime.now();

  // Future<dynamic> updateDate() async {
  //   var data = {
  //     "id":widget.id
  //   };
  //   var res = await post(Uri.parse('${Con.url}update_date.php'),body: data);
  //   var r = jsonDecode(res.body);
  //   return r;
  //   // Navigator.push(context, MaterialPageRoute(builder: (context) {
  //   //   return Payment(id: '${res['price']}',);
  //   // },));
  //
  // }

  Future<void> _selectDate(BuildContext context) async {


    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  bool isDateValid() {
    final currentDate = DateTime.now();
    return !selectedDate.isBefore(currentDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FutureBuilder(

            builder: (context,snap) {
              if (!snap.hasData) {
                return Center(child: CircularProgressIndicator(),);
              }
              if (snap.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator(),);
              }
              return ListView(children: [
                Container(
                  width: 100,
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30.0),
                      ),
                      labelText: "Select Date",
                      hintText: "Select Date",
                    ),
                    keyboardType: TextInputType.datetime,
                    onTap: () => _selectDate(context),
                    controller: TextEditingController(
                        text: "${selectedDate.year}-${selectedDate.month}-${selectedDate
                            .day}"),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
                  child: Container(
                    width: 100,
                    child: TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        labelText: "Last Date",
                        hintText: "Last Date",
                      ),
                      keyboardType: TextInputType.datetime,
                      onTap: () => _selectDate(context),
                      controller: TextEditingController(
                          text: "${selectedDate.year}-${selectedDate
                              .month}-${selectedDate.day}"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (isDateValid()) {
                        // updateDate();
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("Invalid Date"),
                              content: Text(
                                  "Please select a date that is not a previous date."),
                              actions: [
                                TextButton(
                                  child: Text("OK"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: Text("Pay"),
                  ),
                ),
              ],
              );
            }
        ),
      ),
    );
  }
}

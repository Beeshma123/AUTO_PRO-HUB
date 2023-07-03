import 'dart:convert';

import 'package:auto_pro/payment.dart';
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
  late DateTime selectedStartDate = DateTime.now();
  late DateTime selectedLastDate = DateTime.now();

  Future<void> _selectStartDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedStartDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedStartDate) {
      setState(() {
        selectedStartDate = pickedDate;
      });
    }
  }

  Future<void> _selectLastDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedLastDate,
      firstDate: DateTime.now(),
      lastDate: DateTime(2025),
    );
    if (pickedDate != null && pickedDate != selectedLastDate) {
      setState(() {
        selectedLastDate = pickedDate;
      });
    }
  }

  Future<dynamic> updateDate() async {
    var data = {
      "id": widget.id,
      "date": selectedStartDate.toString(),
      "last_date": selectedLastDate.toString(),
    };
    print(data);
    var res = await post(Uri.parse('${Con.url}update_date.php'), body: data);
    print(res.body);
    var r = jsonDecode(res.body);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return Payment(id: '${r['rid']}');
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: ListView(
          children: [
            Padding(
              padding:
              const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
              child: Container(
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
                  onTap: () => _selectStartDate(context),
                  controller: TextEditingController(
                    text:
                    "${selectedStartDate.year}-${selectedStartDate.month}-${selectedStartDate.day}",
                  ),
                ),
              ),
            ),
            Padding(
              padding:
              const EdgeInsets.only(left: 10.0, right: 10.0, top: 10.0),
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
                  onTap: () => _selectLastDate(context),
                  controller: TextEditingController(
                    text:
                    "${selectedLastDate.year}-${selectedLastDate.month}-${selectedLastDate.day}",
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: () {
                  updateDate();
                },
                child: Text("Pay"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

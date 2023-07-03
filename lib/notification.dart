import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:http/http.dart';

import 'constants.dart';

class Notification1 extends StatefulWidget {
  const Notification1({super.key});

  @override
  State<Notification1> createState() => _Notification1State();
}

class _Notification1State extends State<Notification1> {
  Future<dynamic> getData() async {
    var response = await get(Uri.parse('${Con.url}notification.php'));
    var res = jsonDecode(response.body);
    print(res);
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyanAccent,
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context, snap) {
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
                  return ListTile(
                    leading: Icon(
                      Icons.notifications,
                      color: Colors.black,
                    ),
                    title: Text('${snap.data[index]['title']}'),
                    subtitle: Text('${snap.data[index]['message']}'),
                    trailing: Text('${snap.data[index]['date']}'),
                  );
                });
          }),
    );
  }
}

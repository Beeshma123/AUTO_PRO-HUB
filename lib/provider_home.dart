import 'package:auto_pro/r_vehicles.dart';
import 'package:auto_pro/transport_vehicles.dart';
import 'package:auto_pro/truck_vehicles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';


class Prohome extends StatefulWidget {
  const Prohome({super.key});

  @override
  State<Prohome> createState() => _ProhomeState();
}

class _ProhomeState extends State<Prohome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return R_vehicles();
              },));
            },child: Text('Rental vehicles'),),
          ),
           Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: (){
               Navigator.push(context, MaterialPageRoute(builder: (context) {
                return T_vehicles();
              },));
            },child: Text(' Transportation vehicles'),),
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Truck_vehicles();
                },));
              },child: Text(' Truck'),),
            )
          ],
        ),
      ),
    );
  }
}
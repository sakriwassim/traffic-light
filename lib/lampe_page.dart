import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import 'lampe_module.dart';
import 'main.dart';

class LampePage extends StatefulWidget {
  const LampePage({super.key});

  @override
  State<LampePage> createState() => _LampePageState();
}

class _LampePageState extends State<LampePage> {

  final controlleraddress = TextEditingController();
  final controllerlatitude = TextEditingController();
  final controllerlongitude = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lampe Page'),
      ),
      body:ListView(
        padding: EdgeInsets.all(16),
        children: [
          TextField(
            decoration: decoration("address"),
            controller: controlleraddress,
          ),
          SizedBox(height: 20,),
          TextField(
            decoration: decoration("longitude"),
            controller: controllerlongitude,
          ),
          SizedBox(height: 20,),
          TextField(
            decoration: decoration("latitude"),
            controller: controllerlatitude,
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: () {
            createLampe(
                address: controlleraddress.text.trim(),
                latitude: controllerlatitude.text.trim(),
                longitude: controllerlongitude.text.trim(), status: '0');
            Navigator.pop(context);
          }, child: Text("Create"))
        ],
      )
    );
  }

  InputDecoration decoration(String s) {
    return InputDecoration(
      labelText: s,
      border: OutlineInputBorder(),
    );
  }

  Future createLampe({required String address, required String status,
    required String latitude,
    required String longitude}) async {
    DatabaseReference ref = FirebaseDatabase.instance.ref("lampes");

    final lampe = Lampe(
        id: "ss",
        address: address,
        latitude: latitude,
        longitude: longitude,
        status: status);

    final lampejson = lampe.toJson();
    await ref.push().set(lampejson);
  }
}


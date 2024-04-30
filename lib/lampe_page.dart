import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
                latitude: double.parse(controllerlatitude.text.trim()),
                longitude: double.parse(controllerlongitude.text.trim()), status: '0');
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
    required double latitude,
    required double longitude}) async {
    final docLampe = FirebaseFirestore.instance.collection('lampe').doc();

    final lampe = Lampe(
        id: docLampe.id,
        address: address,
        latitude: latitude,
        longitude: longitude,
        status: status);

    final lampejson = lampe.toJson();
    await docLampe.set(lampejson);
  }
}


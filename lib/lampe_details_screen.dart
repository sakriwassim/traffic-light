import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class LampeDetailsScreen extends StatelessWidget {
  Lampe lampe;

  LampeDetailsScreen({required this.lampe, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lampe Details Screen"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(style: TextStyle(fontSize: 20), lampe.address),
            SizedBox(
              height: 20,
            ),
            Text(style: TextStyle(fontSize: 20), lampe.longitude.toString()),
            SizedBox(
              height: 20,
            ),
            Text(style: TextStyle(fontSize: 20), lampe.longitude.toString()),
            SizedBox(
              height: 20,
            ),
            Text(style: TextStyle(fontSize: 20), lampe.status.toString()),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      final docLampe = FirebaseFirestore.instance
                          .collection('lampe')
                          .doc(lampe.id);
                      docLampe.update(Lampe(
                              id: lampe.id,
                              address: lampe.id,
                              longitude: lampe.longitude,
                              latitude: lampe.latitude,
                              status: "0")
                          .toJson());
                    },
                    child: Text("rest")),
                SizedBox(width: 20,),
                ElevatedButton(
                    onPressed: () {
                      final docLampe = FirebaseFirestore.instance
                          .collection('lampe')
                          .doc(lampe.id);
                      docLampe.update(Lampe(
                          id: lampe.id,
                          address: lampe.id,
                          longitude: lampe.longitude,
                          latitude: lampe.latitude,
                          status: "1")
                          .toJson());
                    },
                    child: Text("green")),
                SizedBox(width: 20,),
                ElevatedButton(
                    onPressed: () {
                      final docLampe = FirebaseFirestore.instance
                          .collection('lampe')
                          .doc(lampe.id);
                      docLampe.update(Lampe(
                          id: lampe.id,
                          address: lampe.id,
                          longitude: lampe.longitude,
                          latitude: lampe.latitude,
                          status: "2")
                          .toJson());
                    },
                    child: Text("red")),
              ],
            )
          ],
        ),
      ),
    );
  }
}

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'lampe_module.dart';

class LampeDetails extends StatelessWidget {
  LampeModel lampe;

  LampeDetails({required this.lampe, super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(style: TextStyle(fontSize: 20), "the carent state"),
          SizedBox(
            height: 20,
          ),
          Icon(
            Icons.traffic,
            color: lampe.status == "0"
                ? Colors.orangeAccent
                : lampe.status == "1"
                    ? Colors.green
                    : Colors.red,
            size: 50,
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              FirebaseDatabase.instance.ref("lampes/${lampe.id}").update(LampeModel(
                      id: lampe.id,
                      address: lampe.address,
                      longitude: lampe.longitude,
                      latitude: lampe.latitude,
                      status: "0")
                  .toJson());
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(
                    Radius.circular(10.0),
                  )),
              height: 100,
              width: double.infinity,
              child: Icon(
                Icons.traffic,
                color: Colors.orangeAccent,
                size: 50,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {
              FirebaseDatabase.instance.ref("lampes/${lampe.id}").update(LampeModel(
                      id: lampe.id,
                      address: lampe.address,
                      longitude: lampe.longitude,
                      latitude: lampe.latitude,
                      status: "1")
                  .toJson());
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(
                    Radius.circular(10.0),
                  )),
              height: 100,
              width: double.infinity,
              child: Icon(
                Icons.traffic,
                color: Colors.green,
                size: 50,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          InkWell(
            onTap: () {

              FirebaseDatabase.instance.ref("lampes/${lampe.id}").update(LampeModel(
                      id: lampe.id,
                      address: lampe.address,
                      longitude: lampe.longitude,
                      latitude: lampe.latitude,
                      status: "2")
                  .toJson());
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(
                    Radius.circular(10.0),
                  )),
              height: 100,
              width: double.infinity,
              child: Icon(
                Icons.traffic,
                color: Colors.red,
                size: 50,
              ),
            ),
          ),

          InkWell(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: new BorderRadius.all(
                    Radius.circular(10.0),
                  )),
              height: 50,
              width: double.infinity,
              child: Text("Cancel")
            ),
          ),
        ],
      ),
    );
  }
}

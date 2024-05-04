import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:hospital_car/signin_screen.dart';
import 'package:latlong2/latlong.dart';

import 'lampe_module.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Text("Hospital Car",
            style: TextStyle(color: Colors.white, fontSize: 20),),
        actions: [
          InkWell(
            onTap: () async {
              try {
                await FirebaseAuth.instance.signOut();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => SigninPage()),
                );
              } catch (error) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text("Error"),
                      content: Text(error.toString()),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("OK"),
                        ),
                      ],
                    );
                  },
                );
              }
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Icon(
                Icons.login,
                color: Colors.white,
                size: 25,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: StreamBuilder<List<LampeModel>>(
          stream: readLampes(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text("Something went wrong! ${snapshot.error}"),
              );
            } else if (snapshot.hasData) {
              final lampes = snapshot.data;

              List<Marker> markers = lampes!.map((lampe) {
                return Marker(
                  height: 50,
                  width: 60,
                  point: LatLng(
                    double.parse(lampe.latitude),
                    double.parse(lampe.longitude),
                  ),
                  child: Container(
                    child: Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              try {
                                FirebaseDatabase.instance
                                    .ref("lampes/${lampe.id}")
                                    .update(LampeModel(
                                            id: lampe.id,
                                            address: lampe.address,
                                            longitude: lampe.longitude,
                                            latitude: lampe.latitude,
                                            status: "0")
                                        .toJson());
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(e.toString()),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Icon(
                              size: 35,
                              Icons.traffic,
                              color: lampe.status == "0"
                                  ? Colors.orangeAccent
                                  : lampe.status == "1"
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              try {
                                FirebaseDatabase.instance
                                    .ref("lampes/${lampe.id}")
                                    .update(LampeModel(
                                            id: lampe.id,
                                            address: lampe.address,
                                            longitude: lampe.longitude,
                                            latitude: lampe.latitude,
                                            status: "2")
                                        .toJson());
                              } catch (e) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: Text("Error"),
                                      content: Text(e.toString()),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: Text("OK"),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              }
                            },
                            child: Icon(
                              size: 35,
                              Icons.refresh,
                              color: lampe.status == "0"
                                  ? Colors.orangeAccent
                                  : lampe.status == "1"
                                      ? Colors.green
                                      : Colors.red,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }).toList();

              return FlutterMap(
                options:  MapOptions(
                  initialCenter: LatLng(36.808557,10.159067),
                  initialZoom: 18.84306149436319,
                  onPositionChanged: (mapPosition, _) {
                    print("${mapPosition.zoom.toString()}"); // Update the current position
                  },
                  interactiveFlags: InteractiveFlag.none,
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  ),
                  MarkerLayer(markers: markers),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }

  Stream<List<LampeModel>> readLampes() {
    final DatabaseReference _databaseReference =
        FirebaseDatabase.instance.ref("lampes");

    return _databaseReference.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      if (data == null) return [];
      return data.entries.map((entry) {
        final key = entry.key as String;
        final value = entry.value as Map<dynamic, dynamic>;
        return LampeModel.fromJson({...value, 'id': key});
      }).toList();
    });
  }
}

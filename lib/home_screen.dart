import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import 'lampe_details_screen.dart';
import 'lampe_module.dart';
import 'lampe_page.dart';

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
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("Hospital Car"),
      ),
      body: Container(
         height: 650,
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
                  point: LatLng(
                    double.parse(lampe.latitude),
                    double.parse(lampe.longitude),
                  ),
                  child: InkWell(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: LampeDetails(lampe: lampe,),
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.traffic,
                      color: lampe.status == "0"
                          ? Colors.orangeAccent
                          : lampe.status == "1"
                          ? Colors.green
                          : Colors.red,
                      size: 50,
                    ),

                  ),
                );
              }).toList();


              return  FlutterMap(
                options: const MapOptions(
                  initialCenter: LatLng(36.808721307989806, 10.159142586152463),
                  initialZoom: 20,
                  // interactiveFlags: InteractiveFlag.none,
                ),
                children: [
                  TileLayer(
                    urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
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


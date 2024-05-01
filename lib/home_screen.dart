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
  late List<LampteModel> lampeList = [];
  MyMapController mapController = MyMapController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        title: Text("Hospital Car"),
      ),
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: Colors.orangeAccent, //Colors.transparent,
          ),
          height: 650,
          child: StreamBuilder<List<Lampe>>(
            stream: readLampes(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Something went wrong! ${snapshot.error}"),
                );
              } else if (snapshot.hasData) {
                final lampes = snapshot.data;

                lampeList = lampes!.map((lampe) {
                  return LampteModel(
                    marker: Marker(
                      point: LatLng(
                        double.parse(lampe.latitude),
                        double.parse(lampe.longitude),
                      ),
                     child: Icon(
                      Icons.place,
                      color: Colors.green,
                      size: 50,
                    ),
                    ),
                  );
                }).toList();

                final markers =
                lampeList.map((lampe) => lampe.marker).toList();

                return Stack(
                  children: [
                    FlutterMap(
                      mapController: mapController.mapController,
                      options: MapOptions(
                        center: LatLng(36.8152, 10.1711), // Bab Saadoun coordinates
                        zoom: 15.0, // Adjust zoom level as needed
                        minZoom: 15.0, // Set minZoom to the same as zoom to block zooming
                        maxZoom: 15.0,
                        // Set maxZoom to the same as zoom to block zooming
                        enableScrollWheel: false, // Disable user interaction
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                          'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                        MarkerLayer(markers: markers),
                      ],
                    ),
                    // ListView(
                    //   children: lampes.map(buildLampe).toList(),
                    // ),
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
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => LampePage())),
        tooltip: 'Add Lampe',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildLampe(Lampe lampe) => InkWell(
    onTap: () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => LampeDetailsScreen(
          lampe: lampe,
        ),
      ),
    ),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: lampe.status == "0"
            ? Colors.orangeAccent
            : lampe.status == "1"
            ? Colors.green
            : Colors.red,
        child: Text('${lampe.status}'),
      ),
      title: Text(lampe.address ?? ""),
      subtitle: Text(
          "Latitude: ${lampe.latitude}, Longitude: ${lampe.longitude}"),
    ),
  );

  Stream<List<Lampe>> readLampes() {
    final DatabaseReference _databaseReference =
    FirebaseDatabase.instance.ref("lampes");

    return _databaseReference.onValue.map((event) {
      final data = event.snapshot.value as Map<dynamic, dynamic>;
      if (data == null) return [];
      return data.entries.map((entry) {
        final key = entry.key as String;
        final value = entry.value as Map<dynamic, dynamic>;
        return Lampe.fromJson({...value, 'id': key});
      }).toList();
    });
  }
}

class LampteModel {
  final Marker marker;

  LampteModel({required this.marker});
}

class MyMapController {
  MapController mapController = MapController();

  void moveTo(LatLng point, double zoom) {
    mapController.move(point, zoom);
  }
}

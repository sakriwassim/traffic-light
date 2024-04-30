import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:hospital_car/lampe_page.dart';
import 'firebase_options.dart';
import 'lampe_details_screen.dart';
import 'lampe_module.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .colorScheme
            .inversePrimary,
        title: Text("Hospital Car"),
      ),
      body: Center(
          child: StreamBuilder<List<Lampe>>(
            stream: readLampes(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("Someting went wrong ! ${snapshot.error}");
              }
              else if (snapshot.hasData) {
                final lampes = snapshot.data ;

                return ListView(
                  children: lampes!.map(buildLampe).toList(),
                );
              } else {
                return Center(child: CircularProgressIndicator(),);
              }
            },
          )
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => LampePage())),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget buildLampe(Lampe lampe) =>
      InkWell(
        onTap: () =>
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => LampeDetailsScreen(lampe: lampe,),
                )),
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: lampe.status == "0" ? Colors.orangeAccent :
            lampe.status == "1" ? Colors.green :
            Colors.red,
            child: Text('${lampe.status}'),),
          title: Text(lampe.address ?? ""),
          subtitle: Text(
              "latitude : ${lampe.latitude }  longitude : ${lampe.longitude }"),

        ),
      );


  // Future<Lampe?> readLampeById({required String id}) async {
  //   final doclampe = FirebaseFirestore.instance.collection('lampe').doc(id);
  //   final snapshot = await doclampe.get();
  //   if (snapshot.exists) {
  //     return Lampe.fromJson(snapshot.data()!);
  //   }
  // }

  // Stream<List<Lampe>> readLampes() {
  //  return FirebaseFirestore.instance.collection('lampe')
  //       .snapshots()
  //       .map((snapshot)=>snapshot.docs.map((doc)=> Lampe.fromJson(doc.data())).toList());
  // }



  Stream<List<Lampe>> readLampes() {
    final DatabaseReference _databaseReference = FirebaseDatabase.instance.ref("lampes");

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

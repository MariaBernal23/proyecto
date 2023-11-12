import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  void getEstudiantes() async {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("tbestudiantes");
    QuerySnapshot mensaje = await collectionReference.get();
    if (mensaje.docs.length != 0) {
      for (var doc in mensaje.docs) {
        print(doc.data());
      }
    }
  }

  Future<List> getMensajes() async {
    List chats = [];
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection("tbestudiantes");
    QuerySnapshot mensaje = await collectionReference.get();
    if (mensaje.docs.length != 0) {
      for (var doc in mensaje.docs) {
        print((doc.data()));
        chats.add(doc.data());
      }
    }
    return chats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.indigo,
        title: Text(widget.title),
      ),
      body: FutureBuilder(
        future: getMensajes(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: ((context, index) {
                return Card(
                  elevation: 5,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(15),
                    title: Text(
                      snapshot.data?[index]["nombre"] +
                          " " +
                          snapshot.data?[index]["apellido"],
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.indigo,
                      ),
                    ),
                    subtitle: Text(
                      "Edad: ${snapshot.data?[index]["edad"] ?? 'No disponible'}",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                );
              }),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getEstudiantes,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    getEstudiantes();
  }

  @override
  void dispose() {
    super.dispose();
  }
}

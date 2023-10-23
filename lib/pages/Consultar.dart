import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Consulta extends StatefulWidget {
  @override
  State<Consulta> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Consulta> {
  
  void getUsuario() async {
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("tb_usuario");
    QuerySnapshot mensaje = await collectionReference.get();
    if (mensaje.docs.length != 0){
      for (var doc in mensaje.docs){
        print(doc.data());
      }
    }
  }

  Future<List> getMensajes() async {
    List chats = [];
    CollectionReference collectionReference =
    FirebaseFirestore.instance.collection("tb_usuario");
    QuerySnapshot mensaje = await collectionReference.get();
    if (mensaje.docs.length != 0){
      for (var doc in mensaje.docs){
        print(doc.data());
        chats.add(doc.data());
      }
    }
    return chats;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text('Consultar usuarios'),
      ),
      body: FutureBuilder(
        future: getMensajes(),
        builder: ((context, snapshot){
          if(snapshot.hasData){
            return ListView.builder(
  itemCount: snapshot.data?.length,
  itemBuilder: (context, index) {
    final producto = snapshot.data?[index];
    return Card(
      margin: EdgeInsets.all(8.0),
      elevation: 4.0,
      child: ListTile(
        title: Text(
          'ID: ${producto["idusuario"]}',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Nombre: ${producto["nombre"]}'),
            Text('Contrasena: ${producto["contrasena"]}'),
          ],
        ),
      ),
    );
  },
);
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getUsuario,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        ),
    );
    }
    @override
    void initState(){
      super.initState();
      getUsuario();
    }
    @override
    void dispose(){
      super.dispose();
    }
}
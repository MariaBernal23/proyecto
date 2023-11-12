import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';



class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  

 

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

void getEstudiantes()async{
  CollectionReference collectionReference =
  FirebaseFirestore.instance.collection("tbestudiantes");
  QuerySnapshot mensaje = await collectionReference.get();
  if(mensaje.docs.length !=0){
    for (var doc in mensaje.docs){
      print(doc.data());
    }
  }
}

Future<List> getMensajes () async {
  List chats = [];
  CollectionReference collectionReference =
  FirebaseFirestore.instance.collection("tbestudiantes");
  QuerySnapshot mensaje = await collectionReference.get();
  if(mensaje.docs.length !=0){
    for (var doc in mensaje.docs){
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
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,  
        title: Text(widget.title),
      ),

      body:FutureBuilder(
        future: getMensajes(),
        builder: ((context, snapshot){
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder:((context,index){
                return Text(snapshot.data?[index]["nombre"]+ "_" + snapshot.data?[index]["apellido"]);
              }),
            );
          }else{
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: getEstudiantes,
        tooltip: 'Increment',
        child:  const Icon(Icons.add),
    ),
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getEstudiantes();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    
  }
}

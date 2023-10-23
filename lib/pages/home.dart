import 'package:proyecto/pages/Consultar.dart';
import 'package:proyecto/pages/Registrar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class home extends StatefulWidget {
  @override
  State<home> createState() => homeState();
}

class homeState extends State<home> {
  int ItemDrawer = 0;

  _getDrawerItem(int position) {
    switch (position) {
      case 0:
        return Registro();
      case 1:
         return Consulta();
    }
  }

  void _onSelectItemDrawer(int pos) {
    Navigator.pop(context);
    setState(() {
      ItemDrawer = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 0, 217, 255),
              ),
              child: Center(
                child: Text(
                  'MENÚ',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
            Divider(color: Colors.black),
            ListTile(
                leading: Image.asset(
                  'img/registrarse.png',
                  width: 25,
                  height: 25,
                ),
                title: Text('Registrar usuario'),
                onTap: () {
                  _onSelectItemDrawer(0);
                }),
            ListTile(
                leading: Image.asset(
                  'img/consultar.png',
                  width: 25,
                  height: 25,
                ),
                title: Text('Consultar usuario'),
                onTap: () {
                  _onSelectItemDrawer(1);
                }),
            Divider(color: Colors.black),
            ElevatedButton(
              onPressed: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushNamed(context, "/login");
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.lightBlue, // Color de fondo del botón
                onPrimary: Colors.white, // Color del texto del botón
              ),
              child: Row(
                children: [
                  Image.asset(
                    'img/cerrar.png',
                    width: 25,
                    height: 25,
                  ),
                  SizedBox(width: 10), // Espacio entre la imagen y el texto
                  Text('Cerrar sesión'),
                ],
              ),
            )
          ],
        ),
      ),
      body: _getDrawerItem(ItemDrawer),
    );
  }
}

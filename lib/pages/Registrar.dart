import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class Registro extends StatelessWidget {
  Future<void> agregarUsuario(String idusuario, String nombre, String contrasena) async {
    await FirebaseFirestore.instance.collection('tb_usuario').add({
      "idusuario": idusuario,
      "nombre": nombre,
      "contrasena": contrasena
    });
  }

  

  TextEditingController IdController = TextEditingController();
  TextEditingController NombreController = TextEditingController();
  TextEditingController ContrasenaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Card(
          elevation: 5, // Add elevation for a shadow effect
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(height: 15),
                const Text(
                  'Registro de usuarios',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: IdController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.pink[50],
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'img/id.png',
                        width: 5,
                        height: 5,
                      ),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: 'ID',
                    hintText: 'Ingrese el ID del usuario',
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: NombreController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.pink[50],
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'img/nombre.png',
                        width: 5,
                        height: 5,
                      ),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: 'Nombre',
                    hintText: 'Ingrese un nombre para el usuario',
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: ContrasenaController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.pink[50],
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset(
                        'img/contrasena.png',
                        width: 5,
                        height: 5,
                      ),
                    ),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                    labelText: 'Contraseña',
                    hintText: 'Ingrese una contraseña',
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton(
                  onPressed: () async {
                    await agregarUsuario(IdController.text, NombreController.text, ContrasenaController.text).then((_) {
                      IdController.clear();
                      NombreController.clear();
                      ContrasenaController.clear();
                    });
                  },
                  child: const Text('Guardar'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

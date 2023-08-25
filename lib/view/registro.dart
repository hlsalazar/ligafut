import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegistroPantalla extends StatefulWidget {
  const RegistroPantalla({super.key});

  @override
  State<RegistroPantalla> createState() => _RegistroPantallaState();
}

class _RegistroPantallaState extends State<RegistroPantalla> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  var nombrePantalla = 'Registro';
  var campoNombre = 'NOMBRE COMPLETO: ';
  var campoCorreo = 'CORREO ELECTRÓNICO: ';
  var campoContrasenia = 'CONTRASEÑA: ';
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 40,
      ),
      body: Container(
        width: 400,
        height: 400,
        margin: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        // margin: EdgeInsets.fromLTRB(left, top, right, bottom),
        //decoration: BoxDecoration(border: Border.all()),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              nombrePantalla,
              style: const TextStyle(
                  color: Colors.red, fontSize: 30, fontWeight: FontWeight.bold),
            ),
            Text(campoNombre),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Nombre',
                filled: true,
                fillColor: Color.fromARGB(136, 185, 188, 189),
              ),
              keyboardType: TextInputType.text,
              controller: _nombreController,
            ),
            Text(campoCorreo),
            TextField(
              decoration: const InputDecoration(
                hintText: 'Correo',
                filled: true,
                fillColor: Color.fromARGB(136, 185, 188, 189),
              ),
              keyboardType: TextInputType.text,
              controller: _correoController,
            ),
            Text(campoContrasenia),
            TextField(
              controller: _contrasenaController,
              decoration: const InputDecoration(
                filled: true,
                hintText: 'Contraseña',
                fillColor: Color.fromARGB(136, 185, 188, 189),
              ),
              obscureText: true,
            ),
            Center(
              child: SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0))),
                      onPressed: () async {
                        await registroUsuario(
                                _nombreController.text,
                                _correoController.text,
                                _contrasenaController.text)
                            .then((value) => Navigator.pop(context));
                      },
                      child: const Text('Registarse'))),
            )
          ],
        ),
      ),
    );
  }

  Future<void> registroUsuario(
      String nombre, String correo, String contrasena) async {
    await db
        .collection('usuario')
        .add({'nombre': nombre, 'correo': correo, 'contrasena': contrasena});
  }
}//Fin clase

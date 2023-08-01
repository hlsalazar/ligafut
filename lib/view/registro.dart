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
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: "Nombre"),
            ),
            TextField(
              controller: _correoController,
              decoration:
                  const InputDecoration(labelText: "Correo electrónico"),
            ),
            TextField(
              controller: _contrasenaController,
              decoration: const InputDecoration(labelText: "Contraseña"),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: 200, // Ancho deseado del botón
              height: 50, // Alto deseado del botón
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Colors.green),
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.white),
                ),
                onPressed: () async {
                  await registroUsuario(_nombreController.text,
                          _correoController.text, _contrasenaController.text)
                      .then((value) => Navigator.pop(context));
                },
                child: const Text(
                  "Registrarte",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
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

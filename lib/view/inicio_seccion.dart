import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ligafut_app/View/registro.dart';
import 'package:ligafut_app/view/CalendarPage.dart';

class InicioSeccionPantalla extends StatefulWidget {
  const InicioSeccionPantalla({super.key});

  @override
  State<InicioSeccionPantalla> createState() => _InicioSeccionPantallaState();
}

class _InicioSeccionPantallaState extends State<InicioSeccionPantalla> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio de Sesión'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
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
            const SizedBox(
              height: 16,
            ),
            SizedBox(
              width: 200, // Ancho deseado del botón
              height: 50, // Alto deseado del botón
              child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.lightBlue),
                    foregroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                  ),
                  onPressed: () {
                    _iniciarSesion();
                  },
                  child: const Text(
                    'Iniciar Sesión',
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RegistroPantalla()),
                  );
                },
                child: const Text(
                  "Crear una cuenta",
                  style: TextStyle(fontSize: 15),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _iniciarSesion() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('usuario');
      QuerySnapshot usuario = await ref.get();
      if (usuario.docs.length != 0) {
        for (var i in usuario.docs) {
          if (i.get('correo') == _correoController.text &&
              i.get('contrasena') == _contrasenaController.text) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    CalendarPage(), // Reemplaza OtraPagina por el nombre de la clase de tu otra pantalla.
              ),
            );
          }
        }
      }
    } catch (e) {
      print('Error.... ' + e.toString());
    }
  }
}//Fin clase

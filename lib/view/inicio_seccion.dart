import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ligafut_app/View/registro.dart';
import 'package:ligafut_app/view/inicio.dart';

class InicioSeccionPantalla extends StatefulWidget {
  const InicioSeccionPantalla({super.key});

  @override
  State<InicioSeccionPantalla> createState() => _InicioSeccionPantallaState();
}

class _InicioSeccionPantallaState extends State<InicioSeccionPantalla> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  var db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Inicio de Sesión'),
      // ),
      body: Stack(children: [
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Positioned(
          bottom: -50,
          right: -50,
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: _correoController,
                decoration: InputDecoration(
                  labelText: 'Correo electrónico',
                  labelStyle: const TextStyle(color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  prefixIcon: const Icon(
                    Icons.email,
                    color: Colors.lightBlue,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _contrasenaController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  labelStyle: const TextStyle(color: Colors.blue),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  prefixIcon: const Icon(
                    Icons.lock,
                    color: Colors.lightBlue,
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: 500, // Ancho deseado del botón
                height: 50, // Alto deseado del botón
                child: ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blueAccent),
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
                width: 500, // Ancho deseado del botón
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
      ]),
    );
  }

  _iniciarSesion() async {
    try {
      await db.collection('usuario').get().then((event) {
        for (var doc in event.docs) {
          if (doc.get('correo') == _correoController.text &&
              doc.get('contrasena') == _contrasenaController.text) {
            //print('Encontradooo');
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PantallaPrincipal(),
              ),
            );
          } else {
            //print('no encontrado');
          }
        }
      });
    } catch (e) {
      //print('Error.... ' + e.toString());
    }
  }
}//Fin clase

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:ligafut_app/View/registro.dart';
import 'package:ligafut_app/view/principal.dart';
import 'package:ligafut_app/view/registro.dart';

class IniciarSesionPantalla extends StatefulWidget {
  const IniciarSesionPantalla({super.key});

  @override
  State<IniciarSesionPantalla> createState() => _IniciarSesionPantallaState();
}

class _IniciarSesionPantallaState extends State<IniciarSesionPantalla> {
  final TextEditingController _correoController = TextEditingController();
  final TextEditingController _contrasenaController = TextEditingController();
  var nombrePagina = 'INICIO DE SESIÓN';
  var campoCorreo = 'Escriba su correo electrónico';
  var campoContrasenia = 'Escriba su contraseña';
  var campoInicioSession = 'Inicia sesión';
  var campoCrearCuenta = 'CREAR CUENTA';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 10,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        //mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(40, 20, 0, 20),
            child: Image.asset(
              'assets/logoEquipo.png',
              width: 100,
              height: 60,
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color.fromARGB(69, 0, 0, 0),
                )),
            padding: const EdgeInsets.fromLTRB(25, 0, 25, 0),
            //left, top, right, bottom)
            margin: const EdgeInsets.fromLTRB(30, 0, 30, 0),
            height: 260,
            width: 400,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              //mainAxisAlignment: MainAxisAlignment.,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
                  child: Text(
                    nombrePagina,
                    style: const TextStyle(
                        color: Colors.red, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: TextField(
                    controller: _correoController,
                    decoration: InputDecoration(
                      labelText: campoCorreo,
                      //border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 15),
                  child: TextField(
                    controller: _contrasenaController,
                    decoration: InputDecoration(
                      labelText: campoContrasenia,
                      //border: const OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                ),
                SizedBox(
                  width: 400, // Ancho deseado del botón
                  height: 50,
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _iniciarSesion();
                        });
                        ();
                      },
                      child: Text(campoInicioSession)),
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: const Color.fromARGB(69, 0, 0, 0),
                )),
            //padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            //left, top, right, bottom)
            margin: const EdgeInsets.fromLTRB(30, 10, 30, 0),
            height: 40,
            width: 400,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegistroPantalla()),
                );
              },
              child: Text(
                campoCrearCuenta,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          )
        ],
      ),
    );
  }

  _iniciarSesion() async {
    try {
      CollectionReference ref =
          FirebaseFirestore.instance.collection('usuario');
      QuerySnapshot usuario = await ref.get();
      if (usuario.docs.isNotEmpty) {
        for (var i in usuario.docs) {
          if (i.get('correo') == _correoController.text &&
              i.get('contrasena') == _contrasenaController.text) {
            // ignore: use_build_context_synchronously
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const PantallaPrincipal(),
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


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
      // appBar: AppBar(
      //   title: const Text('Registro de Usuario'),
      // ),
      body: Stack(children: [
        Positioned(
          top: -130,
          left: 150,
          child: Container(
            width: 200,
            height: 200,
            decoration: const BoxDecoration(
              color: Colors.blue,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey, // Color gris de la sombra
                  blurRadius: 10, // Radio del desenfoque de la sombra
                  spreadRadius: 2, // Radio de expansión de la sombra
                  offset: Offset(0, 2), // Desplazamiento de la sombra en X e Y
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildTextFieldWithIcon(
                controller: _nombreController,
                labelText: 'Nombre',
                icon: Icons.person,
              ),
              const SizedBox(height: 16),
              _buildTextFieldWithIcon(
                controller: _correoController,
                labelText: 'Correo electrónico',
                icon: Icons.email,
              ),
              const SizedBox(height: 16),
              _buildTextFieldWithIcon(
                controller: _contrasenaController,
                labelText: 'Contraseña',
                icon: Icons.lock,
                isPassword: true,
              ),
              const SizedBox(height: 24),
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
      ]),
    );
  }

  Future<void> registroUsuario(
      String nombre, String correo, String contrasena) async {
    await db
        .collection('usuario')
        .add({'nombre': nombre, 'correo': correo, 'contrasena': contrasena});
  }

  Widget _buildTextFieldWithIcon({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(color: Colors.blue),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0),
        ),
        prefixIcon: Icon(
          icon,
          color: Colors.blue,
        ),
      ),
      style: const TextStyle(color: Colors.blue),
    );
  }
}//Fin clase

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TeamRegistrationPage extends StatefulWidget {
  @override
  _TeamRegistrationPageState createState() => _TeamRegistrationPageState();
}

class _TeamRegistrationPageState extends State<TeamRegistrationPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _idController = TextEditingController();
  TextEditingController _captainController = TextEditingController();
  TextEditingController _teamNameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  String _message = '';
  IconData _messageIcon = Icons.info_outline;
  Color _messageColor = Colors.black;

  void _resetFields() {
    _idController.clear();
    _captainController.clear();
    _teamNameController.clear();
    _cityController.clear();
  }

  Future<void> _registerTeam() async {
    if (_formKey.currentState!.validate()) {
      try {
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        await firestore.collection('equipos').add({
          'ID': _idController.text,
          'Capitan': _captainController.text,
          'NombreEquipo': _teamNameController.text,
          'Ciudad': _cityController.text,
        });
        _resetFields();
        setState(() {
          _message = 'Equipo registrado con éxito';
          _messageIcon = Icons.check_circle_outline;
          _messageColor = Colors.green;
        });
      } catch (e) {
        setState(() {
          _message = 'Error al registrar el equipo';
          _messageIcon = Icons.error_outline;
          _messageColor = Colors.red;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de Equipos de Fútbol')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _idController,
                decoration: InputDecoration(labelText: 'ID'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un ID válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _captainController,
                decoration: InputDecoration(labelText: 'Capitán'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese el nombre del capitán';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _teamNameController,
                decoration: InputDecoration(labelText: 'Nombre del Equipo'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese un nombre de equipo válido';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _cityController,
                decoration: InputDecoration(labelText: 'Ciudad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese una ciudad válida';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _registerTeam,
                child: Text('Registrar Equipo'),
              ),
              SizedBox(height: 20),
              Text(
                _message,
                style: TextStyle(
                  color: _messageColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Icon(
                _messageIcon,
                color: _messageColor,
                size: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

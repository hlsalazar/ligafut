import 'package:cloud_firestore/cloud_firestore.dart';

class Equipo {
  final String nombreEquipo;
  final String capitan;
  final String ciudad;
  final db = FirebaseFirestore.instance;
  Equipo(
      {required this.nombreEquipo,
      required this.capitan,
      required this.ciudad});
}
//equipos
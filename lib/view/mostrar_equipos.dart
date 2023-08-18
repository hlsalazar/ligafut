import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/equipo.dart';

class ListaEquiposPantalla extends StatefulWidget {
  const ListaEquiposPantalla({super.key});

  @override
  State<ListaEquiposPantalla> createState() => _ListaEquiposPantallaState();
}

class _ListaEquiposPantallaState extends State<ListaEquiposPantalla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista Equipos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('equipos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }
          List<Equipo> listaEquipos = [];
          snapshot.data!.docs.forEach((document) {
            var data = document.data() as Map<String, dynamic>;
            String nombreEquipo = data['NombreEquipo'];
            String capitan = data['Capitan'];
            String ciudad = data['Ciudad'];
            listaEquipos.add(Equipo(
                nombreEquipo: nombreEquipo, capitan: capitan, ciudad: ciudad));
          });
          return ListView.builder(
            itemCount: listaEquipos.length,
            itemBuilder: (context, index) {
              return TarjetaEquipo(equipo: listaEquipos[index]);
            },
          );
        },
      ),
    );
  }
}

class TarjetaEquipo extends StatelessWidget {
  final Equipo equipo;

  TarjetaEquipo({required this.equipo});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Equipo: ${equipo.nombreEquipo}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text('Capitán: ${equipo.capitan}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text('Ciudad: ${equipo.ciudad}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

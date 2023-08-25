import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ListaPartidosPantalla extends StatefulWidget {
  @override
  _ListaPartidosPantallaState createState() => _ListaPartidosPantallaState();
}

class _ListaPartidosPantallaState extends State<ListaPartidosPantalla> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Partidos'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('partidos').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          List<Partido> listaPartidos = [];
          snapshot.data!.docs.forEach((document) {
            var data = document.data() as Map<String, dynamic>;
            String equipoLocal = data['equipo_local'];
            String equipoVisitante = data['equipo_visitante'];
            String fecha = data['fecha']; // Utilizamos el campo de tipo String
            int golesLocal = data['goles_local'];
            int golesVisitante = data['goles_visitante'];

            listaPartidos.add(Partido(
              equipoLocal: equipoLocal,
              equipoVisitante: equipoVisitante,
              fecha: fecha,
              golesLocal: golesLocal,
              golesVisitante: golesVisitante,
            ));
          });

          return ListView.builder(
            itemCount: listaPartidos.length,
            itemBuilder: (context, index) {
              return TarjetaPartido(partido: listaPartidos[index]);
            },
          );
        },
      ),
    );
  }
}

class Partido {
  final String equipoLocal;
  final String equipoVisitante;
  final String fecha; // Mantenemos el campo de tipo String
  final int golesLocal;
  final int golesVisitante;

  Partido({
    required this.equipoLocal,
    required this.equipoVisitante,
    required this.fecha,
    required this.golesLocal,
    required this.golesVisitante,
  });
}

class TarjetaPartido extends StatelessWidget {
  final Partido partido;

  TarjetaPartido({required this.partido});

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
            Text(
              '${partido.equipoLocal} vs ${partido.equipoVisitante}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text('Fecha: ${partido.fecha}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 8),
            Text(
              'Resultado: ${partido.golesLocal} - ${partido.golesVisitante}',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class PartidoDetailPage extends StatefulWidget {
  final DocumentSnapshot partidoDocument;

  PartidoDetailPage({required this.partidoDocument});

  @override
  _PartidoDetailPageState createState() => _PartidoDetailPageState();
}

class _PartidoDetailPageState extends State<PartidoDetailPage> {
  void _showEditDialog(BuildContext context, DocumentReference partidoRef) {
    int golesLocal = widget.partidoDocument['goles_local'] ?? 0;
    int golesVisitante = widget.partidoDocument['goles_visitante'] ?? 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Editar Resultado'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: golesLocal.toString(),
                onChanged: (value) {
                  golesLocal = int.parse(value);
                },
                decoration: InputDecoration(labelText: 'Goles Local'),
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                initialValue: golesVisitante.toString(),
                onChanged: (value) {
                  golesVisitante = int.parse(value);
                },
                decoration: InputDecoration(labelText: 'Goles Visitante'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                partidoRef.update({
                  'goles_local': golesLocal,
                  'goles_visitante': golesVisitante,
                });

                Navigator.of(context).pop();
              },
              child: Text('Guardar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Detalle del Partido')),
      body: StreamBuilder(
        stream: widget.partidoDocument.reference.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return CircularProgressIndicator();
          }

          var partidoData = snapshot.data!.data() as Map<String, dynamic>;
          var partidoRef = widget.partidoDocument.reference;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Equipo Local: ${partidoData['equipo_local']}'),
                Text('Equipo Visitante: ${partidoData['equipo_visitante']}'),
                Text('Goles Local: ${partidoData['goles_local'] ?? 'No registrado'}'),
                Text('Goles Visitante: ${partidoData['goles_visitante'] ?? 'No registrado'}'),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    _showEditDialog(context, partidoRef);
                  },
                  child: Text('Editar Resultado'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

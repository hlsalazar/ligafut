import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/equipo.dart';

class TablaPosicionesScreen extends StatefulWidget {
  const TablaPosicionesScreen({super.key});

  @override
  State<TablaPosicionesScreen> createState() => _ListaEquiposPantallaState();
}

class _ListaEquiposPantallaState extends State<TablaPosicionesScreen> {
  bool _showHelp = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabla de Posiciones'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.help),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Ayuda'),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('P = Partidos jugados'),
                              Text('G = Partidos ganados'),
                              Text('E = Partidos empatados'),
                              Text('P = Partidos perdidos'),
                              Text('GF = Goles a favor'),
                              Text('GC = Goles en contra'),
                              Text('DG = Diferencia de goles'),
                            ],
                          ),
                          actions: <Widget>[
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('Cerrar'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                ),
                Text('Ayuda'),
              ],
            ),
            SizedBox(height: 16),
            StreamBuilder<QuerySnapshot>(
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

                listaEquipos.sort((a, b) {
                  // Ordena los equipos según su posición en la tabla (puedes cambiar el criterio)
                  // Por ejemplo, podrías ordenar por puntaje descendente
                  // o por diferencia de goles, etc.
                  // Asegúrate de definir tu propio criterio de ordenamiento aquí.
                  return 0;
                });

                int posicion = 1;

                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: DataTable(
                      headingTextStyle: TextStyle(fontWeight: FontWeight.bold),
                      columns: [
                        DataColumn(label: Text('Pos')),
                        DataColumn(label: Text('Equipo')),
                        DataColumn(label: Text('P')),
                        DataColumn(label: Text('G')),
                        DataColumn(label: Text('E')),
                        DataColumn(label: Text('P')),
                        DataColumn(label: Text('GF')),
                        DataColumn(label: Text('GC')),
                        DataColumn(label: Text('DG')),
                      ],
                      rows: listaEquipos.map((equipo) {
                        final DataRow dataRow = DataRow(cells: [
                          DataCell(Text('$posicion')),
                          DataCell(Text(equipo.nombreEquipo)),
                          DataCell(Text('10')), // Partidos jugados
                          DataCell(Text('7')),  // Partidos ganados
                          DataCell(Text('2')),  // Partidos empatados
                          DataCell(Text('1')),  // Partidos perdidos
                          DataCell(Text('25')), // Goles a favor
                          DataCell(Text('12')), // Goles en contra
                          DataCell(Text('13')), // Diferencia de goles
                        ]);

                        posicion++;
                        return dataRow;
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

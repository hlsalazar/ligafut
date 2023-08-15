import 'package:flutter/material.dart';

class Equipo {
  final String nombre;
  final int puntos;
  final int partidosJugados;
  final int partidosGanados;
  final int partidosEmpatados;
  final int partidosPerdidos;
  final int golesFavor;
  final int golesContra;

  Equipo({
    required this.nombre,
    required this.puntos,
    required this.partidosJugados,
    required this.partidosGanados,
    required this.partidosEmpatados,
    required this.partidosPerdidos,
    required this.golesFavor,
    required this.golesContra,
  });
}

class TablaPosicionesScreen extends StatelessWidget {
  final List<Equipo> equipos = [
    Equipo(
      nombre: 'Equipo A',
      puntos: 15,
      partidosJugados: 10,
      partidosGanados: 7,
      partidosEmpatados: 1,
      partidosPerdidos: 2,
      golesFavor: 20,
      golesContra: 10,
    ),
    Equipo(
      nombre: 'Equipo B',
      puntos: 12,
      partidosJugados: 8,
      partidosGanados: 6,
      partidosEmpatados: 0,
      partidosPerdidos: 2,
      golesFavor: 15,
      golesContra: 8,
    ),
    Equipo(
      nombre: 'Equipo C',
      puntos: 18,
      partidosJugados: 12,
      partidosGanados: 9,
      partidosEmpatados: 0,
      partidosPerdidos: 3,
      golesFavor: 25,
      golesContra: 12,
    ),
    Equipo(
      nombre: 'Equipo D',
      puntos: 10,
      partidosJugados: 9,
      partidosGanados: 3,
      partidosEmpatados: 1,
      partidosPerdidos: 5,
      golesFavor: 12,
      golesContra: 18,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tabla de Posiciones'),
        actions: [
          IconButton(
            icon: Icon(Icons.help_outline),
            onPressed: () => _showHelpDialog(context),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Tabla de Posiciones',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                itemCount: equipos.length,
                itemBuilder: (context, index) {
                  final equipo = equipos[index];
                  return _buildEquipoTile(equipo);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEquipoTile(Equipo equipo) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8),
      color: Colors.red[50],
      child: ExpansionTile(
        title: Text(
          equipo.nombre,
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          'Puntos: ${equipo.puntos}',
          style: TextStyle(color: Colors.black),
        ),
        leading: CircleAvatar(
          backgroundColor: Colors.red,
          child: Text(
            equipo.nombre[0],
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Table(
              defaultColumnWidth: IntrinsicColumnWidth(),
              border: TableBorder.all(color: Colors.black26),
              children: [
                TableRow(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                  ),
                  children: [
                    TableCell(child: _buildTableCell('P')),
                    TableCell(child: _buildTableCell('G')),
                    TableCell(child: _buildTableCell('E')),
                    TableCell(child: _buildTableCell('P')),
                    TableCell(child: _buildTableCell('GF')),
                    TableCell(child: _buildTableCell('GC')),
                    TableCell(child: _buildTableCell('DG')),
                  ],
                ),
                TableRow(
                  children: [
                    TableCell(child: _buildTableCell('${equipo.partidosJugados}')),
                    TableCell(child: _buildTableCell('${equipo.partidosGanados}')),
                    TableCell(child: _buildTableCell('${equipo.partidosEmpatados}')),
                    TableCell(child: _buildTableCell('${equipo.partidosPerdidos}')),
                    TableCell(child: _buildTableCell('${equipo.golesFavor}')),
                    TableCell(child: _buildTableCell('${equipo.golesContra}')),
                    TableCell(
                      child: _buildTableCell(
                        '${equipo.golesFavor - equipo.golesContra}',
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTableCell(String text) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: Text(text, textAlign: TextAlign.center),
    );
  }

  void _showHelpDialog(BuildContext context) {
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
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: TablaPosicionesScreen(),
  ));
}

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
            String id = document.id;
            String equipoLocal = data['equipo_local'];
            String equipoVisitante = data['equipo_visitante'];
            String fecha = data['fecha'];
            int golesLocal = data['goles_local'];
            int golesVisitante = data['goles_visitante'];

            listaPartidos.add(Partido(
              id: id,
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
  final String id;
  final String equipoLocal;
  final String equipoVisitante;
  final String fecha;
  final int golesLocal;
  final int golesVisitante;

  Partido({
    required this.id,
    required this.equipoLocal,
    required this.equipoVisitante,
    required this.fecha,
    required this.golesLocal,
    required this.golesVisitante,
  });
}

class TarjetaPartido extends StatefulWidget {
  final Partido partido;

  TarjetaPartido({required this.partido});

  @override
  _TarjetaPartidoState createState() => _TarjetaPartidoState();
}

class _TarjetaPartidoState extends State<TarjetaPartido> {
  late int golesLocal;
  late int golesVisitante;

  @override
  void initState() {
    super.initState();
    golesLocal = widget.partido.golesLocal;
    golesVisitante = widget.partido.golesVisitante;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: InkWell(
        onTap: () {
          _showScoreDialog(context, widget.partido);
        },
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.partido.equipoLocal} vs ${widget.partido.equipoVisitante}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('Fecha: ${widget.partido.fecha}', style: TextStyle(fontSize: 16)),
              SizedBox(height: 8),
              Text(
                'Resultado: $golesLocal - $golesVisitante',
                style: TextStyle(fontSize: 16),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showScoreDialog(BuildContext context, Partido partido) {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Registrar Goles'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${partido.equipoLocal} vs ${partido.equipoVisitante}'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${partido.equipoLocal}:'),
                  DropdownButton<int>(
                    value: golesLocal,
                    onChanged: (value) {
                      setState(() {
                        golesLocal = value!;
                      });
                    },
                    items: List.generate(11, (index) => index).map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${partido.equipoVisitante}:'),
                  DropdownButton<int>(
                    value: golesVisitante,
                    onChanged: (value) {
                      setState(() {
                        golesVisitante = value!;
                      });
                    },
                    items: List.generate(11, (index) => index).map((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text(value.toString()),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
              child: Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () async {
                // Actualizar los goles en Firebase Firestore
                await FirebaseFirestore.instance
                    .collection('partidos')
                    .doc(partido.id)
                    .update({
                  'goles_local': golesLocal,
                  'goles_visitante': golesVisitante,
                });

                Navigator.of(dialogContext).pop();
              },
              child: Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    title: 'Actualización de Goles',
    home: ListaPartidosPantalla(),
  ));
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'dart:math';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;



  List<dynamic> _teams = []; // Lista de nombres de equipos
  List<List<String>> _matches = []; // Lista de partidos por jornada

  Future<void> _getTeams() async {
    QuerySnapshot teamsSnapshot =
        await FirebaseFirestore.instance.collection('equipos').get();

    setState(() {
      _teams = teamsSnapshot.docs.map((doc) => doc['NombreEquipo']).toList();
    });
  }

  void _generateMatchSchedule() {
    _matches.clear();

    if (_teams.length % 2 == 1) {
      _teams.add(
          "Equipo ficticio"); // Agregar un equipo ficticio para balancear si es impar
    }

    int totalRounds = _teams.length - 1;
    int matchesPerRound = _teams.length ~/ 2;

    for (int round = 0; round < totalRounds; round++) {
      List<String> roundMatches = ["Jornada ${round + 1}"];

      for (int match = 0; match < matchesPerRound; match++) {
        int home = (round + match) % _teams.length;
        int away = (_teams.length - 1 - match + round) % _teams.length;

        if (match == 0) {
          away = _teams.length - 1; // Descanso
        }

        String matchDetails =
            "${_teams[home]} vs ${_teams[away]} - ${_generateRandomDate()}";

      int goalsLocal = 999;
      int goalsVisitor = 999;
        // Guardar el partido en Firebase
      _firestore.collection('partidos').add({
        'equipo_local': _teams[home],
        'equipo_visitante': _teams[away],
        'fecha': _generateRandomDate(),
        'goles_local': goalsLocal,
        'goles_visitante': goalsVisitor,
      });

        roundMatches.add(matchDetails);
      }

      _matches.add(roundMatches);
    }
  }

  int _generateRandomGoals() {
  final random = Random();
  return random.nextInt(5); // Genera un número aleatorio de goles entre 0 y 4
}

  String _generateRandomDate() {
    final random = Random();
    final start = DateTime.now();
    final end = start.add(Duration(days: random.nextInt(30)));

    return "${start.year}-${start.month}-${start.day} ${start.hour}:${start.minute} - ${end.year}-${end.month}-${end.day} ${end.hour}:${end.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Calendario de Partidos de Fútbol')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: (){
                _getTeams();
                _generateMatchSchedule();
                _getTeams();
              } ,
              child: Text('Generar Calendario'),
            ),
            SizedBox(height: 20),
            Text(
              'Calendario de Partidos:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: _matches.length,
                itemBuilder: (context, index) {
                  List<String> roundMatches = _matches[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        roundMatches[0],
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      for (int i = 1; i < roundMatches.length; i++)
                        ListTile(
                          title: Text(roundMatches[i]),
                        ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

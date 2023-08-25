import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class Match {
  final String team1;
  final String team2;

  Match(this.team1, this.team2);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Football Matches',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MatchListScreen(),
    );
  }
}

class MatchListScreen extends StatelessWidget {
  final List<Match> matches = [
    Match('Equipo A', 'Equipo B'),
    Match('Equipo C', 'Equipo D'),
    Match('Equipo A', 'Equipo C'),
    Match('Equipo B', 'Equipo D'),
    Match('Equipo A', 'Equipo D'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Football Matches'),
      ),
      body: ListView.builder(
        itemCount: matches.length,
        itemBuilder: (context, index) {
          final match = matches[index];
          return ListTile(
            title: Text('${match.team1} vs ${match.team2}'),
            onTap: () {
              _showScoreDialog(context, match);
            },
          );
        },
      ),
    );
  }

  void _showScoreDialog(BuildContext context, Match match) {
    int goalsTeam1 = 0;
    int goalsTeam2 = 0;

    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text('Registrar Goles'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('${match.team1} vs ${match.team2}'),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text('${match.team1}:'),
                  DropdownButton<int>(
                    value: goalsTeam1,
                    onChanged: (value) {
                      goalsTeam1 = value!;
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
                  Text('${match.team2}:'),
                  DropdownButton<int>(
                    value: goalsTeam2,
                    onChanged: (value) {
                      goalsTeam2 = value!;
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
              onPressed: () {
                // Puedes manejar aquí la lógica para registrar los goles
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

import 'package:flutter/material.dart';
import 'package:ligafut_app/view/CalendarPage.dart';
import 'package:ligafut_app/view/mostrar_equipos.dart';
import 'tabla_posiciones.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    CalendarPage(),
    ListaEquiposPantalla(),
    TablaPosicionesScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inicio Seccion'),
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendarios',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Equipos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.table_chart),
            label: 'Tabla de Posiciones',
          ),
        ],
      ),
    );
  }
}

class CalendariosScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pantalla de Calendarios'),
    );
  }
}

class EquiposScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Pantalla de Equipos'),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: PantallaPrincipal(),
  ));
}

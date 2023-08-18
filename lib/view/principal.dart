import 'package:flutter/material.dart';
import 'package:ligafut_app/view/TeamRegistrationPage.dart';
import 'package:ligafut_app/view/tabla_posiciones2.dart';
import 'CalendarPage.dart';
import 'mostrar_equipos.dart';
import 'tabla_posiciones.dart';

class PantallaPrincipal extends StatefulWidget {
  const PantallaPrincipal({Key? key}) : super(key: key);

  @override
  _PantallaPrincipalState createState() => _PantallaPrincipalState();
}

class _PantallaPrincipalState extends State<PantallaPrincipal> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    CalendarPage(),
    TeamRegistrationPage(),
    //TablaPosicionesScreen(),
    ListaEquiposPantalla(),
    TablaPosicionesScreen2()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add),
            label: 'Registro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Equipos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Tabla',
          ),
        ],
      ),
    );
  }
}

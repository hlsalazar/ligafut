import 'package:flutter/material.dart';
<<<<<<< HEAD
// import 'package:ligafut_app/View/inicio_seccion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ligafut_app/view/inicio_seccion.dart';
import 'package:ligafut_app/view/mostrar_equipos.dart';
=======
import 'package:firebase_core/firebase_core.dart';
import 'package:ligafut_app/view/CalendarPage.dart';
import 'package:ligafut_app/view/TeamRegistrationPage.dart';
import 'package:ligafut_app/view/inicio_seccion.dart';
>>>>>>> calendario_partidos
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navegación de Ejemplo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
<<<<<<< HEAD
      home: InicioSeccionPantalla(),
=======
      home:
          InicioSeccionPantalla(), // Mostrar la página de inicio de sesión primero
    );
  }
}

class InicioSesionPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Iniciar Sesión'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // Aquí puedes agregar la lógica para iniciar sesión
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NavigationPage()),
            );
          },
          child: Text('Iniciar Sesión'),
        ),
      ),
    );
  }
}

class NavigationPage extends StatefulWidget {
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    CalendarPage(),
    TeamRegistrationPage(),
    SettingsPage(),
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
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Calendario',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.playlist_add),
            label: 'Registro',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configuraciones',
          ),
        ],
      ),
    );
  }
}

class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Página de Configuraciones'),
>>>>>>> calendario_partidos
    );
  }
}

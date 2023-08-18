import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ligafut_app/view/CalendarPage.dart';
import 'package:ligafut_app/view/TeamRegistrationPage.dart';
import 'package:ligafut_app/view/inicio_seccion.dart';
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
      home: InicioSeccionPantalla(),
    );
  }
}

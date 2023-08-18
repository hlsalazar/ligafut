import 'package:flutter/material.dart';
// import 'package:ligafut_app/View/inicio_seccion.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:ligafut_app/view/mostrar_equipos.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListaEquiposPantalla(),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:farmacias/pantallas/inicio.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(inicioApp());
}

class inicioApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: inicio(),
    );
  }
}
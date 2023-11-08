import 'package:bamadamarket/pages/article.dart';
import 'package:bamadamarket/pages/home.dart';
import 'package:bamadamarket/pages/inscrire.dart';
import 'package:flutter/material.dart';
import 'package:bamadamarket/pages/bienvenue.dart'; // Importez la page de bienvenue que vous venez de créer
import 'package:bamadamarket/pages/connexion.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Définissez la route initiale sur la page de bienvenue
      initialRoute: '/bienvenue',
      routes: {
        '/bienvenue': (context) =>  Bienvenue(),
        '/connexion': (context) =>  Connexion(),
        '/inscrire': (context) =>  Inscrire(),
        '/home':(context)=> Home(),
        '/article':(context)=> Article(),
      },
    );
  }
}


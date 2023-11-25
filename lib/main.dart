
import 'package:bamadamarket/pages/Notification.dart';
import 'package:bamadamarket/pages/ajoutAnnonce.dart';
import 'package:bamadamarket/pages/article.dart';
import 'package:bamadamarket/pages/editProfilPage.dart';
import 'package:bamadamarket/pages/home.dart';
import 'package:bamadamarket/pages/inscrire.dart';
import 'package:bamadamarket/pages/mesArticles.dart';
import 'package:bamadamarket/services/commandeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:bamadamarket/pages/bienvenue.dart'; // Importez la page de bienvenue que vous venez de créer
import 'package:bamadamarket/pages/connexion.dart';
import 'package:provider/provider.dart';
void main() {
  runApp(ChangeNotifierProvider(
      create: (context) => CommandeNotifier(),
      child: MyApp(),
    ),
  );
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
        '/inscrire': (context) =>  Inscrire(context: context),
        '/home':(context)=> Home(),
        '/article':(context)=> Article(),
        '/ajoutAnnonce':(context)=>AjoutAnnonce(),
        '/mesArticles' :(context)=>MesArticles(),
        '/editProfilPage':(context)=>EditProfilPage(profileImageUrl: '',),
        '/notification' :(context)=>NotificationPage(),
      },
    );
  }
}



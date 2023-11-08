import 'package:flutter/material.dart';

class MessagesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat'), // Titre de la page
      ),
      body: Center(
        child: Text('Contenu de la page de chat'), // Contenu de la page d'accueil
      ),
    );
  }
}

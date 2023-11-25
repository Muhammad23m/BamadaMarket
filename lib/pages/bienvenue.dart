import 'package:flutter/material.dart';

class Bienvenue extends StatefulWidget {
  @override
  _BienvenueState createState() => _BienvenueState();
}

class _BienvenueState extends State<Bienvenue> {
  @override
  void initState() {
    super.initState();
    // Utilisez Future.delayed pour effectuer la navigation après 3 secondes
    Future.delayed(Duration(seconds: 3), () {
      // Naviguez vers la page de connexion
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Ajoutez ici votre logo d'application
            Image.asset('assets/images/logo.png'),
            Text('Trouvez ce que vous aimez, vendez ce que vous avez !'),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class Connexion extends StatefulWidget {
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  String pseudo = "";
  String motDePasse = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Aligner en haut
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 330,
              ),
              Card(
                elevation: 5, // Élévation du Card
                margin: EdgeInsets.all(7.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rayon des coins
                  side: BorderSide(color: Color(0xFFF53F26), width: 2.0), // Couleur de la bordure
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'pseudo',
                    filled: true,
                    fillColor: Color(0xFFFFFF), // Couleur de fond
                    border: InputBorder.none, // Supprimer la bordure du TextField
                    contentPadding: EdgeInsets.all(10.0), // Marge interne
                  ),
                  onChanged: (value) {
                    setState(() {
                      pseudo = value;
                    });
                  },
                ),
              ),
              Card(
                elevation: 5, // Élévation du Card
                margin: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Color(0xFFF53F26), width: 2.0),
                ),
                child: TextField(
                  obscureText: true, // Pour masquer le mot de passe
                  decoration: InputDecoration(
                    labelText: 'mot de passe',
                    filled: true,
                    fillColor: Color(0xFFFFFF),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(10.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      motDePasse = value;
                    });
                  },
                ),
              ),
              InkWell(
                onTap: () {
                  // Navigation vers la page d'inscription
                  Navigator.pushNamed(context, '/inscrire');
                },
                child: RichText(
                  text: TextSpan(
                    text: "n'avez-vous pas de compte? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Inscrivez-vous ici',
                        style: TextStyle(
                          color: Color(0xFFF53F26),
                          fontSize: 16.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 90.0),
               child: ElevatedButton(
                  onPressed: () {
                    // Ajoutez ici la logique de connexion
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFFF53F26), // Couleur de fond
                    fixedSize: Size(300, 50),  // Largeur et hauteur du bouton
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0), // Rayon des coins
                    ),
                  ),
                  child: Text(
                    'Connexion',
                    style: TextStyle(
                      color: Colors.white, // Couleur du texte
                      fontSize: 22.0, // Taille de la police du texte
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}

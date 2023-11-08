import 'package:flutter/material.dart';

class Inscrire extends StatefulWidget {
  @override
  _InscrireState createState() =>_InscrireState();
}

class _InscrireState extends State<Inscrire> {
  String nom = "";
  int contact = 0;
  String pseudo = "";
  String motDePasse = "";
  String confirmMotDePasse = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start, // Aligner en haut
            children: <Widget>[
              Image.asset(
                'assets/images/logo.png',
                width: 250,
              ),
              // nom
              Card(
                elevation: 5, // Élévation du Card
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rayon des coins
                  side: BorderSide(color: Color(0xFFF53F26), width: 1.0), // Couleur de la bordure
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'nom et prenom',
                    filled: true,
                    fillColor: Color(0xFFFFFF), // Couleur de fond
                    border: InputBorder.none, // Supprimer la bordure du TextField
                    contentPadding: EdgeInsets.all(7.0), // Marge interne
                  ),
                  onChanged: (value) {
                    setState(() {
                      pseudo = value;
                    });
                  },
                ),
              ),
              // contact
              Card(
                elevation: 5, // Élévation du Card
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Color(0xFFF53F26), width: 1.0),
                ),
                child: TextField(
                  obscureText: true, // Pour masquer le mot de passe
                  decoration: InputDecoration(
                    labelText: 'numero de telephone',
                    filled: true,
                    fillColor: Color(0xFFFFFF),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(7.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      motDePasse = value;
                    });
                  },
                ),
              ),
              // pseudo
              Card(
                elevation: 5, // Élévation du Card
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0), // Rayon des coins
                  side: BorderSide(color: Color(0xFFF53F26), width: 1.0), // Couleur de la bordure
                ),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'pseudo',
                    filled: true,
                    fillColor: Color(0xFFFFFF), // Couleur de fond
                    border: InputBorder.none, // Supprimer la bordure du TextField
                    contentPadding: EdgeInsets.all(7.0), // Marge interne
                  ),
                  onChanged: (value) {
                    setState(() {
                      pseudo = value;
                    });
                  },
                ),
              ),
              // mot de passe
              Card(
                elevation: 5, // Élévation du Card
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Color(0xFFF53F26), width: 1.0),
                ),
                child: TextField(
                  obscureText: true, // Pour masquer le mot de passe
                  decoration: InputDecoration(
                    labelText: 'mot de passe',
                    filled: true,
                    fillColor: Color(0xFFFFFF),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(7.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      motDePasse = value;
                    });
                  },
                ),
              ),
              // confirmer le mot de passe
              Card(
                elevation: 5, // Élévation du Card
                margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  side: BorderSide(color: Color(0xFFF53F26), width: 1.0),
                ),
                child: TextField(
                  obscureText: true, // Pour masquer le mot de passe
                  decoration: InputDecoration(
                    labelText: 'confirmer le mot de passe',
                    filled: true,
                    fillColor: Color(0xFFFFFF),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(7.0),
                  ),
                  onChanged: (value) {
                    setState(() {
                      motDePasse = value;
                    });
                  },
                ),
              ),

              Container(
                margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
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
                    'Inscription',
                    style: TextStyle(
                      color: Colors.white, // Couleur du texte
                      fontSize: 22.0, // Taille de la police du texte
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ),
              ),
              InkWell(
                onTap: () {
                  // Navigation vers la page d'inscription
                  Navigator.pushNamed(context, '/connexion');
                },
                child: RichText(
                  text: TextSpan(
                    text: "avez-vous dejà un compte? ",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.0,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: 'Connectez-vous ici',
                        style: TextStyle(
                          color: Color(0xFFF53F26),
                          fontSize: 16.0,
                        ),
                      ),
                    ],
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

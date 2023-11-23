import 'dart:convert';

import 'package:bamadamarket/pages/sessionManager.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Connexion extends StatefulWidget {
  @override
  _ConnexionState createState() => _ConnexionState();
}

class _ConnexionState extends State<Connexion> {
  String pseudo = "";
  String motDePasse = "";
  bool isLoading = false;

  Future<void> connecterUtilisateur() async {
    if (pseudo.isEmpty || motDePasse.isEmpty) {
      // Validation : Assurez-vous que les champs ne sont pas vides
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Champs obligatoires'),
            content: Text('Veuillez remplir tous les champs.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.post(
        Uri.parse('http://10.0.2.2:8080/utilisateur/login'),
        body: {
          'pseudo': pseudo,
          'motDePasse': motDePasse,
        },
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        var idUtilisateur = jsonResponse['idUtilisateur'].toInt();
        var sessionToken = jsonResponse['sessionToken'].toString();

        var sessionManager =
            SessionManager(await SharedPreferences.getInstance());
        await sessionManager.saveUserInfo(idUtilisateur,pseudo, sessionToken);

        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // La connexion a échoué, affichez le message d'erreur
        print('Échec de la connexion.');
        print(response.body);
      }
    } catch (e) {
      // Gérez les erreurs ici
      print('Erreur: $e');
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  width: 330,
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(7.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color(0xFFF53F26), width: 2.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'pseudo',
                      filled: true,
                      fillColor: Color(0xFFFFFF),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(10.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        pseudo = value;
                      });
                    },
                  ),
                ),
                Card(
                  elevation: 5,
                  margin: EdgeInsets.all(10.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color(0xFFF53F26), width: 2.0),
                  ),
                  child: TextField(
                    obscureText: true,
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
                    onPressed: isLoading ? null : connecterUtilisateur,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF53F26),
                      fixedSize: Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: isLoading
                        ? CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Text(
                            'Connexion',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

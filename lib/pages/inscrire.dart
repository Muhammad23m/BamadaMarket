import 'dart:convert';
import 'dart:ffi' as ffi; // Ou choisissez un autre nom significatif
import 'dart:io'; // Import the 'dart:io' library for File class
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart'; // Importez le package path
import 'package:bamadamarket/models/utilisateur.dart';

class Inscrire extends StatefulWidget {
  final BuildContext context;
  Inscrire({Key? key, required this.context}) : super(key: key);
  @override
  _InscrireState createState() => _InscrireState();
}

class _InscrireState extends State<Inscrire> {
  String nom = "";
  int contact = 0;
  String pseudo = "";
  String motDePasse = "";
  String confirmMotDePasse = "";
  File? image;

  String?
      imageUrl; // Ajoutez cette ligne pour stocker l'URL de l'image de profil

  Future<void> ajouterUtilisateur() async {
    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8080/utilisateur/create'),
      );

      final image = this.image;
      if (image != null) {
        List<int> imageBytes =
            await image.readAsBytes(); // Use readAsBytes method
        request.files.add(
          http.MultipartFile.fromBytes(
            'photo1',
            imageBytes,
            filename: basename(image.path),
          ),
        );
      }
      request.fields['utilisateur'] = jsonEncode({
        'nom': nom,
        'contact': contact.toString(),
        'pseudo': pseudo,
        'motDePasse': motDePasse,
        'image': "",
      });

      var response = await request.send();
      var responsed = await http.Response.fromStream(response);

      if (response.statusCode == 201) {
        final responseData = json.decode(responsed.body);
        debugPrint(responsed.body);
        Utilisateur utilisateur = Utilisateur.fromJson(responseData);

        setState(() {
          imageUrl = utilisateur
              .image;
        });
      } else {
        debugPrint(responsed.body);

        // Récupérez le message d'erreur du serveur
        final errorMessage = json.decode(responsed.body)['message'];

        // Affichez le message d'erreur à l'utilisateur
        showDialog(
          context: widget.context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Erreur d\'inscription'),
              content: Text(errorMessage),
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

        // Lève une exception avec le message d'erreur
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Gère toutes les autres exceptions
      debugPrint('Erreur: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 2.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Image.asset(
                  'assets/images/logo.png',
                  width: 250,
                ),
                // nom
                Card(
                  elevation: 5,
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 0.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color(0xFFF53F26), width: 1.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'nom et prenom',
                      filled: true,
                      fillColor: Color(0xFFFFFF),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(7.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        nom = value;
                      });
                    },
                  ),
                ),
                // contact
                Card(
                  elevation: 5,
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color(0xFFF53F26), width: 1.0),
                  ),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'numero de telephone',
                      filled: true,
                      fillColor: Color(0xFFFFFF),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(7.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        contact = int.tryParse(value) ?? 0;
                      });
                    },
                  ),
                ),
                // pseudo
                Card(
                  elevation: 5,
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color(0xFFF53F26), width: 1.0),
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: 'pseudo',
                      filled: true,
                      fillColor: Color(0xFFFFFF),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(7.0),
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
                  elevation: 5,
                  margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color(0xFFF53F26), width: 1.0),
                  ),
                  child: TextField(
                    obscureText: true,
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
                  elevation: 5,
                  margin: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 5.0, bottom: 5.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                    side: BorderSide(color: Color(0xFFF53F26), width: 1.0),
                  ),
                  child: TextField(
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: 'confirmer le mot de passe',
                      filled: true,
                      fillColor: Color(0xFFFFFF),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.all(7.0),
                    ),
                    onChanged: (value) {
                      setState(() {
                        confirmMotDePasse = value;
                      });
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20.0, bottom: 10.0),
                  child: ElevatedButton(
                    onPressed: () async {
                      await ajouterUtilisateur();
                      Navigator.pushNamed(context, '/connexion');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFF53F26),
                      fixedSize: const Size(300, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                    child: Text(
                      'Inscription',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, '/connexion');
                  },
                  child: RichText(
                    text: TextSpan(
                      text: "avez-vous déjà un compte? ",
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
      ),
    );
  }
}

import 'dart:convert';

import 'package:bamadamarket/models/articleModel.dart';
import 'package:bamadamarket/pages/sessionManager.dart';
import 'package:bamadamarket/services/commandeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:bamadamarket/models/utilisateur.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/commande.dart';

const d_green = Color(0xFFF53F26);

class ArticleDetailPage extends StatelessWidget {
  final ModeleArticle article;

  ArticleDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.titre),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.network("http://10.0.2.2${article.photo1}",
                height: 250, width: 450, fit: BoxFit.cover),
            Padding(
              padding: EdgeInsets.only(
                  left: 16.0,
                  top:
                      5.0), // Vous pouvez ajuster la valeur comme vous le souhaitez
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      article.titre,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 25.0,
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      article.prix.toString() + ' FCFA',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 19.0,
                        color: Colors.red
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Vos widgets existants ici

                      SizedBox(
                          height:
                              30.0), // Ajoutez un espace entre le contenu existant et les nouvelles informations

                      Text(
                        'Information du vendeur',
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                  'URL de la photo de profil'), // Remplacez par l'URL de la photo de profil du vendeur
                              radius: 30.0,
                            ),

                            SizedBox(
                                width:
                                    10.0), // Ajoutez un espace entre la photo de profil et le nom

                            Text(
                              article.utilisateur!
                                  .nom, // Remplacez par le nom du vendeur
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                                width:
                                    125.0), // Ajoutez un espace entre le nom et les boutons
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextButton(
                                  onPressed: () {
                                    // Code pour signaler le vendeur
                                  },
                                  child: Text(
                                    'Signaler',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                                TextButton(
                                  onPressed: () {
                                    // Code pour contacter le vendeur
                                  },
                                  child: Text(
                                    'Contacter',
                                    style: TextStyle(
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30.0,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 19.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(article.description)),
                  SizedBox(
                    height: 25.0,
                  ),
                  Row(
                    children: [
                      Text(
                        'Etat :',
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        width: 9.0,
                      ),
                      Text(article.etat),
                    ],
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              int quantite =
                                  1; // Définissez une quantité initiale
                              return AlertDialog(
                                title: Row(
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: d_green,
                                      size: 40.0,
                                    ), // Icône de commande
                                    Text(
                                      'Votre commande',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 23.0),
                                    ),
                                  ],
                                ),
                                content: StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          child: Row(
                                            children: [
                                              Text(
                                                article.titre,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0,
                                                ),
                                              ),
                                              SizedBox(
                                                width: 10.0,
                                              ),
                                              Text(
                                                '${article.prix * quantite}',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14.0,
                                                  color: d_green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text('Quantité',
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17.0,
                                                )),
                                            SizedBox(
                                              width: 15.0,
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text('$quantite',
                                                    style: TextStyle(
                                                        fontSize:
                                                            24.0)), // Affiche la quantité actuelle
                                                Column(
                                                  children: [
                                                    IconButton(
                                                      icon: Icon(Icons
                                                          .arrow_drop_up), // Icône arrow_drop_up
                                                      color: Colors
                                                          .green, // Couleur de l'icône
                                                      iconSize:
                                                          24.0, // Taille de l'icône
                                                      splashRadius:
                                                          20.0, // Rayon de l'effet de splash
                                                      onPressed: () {
                                                        setState(() {
                                                          quantite++; // Incrémente la quantité
                                                        });
                                                      },
                                                    ),
                                                    SizedBox(
                                                      height: 0,
                                                    ),
                                                    IconButton(
                                                      icon: Icon(Icons
                                                          .arrow_drop_down), // Icône arrow_drop_down
                                                      color: Colors
                                                          .red, // Couleur de l'icône
                                                      iconSize:
                                                          24.0, // Taille de l'icône
                                                      splashRadius:
                                                          20.0, // Rayon de l'effet de splash
                                                      onPressed: () {
                                                        setState(() {
                                                          if (quantite > 1) {
                                                            // Vérifie que la quantité est supérieure à 1 avant de la décrémenter
                                                            quantite--; // Décrémente la quantité
                                                          }
                                                        });
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    child: Text('Annuler'),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                  TextButton(
                                    child: Text('Confirmer'),
                                    onPressed: () async { // Rendez la fonction asynchrone
                                      // Récupérez le nom d'utilisateur
                                      SessionManager sessionManager = SessionManager(await SharedPreferences.getInstance());
                                      String? username = sessionManager.getPseudo();

                                      // Vérifiez si le nom d'utilisateur est null
                                      if (username == null) {
                                        // Gérez l'erreur ici
                                        return;
                                      }
                                  
                                      Commande commande = Commande(utilisateur: username, quantite:quantite, titre: article.titre);
                                      
                                      // Ajoutez la commande à CommandeNotifier
                                      Provider.of<CommandeNotifier>(context, listen: false).ajouterCommande(commande);
                                      
                                      // Fermez la boîte de dialogue
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          primary:
                              d_green, // changez ceci à la couleur que vous voulez
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Text(
                          'Commander',
                          style: TextStyle(
                            fontSize: 21.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 14.0,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Ici, vous pouvez gérer la soumission du formulaire
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors
                              .white38, // changez ceci à la couleur que vous voulez
                          padding: EdgeInsets.symmetric(
                              vertical: 8.0, horizontal: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                        child: Icon(
                          Icons.favorite_border,
                          color: d_green,
                          size: 30.0,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 14.0,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

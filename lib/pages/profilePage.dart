import 'package:bamadamarket/pages/sessionManager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

const d_green = Color(0xFFF53F26);

class ProfilePage extends StatefulWidget {
  final String profileImageUrl;

  const ProfilePage({Key? key, required this.profileImageUrl})
      : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String? pseudo;

  @override
  void initState() {
    super.initState();
    loadPseudo();
  }

  Future<void> loadPseudo() async {
    var sessionManager = SessionManager(await SharedPreferences.getInstance());
    var loadedPseudo = sessionManager.getPseudo();

    setState(() {
      pseudo = loadedPseudo;
    });
  }

  Future<void> deconnexion(BuildContext context) async {
    var sessionManager = SessionManager(
        await SharedPreferences.getInstance() as SharedPreferences);
    sessionManager.logout();

    Navigator.pushReplacementNamed(context, '/connexion');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: d_green,
        toolbarHeight: 180.0,
        title: Stack(
          children: [
            Align(
              alignment:
                  Alignment.bottomCenter, // Aligner le cercle en bas à droite
              child: Padding(
                padding: const EdgeInsets.only(
                    right: 16.0, bottom: 16.0), // Ajuster la position du cercle
                child: Column(
                  children: [
                    CircleAvatar(
                      radius:
                          50.0, // Ajuster le rayon du cercle selon vos besoins
                      backgroundImage: widget.profileImageUrl.isNotEmpty
                          ? NetworkImage(widget.profileImageUrl)
                              as ImageProvider<Object>?
                          : const AssetImage('assets/images/bazin.png'),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      pseudo ??
                          'Pseudo non disponible', // Affiche le pseudo, ou 'Pseudo non disponible' si le pseudo est null
                      style: TextStyle(
                          fontSize:
                              20.0, // Ajustez la taille du texte selon vos besoins
                          color: Colors.white,
                          fontWeight: FontWeight
                              .bold // Ajustez la couleur du texte selon vos besoins
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/mesProduits');
            },
            child: Container(
              margin: EdgeInsets.only(left: 10.0, top: 80.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.shop_2, color: Colors.red, size: 40.0),
                      SizedBox(width: 18.0),
                      Text("Voir mes produits", style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                  Divider(
                    // Ajoute une barre horizontale en dessous de la ligne
                    color: Colors.black,
                    thickness: 0.5, // Épaisseur de la barre
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, top: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.edit, color: Colors.red, size: 40.0),
                    SizedBox(width: 18.0),
                    Text("Modifier votre profile",
                        style: TextStyle(fontSize: 20.0)),
                  ],
                ),
                Divider(
                  // Ajoute une barre horizontale en dessous de la ligne
                  color: Colors.black,
                  thickness: 0.5, // Épaisseur de la barre
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, top: 20.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Icon(Icons.delete, color: Colors.red, size: 40.0),
                    SizedBox(width: 18.0),
                    Text("Supprimer votre profile",
                        style: TextStyle(fontSize: 20.0)),
                  ],
                ),
                Divider(
                  // Ajoute une barre horizontale en dessous de la ligne
                  color: Colors.black,
                  thickness: 0.5, // Épaisseur de la barre
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10.0, top: 20.0),
            child: InkWell(
              onTap: () {
                // Ajoutez votre logique de déconnexion ici
                deconnexion(context);
              },
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(Icons.logout, color: Colors.red, size: 40.0),
                      SizedBox(width: 18.0),
                      Text("Deconnexion", style: TextStyle(fontSize: 20.0)),
                    ],
                  ),
                  Divider(
                    // Ajoute une barre horizontale en dessous de la ligne
                    color: Colors.black,
                    thickness: 0.5, // Épaisseur de la barre
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

const d_green = Color(0xFFF53F26);

class ProfilePage extends StatelessWidget {
  final String profileImageUrl;

  const ProfilePage({Key? key, required this.profileImageUrl})
      : super(key: key);

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
                child: CircleAvatar(
                  radius: 50.0, // Ajuster le rayon du cercle selon vos besoins
                  backgroundImage: profileImageUrl.isNotEmpty
                      ? NetworkImage(profileImageUrl) as ImageProvider<Object>?
                      : const AssetImage('assets/images/bazin.png'),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
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
        ],
      ),
    );
  }
}

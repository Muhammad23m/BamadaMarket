import 'package:bamadamarket/models/commande.dart';
import 'package:bamadamarket/services/commandeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


const d_green = Color(0xFFF53F26);


class NotificationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body:Consumer<CommandeNotifier>(
  builder: (context, commandeNotifier, child) {
    return ListView.builder(
      itemCount: commandeNotifier.commandes.length,
      itemBuilder: (context, index) {
        Commande commande = commandeNotifier.commandes[index];
        return Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(width: 1.0, color: Colors.grey), // Ajoute une bordure en bas
            ),
          ),
          child: ListTile(
            title: RichText(
              text: TextSpan(
                text: "${commande.utilisateur} a lancé une commande : ${commande.quantite}, ${commande.titre}. ",
                style: DefaultTextStyle.of(context).style,
                children: <TextSpan>[
                  TextSpan(
                    text: "Contactez-le",
                    style: TextStyle(color: d_green), // Donne une couleur d_green au texte "Contactez-le"
                  ),
                  TextSpan(
                    text: " pour plus de détails.",
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  },
),
    );
  }
}
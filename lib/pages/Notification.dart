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
      body: Consumer<CommandeNotifier>(
        builder: (context, commandeNotifier, child) {
          return ListView.builder(
            itemCount: commandeNotifier.commandes.length,
            itemBuilder: (context, index) {
              Commande commande = commandeNotifier.commandes[index];
              return ListTile(
                title: Text("${commande.utilisateur} a lancé une commande : ${commande.quantite}, ${commande.titre}. Contactez-le pour plus de détails."),
              );
            },
          );
        },
      ),
    );
  }
}
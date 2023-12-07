import 'package:bamadamarket/models/commande.dart';
import 'package:flutter/material.dart';

class CommandeNotifier extends ChangeNotifier {
  List<Commande> _commandes = [];

  List<Commande> get commandes => _commandes;

  void ajouterCommande(Commande commande) {
    _commandes.add(commande);
    notifyListeners();
  }
}

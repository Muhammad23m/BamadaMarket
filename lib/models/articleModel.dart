import 'package:bamadamarket/models/utilisateur.dart';

class ModeleArticle {
  final int? idAnnonce;
  final String titre;
  final int prix;
  final String description;
  final String photo1;
  final String etat;
  final Utilisateur? utilisateur; // Rendez l'utilisateur optionnel

  ModeleArticle({
    required this.titre,
    required this.prix,
    required this.description,
    required this.photo1,
    required this.etat,
    this.utilisateur,
    this.idAnnonce, // L'utilisateur est maintenant optionnel
  });

  factory ModeleArticle.fromJson(Map<String, dynamic> json) {
    return ModeleArticle(
      titre: json['titre'],
      prix: json['prix'],
      description: json['description'],
      photo1: json['photo1'],
      etat: json['etat'],
      utilisateur: json['utilisateur'] != null
          ? Utilisateur.fromJson(json['utilisateur'])
          : null, // Vérifiez si l'utilisateur est null avant de l'extraire
      idAnnonce: json['idAnnonce'], // L'utilisateur est maintenant optionnel
    );
  }
}

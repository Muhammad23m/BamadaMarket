class Commande {
  final String? utilisateur;
  final int? id;
  final int? quantite;
  final int? prix;
  final String? titre;
  final String? photo;
  final DateTime? dateCommande;

  Commande({
    this.utilisateur,
    this.id,
    this.quantite,
    this.prix,
    this.titre,
    this.photo,
    this.dateCommande,
  });

  factory Commande.fromJson(Map<String, dynamic> json) {
    return Commande(
      quantite: json['quantite'],
      prix: json['prix'],
      titre: json['titre'],
      photo: json['photo'],
      dateCommande: DateTime.parse(json['dateCommande']),
    );
  }
}

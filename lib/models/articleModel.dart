class ModeleArticle {
  final String titre;
  final String prix;
  final String description;
  final String photo1;

  ModeleArticle(
      {required this.titre,
      required this.prix,
      required this.description,
      required this.photo1});

  factory ModeleArticle.fromJson(Map<String, dynamic> json) {
    return ModeleArticle(
      titre: json['titre'],
      prix: json['prix'],
      description: json['description'],
      photo1: json['photo1'],
    );
  }
}

class Utilisateur {
  String nom;
  int contact;
  String pseudo;
  String motDePasse;
  String image;

  Utilisateur({
    required this.nom,
    required this.contact,
    required this.pseudo,
    required this.motDePasse,
    required this.image,
  });

  factory Utilisateur.fromJson(Map<String, dynamic> json) {
    return Utilisateur(
      nom: json['nom'],
      contact: json['contact'],
      pseudo: json['pseudo'],
      motDePasse: json['motDePasse'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nom': nom,
      'contact': contact,
      'pseudo': pseudo,
      'motDePasse': motDePasse,
      'image': image,
    };
  }
}

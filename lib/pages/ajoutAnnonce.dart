import 'dart:convert';
import 'dart:io';
import 'package:bamadamarket/pages/sessionManager.dart';
import 'package:http/http.dart' as http;
import 'package:bamadamarket/services/imagePickerService.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

const d_green = Color(0xFFF53F26);
File? _selectedImage;

class AjoutAnnonce extends StatefulWidget {
  @override
  _AjoutAnnonceState createState() => _AjoutAnnonceState();
}

class _AjoutAnnonceState extends State<AjoutAnnonce> {
  final _formKey = GlobalKey<FormState>(); // Ajout de la clé _formKey
  ImagePickerService _imagePickerService = ImagePickerService();
  String _titre = "";
  String _prix = "";
  String _description = "";
  String _etat = "Neuf"; // Valeur par défaut pour le champ d'état

  TextEditingController _titreController = TextEditingController();
  TextEditingController _prixController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  TextEditingController _etatController = TextEditingController();

  Future<void> ajouterAnnonce(BuildContext context) async {

  var sessionManager = SessionManager(await SharedPreferences.getInstance());
  var idUtilisateur = sessionManager.getidUtilisateur();

  if (idUtilisateur == null) {
    throw Exception('Utilisateur non connecté');
  }
  

    try {
      var request = http.MultipartRequest(
        'POST',
        Uri.parse('http://10.0.2.2:8080/annonce/create'),
      );

      final image = _selectedImage;
      if (image != null) {
        List<int> imageBytes =
            await image.readAsBytes(); // Use readAsBytes method
        request.files.add(
          http.MultipartFile.fromBytes(
            'photo1',
            imageBytes,
            filename: basename(image.path),
          ),
        );
      }
      request.fields['annonce'] = jsonEncode({
        'titre': _titreController.text,
        'prix': _prixController.text,
        'description': _descriptionController.text,
        'etat': _etat,
        'utilisateur': {
        'idUtilisateur': idUtilisateur,
       },
      });

      var response = await request.send();
      var responsed = await http.Response.fromStream(response);

      if (response.statusCode == 201) {
        final responseData = json.decode(responsed.body);
        debugPrint(responsed.body);
        // Traitez la réponse ici

        // Réinitialisez tous les champs du formulaire et l'image
        _titreController.clear();
        _prixController.clear();
        _descriptionController.clear();
        setState(() {
          _selectedImage = null;
  });

  // Affichez un SnackBar pour informer l'utilisateur que l'insertion a réussi
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Insertion réussie'),
      duration: Duration(seconds: 2),
    ),
  );
      } else {
        debugPrint(responsed.body);

        // Récupérez le message d'erreur du serveur
        final errorMessage = json.decode(responsed.body)['message'];

        // Lève une exception avec le message d'erreur
        throw Exception(errorMessage);
      }
    } catch (e) {
      // Gère toutes les autres exceptions
      debugPrint('Erreur: $e');
    }
  }

  Widget _buildImagePicker() {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        border: Border.all(color: d_green, width: 2.0),
        borderRadius: BorderRadius.circular(6.0),
      ),
      margin:
          EdgeInsets.only(left: 150.0, right: 150.0, bottom: 30.0, top: 10.0),
      child: _selectedImage != null
          ? Image.file(
              _selectedImage!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            )
          : GestureDetector(
              onTap: () async {
                final pickedFile = await _imagePickerService.pickImage();

                if (pickedFile != null) {
                  setState(() {
                    _selectedImage = pickedFile;
                  });
                } else {
                  print('No image selected.');
                }
              },
              child: Center(
                child: Icon(
                  Icons.image,
                  size: 40.0,
                  color: d_green,
                ),
              ),
            ),
    );
  }

  Container _buildTextField(String label, String hintText,
      TextEditingController controller, bool isMultiline) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        controller: controller,
        maxLines: isMultiline ? 3 : 1,
        decoration: InputDecoration(
          labelText: label,
          hintText: hintText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: d_green, width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          contentPadding: EdgeInsets.all(12.0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Veuillez entrer $label';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: d_green,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: 80), // Espace entre l'icône et le texte
            Text(
              'Nouvelle annonce',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body:SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              _buildImagePicker(), // Utilisation de la fonction pour créer l'icône d'image

              // Champ de titre
              _buildTextField('Titre', 'Entrez le titre de votre annonce',
                  _titreController, false),

              // Champ de prix
              _buildTextField('Prix', 'Entrez le prix de votre annonce',
                  _prixController, false),

              // Champ de description
              _buildTextField(
                  'Description',
                  'Entrez la description de votre annonce',
                  _descriptionController,
                  true),

              // Champ de sélection pour l'état (Neuf ou Occasion)
              DropdownButtonFormField<String>(
                value: _etat,
                items: <String>['Neuf', 'Occasion']
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _etat = newValue!;
                  });
                },
                decoration: InputDecoration(
                  labelText: 'État',
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: d_green, width: 2.0),
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                  contentPadding: EdgeInsets.all(12.0),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Veuillez sélectionner un état';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.0), // Espace en bas

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Valider le formulaire
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();

                        // Ajoutez ici la logique pour traiter les données du formulaire
                        // Vous pouvez utiliser les valeurs de _titre, _prix, _description, _etat
                        ajouterAnnonce(context);
                        // Réinitialiser le formulaire après la soumission
                        _formKey.currentState!.reset();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      primary: d_green, // Couleur d_green
                      onPrimary: Colors.white, // Texte en blanc
                      padding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 10.0), // Taille du bouton
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    child: Text(
                      'Enregistrer',
                      style: TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AjoutAnnonce(),
  ));
}

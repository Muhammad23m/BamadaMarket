import 'dart:io';

import 'package:bamadamarket/pages/sessionManager.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

const d_green = Color(0xFFF53F26);

class EditProfilPage extends StatefulWidget {
  final String profileImageUrl;

  const EditProfilPage({Key? key, required this.profileImageUrl})
      : super(key: key);

  @override
  _EditProfilPageState createState() => _EditProfilPageState();
}

class _EditProfilPageState extends State<EditProfilPage> {
  String? pseudo;
  File? _imageFile;

// Ajoutez des contrôleurs pour chaque champ du formulaire
  final _nameController = TextEditingController();
  final _pseudoController = TextEditingController();
  final _contactController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadPseudo();
  }

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _imageFile = File(image!.path);
    });
  }

  Future<void> loadPseudo() async {
    var sessionManager = SessionManager(await SharedPreferences.getInstance());
    var loadedPseudo = sessionManager.getPseudo();

    setState(() {
      pseudo = loadedPseudo;
    });
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
    ImageProvider<Object>? imageProvider;

    if (_imageFile != null) {
      imageProvider = FileImage(_imageFile!);
    } else if (widget.profileImageUrl.isNotEmpty) {
      imageProvider = NetworkImage(widget.profileImageUrl);
    } else {
      imageProvider = const AssetImage('assets/images/bazin.png');
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: d_green,
        toolbarHeight: 180.0,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Stack(
          children: [
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(right: 16.0, bottom: 16.0),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        radius: 50.0,
                        backgroundImage: imageProvider,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      pseudo ?? 'Pseudo non disponible',
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(29.0),
          child: Form(
            child: Column(
              children: [
                _buildTextField(
                  'Nom et Prénom',
                  'Entrez votre nom et prénom',
                  _nameController,
                  false,
                ),
                _buildTextField(
                  'Pseudo',
                  'Entrez votre pseudo',
                  _pseudoController,
                  false,
                ),
                _buildTextField(
                  'Contact',
                  'Entrez votre contact',
                  _contactController,
                  false,
                ),
                _buildTextField(
                  'Mot de Passe',
                  'Entrez votre mot de passe',
                  _passwordController,
                  false,
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Ici, vous pouvez gérer la soumission du formulaire
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors
                            .red, // changez ceci à la couleur que vous voulez
                      ),
                      child: Text(
                        'Modifier',
                        style: TextStyle(
                          fontSize: 19.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

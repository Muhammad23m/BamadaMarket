import 'package:bamadamarket/pages/ajoutAnnonce.dart';
import 'package:bamadamarket/pages/profilePage.dart';
import 'package:flutter/material.dart';

import 'accueilPage.dart';
import 'favorisPage.dart';
import 'messagesPage.dart';

class Home extends StatefulWidget {
  const Home({Key? key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0; // Index de l'onglet sélectionné
  PageController _pageController = PageController(); // Contrôleur de la page

  @override
  void dispose() {
    _pageController.dispose(); // Libère le contrôleur de la page lorsque le widget est supprimé
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Met à jour l'index de l'onglet sélectionné
      _pageController.jumpToPage(index); // Fait glisser le PageView à la page correspondante
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController, // Utilise le contrôleur de la page
        children: <Widget>[
             AccueilPage(), // Page d'accueil
             MessagesPage(), // Page de messages
             FavorisPage(), // Page de favoris
             ProfilePage(profileImageUrl: '',), // Page de profil
        ],
        onPageChanged: (index) {
          _onItemTapped(index); // Met à jour l'index lorsqu'une nouvelle page est affichée
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed, // Affiche tous les éléments en permanence
        items: const <BottomNavigationBarItem>[
          // Définit les éléments de la barre de navigation
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Color(0xFF898888)),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.chat, color: Color(0xFF898888)),
            label: 'Messages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Color(0xFF898888)),
            label: 'Favoris',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Color(0xFF898888)),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex, // Index de l'élément sélectionné
        selectedItemColor: Colors.amber[800], // Couleur de l'élément sélectionné
        onTap: _onItemTapped, // Appelé lorsque l'utilisateur appuie sur un élément de la barre de navigation
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) =>AjoutAnnonce()),
          );
        },
        backgroundColor: Color(0xFFF53F26), // Couleur de fond du bouton
        child: Icon(
          Icons.add,
          color: Colors.white, // Couleur de l'icône du bouton
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

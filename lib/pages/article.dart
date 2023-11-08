import 'package:flutter/material.dart';



const d_green = Color(0xFFF53F26);
class Article extends StatelessWidget {
  const Article({super.key});

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       backgroundColor: Colors.white,
         title: Row(
           children: [
             GestureDetector(
               onTap: () {
                 Navigator.pop(context);
               },
               child: Container(
                 width: 36, // Largeur du conteneur
                 height: 36, // Hauteur du conteneur

                 child: Center(
                   child: Icon(
                     Icons.arrow_back,
                     color: d_green,
                   ),
                 ),
               ),
             ),
             SizedBox(
                 width: 95), // Espace entre le bouton de retour et le texte
             Text(
               'Tous les Articles', // Texte "Budget"
               style: TextStyle(
                 color: Colors.black, // Couleur du texte "Budget"
                 fontSize: 16.0, // Taille de la police
                 fontWeight: FontWeight.bold, // Épaisseur de la police
               ),
             ),
           ],
         ),
     ),
     body: Column(
       children: [
         BlackBorderSearchBar(),
       ],
     ),
   );
  }

}


class BlackBorderSearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearchPressed;

  BlackBorderSearchBar({this.onChanged, this.onSearchPressed});

  @override
  _BlackBorderSearchBarState createState() => _BlackBorderSearchBarState();
}

class _BlackBorderSearchBarState extends State<BlackBorderSearchBar> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
          margin: EdgeInsets.all(12.0),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black, width: 1.0), // Bordure noire
            borderRadius: BorderRadius.circular(3.0), // Bordure arrondie
          ),
          child: Row(

            children: [
              Expanded(
               child: Padding(
                  padding: const EdgeInsets.only(left:8.0),
                 child: TextField(
                  controller: _textEditingController,
                  onChanged: widget.onChanged,
                  decoration: InputDecoration(
                    hintText: "Recherche un article...", // Texte d'indications
                    border: InputBorder.none, // Pas de bordure
                  ),
                ),
              ),
              ),
              IconButton(
                icon: Icon(Icons.search),
                onPressed: widget.onSearchPressed,
              ),
            ],
          ),
    );
  }
}


import 'package:bamadamarket/pages/Notification.dart';
import 'package:flutter/material.dart';
import 'package:bamadamarket/pages/article.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:provider/provider.dart';

const d_green = Color(0xFFF53F26);

class AccueilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: 150,
        backgroundColor: d_green,
        title: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'BAMADA MARKET',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 35.0,
                  color: Colors.white,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: SearchBar(),
                ),
                IconButton(
                  icon: Icon(Icons.shopping_cart,
                      color: Colors.white, size: 32.0),
                  onPressed: () {
                    // Action à effectuer lors du clic sur l'icône du panier
                  },
                ),
                IconButton(
                  icon: Icon(Icons.notifications,
                      color: Colors.white, size: 32.0),
                  onPressed: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NotificationPage()),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          MyCarousel(),
          Container(
            margin: EdgeInsets.only(left: 8.0, right: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    'Articles Recents',
                    style:
                        TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(width: 5),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              Article()), // Remplacez "ArticlesPage" par la classe de votre page d'articles
                    );
                  },
                  child: Text(
                    'Tous les articles',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14.0,
                      color: Color(0xFFF53F26),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SearchBar extends StatefulWidget {
  final ValueChanged<String>? onChanged;
  final VoidCallback? onSearchPressed;

  SearchBar({this.onChanged, this.onSearchPressed});

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4, // Niveau d'élévation
      margin: EdgeInsets.only(top: 25.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0), // Bordure arrondie
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 6.0, left: 5.0),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                controller: _textEditingController,
                onChanged: widget.onChanged,
                decoration: InputDecoration(
                  hintText: "Recherche...", // Texte d'indications
                  border: InputBorder.none, // Pas de bordure
                ),
              ),
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: widget.onSearchPressed,
            ),
          ],
        ),
      ),
    );
  }
}

class CarouselModel extends ChangeNotifier {
  int currentIndex = 0;

  void updateIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

class MyCarousel extends StatelessWidget {
  final List<String> imagePaths = [
    'assets/images/Chaussures.png',
    'assets/images/Vetements.png',
    'assets/images/Casques.png',
    'assets/images/Voitures.png',
    // Ajoutez d'autres chemins d'image au besoin
  ];

  final CarouselController buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CarouselModel>(
      create: (context) => CarouselModel(),
      child: Column(
        children: [
          CarouselSlider(
            items: imagePaths.map((imagePath) {
              return Image.asset(
                imagePath,
                fit: BoxFit.cover,
              );
            }).toList(),
            options: CarouselOptions(
              aspectRatio: 16 / 9,
              height: 250,
              viewportFraction: 1.0,
              enableInfiniteScroll: true,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 4),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                final carouselModel =
                    Provider.of<CarouselModel>(context, listen: false);
                carouselModel.updateIndex(index);
              },
            ),
            carouselController: buttonCarouselController,
          ),
          Consumer<CarouselModel>(
            builder: (context, carouselModel, child) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: imagePaths.map((imagePath) {
                  int index = imagePaths.indexOf(imagePath);
                  return Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: carouselModel.currentIndex == index
                          ? Colors.red
                          : Colors.green,
                    ),
                  );
                }).toList(),
              );
            },
          ),
        ],
      ),
    );
  }
}

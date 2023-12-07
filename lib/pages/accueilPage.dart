import 'dart:convert';
import 'package:bamadamarket/models/articleModel.dart';
import 'package:bamadamarket/pages/Notification.dart';
import 'package:bamadamarket/pages/articleDetailPage.dart';
import 'package:bamadamarket/pages/commandePage.dart';
import 'package:bamadamarket/services/commandeNotifier.dart';
import 'package:flutter/material.dart';
import 'package:bamadamarket/pages/article.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

const d_green = Color(0xFFF53F26);

class AccueilPage extends StatelessWidget {
  Future<List<ModeleArticle>> fetchArticles() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/annonce/lire'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse
          .map((item) => ModeleArticle.fromJson(item))
          .toList()
          .reversed
          .take(4)
          .toList();
    } else {
      throw Exception('Erreur lors du chargement des articles');
    }
  }

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
                Padding(
                  padding: EdgeInsets.only(top: 22.0),
                  child: IconButton(
                    icon: Icon(Icons.shopping_cart,
                        color: Colors.white, size: 32.0),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => CommandePage()),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 22.0),
                  child: Stack(
                    children: <Widget>[
                      IconButton(
                        icon: Icon(Icons.notifications,
                            color: Colors.white, size: 32.0),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationPage()),
                          );
                        },
                      ),
                      Positioned(
                        right: 0,
                        child: Container(
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors
                                .white, // Change la couleur de fond en blanc
                            shape: BoxShape.circle,
                          ),
                          constraints: BoxConstraints(
                            minWidth: 12,
                            minHeight: 12,
                          ),
                          child: Consumer<CommandeNotifier>(
                            builder: (context, commandeNotifier, child) {
                              return Text(
                                '${commandeNotifier.commandes.length}', // Affiche le nombre de notifications
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
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
          Expanded(
            child: FutureBuilder<List<ModeleArticle>>(
              future: fetchArticles(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Erreur: ${snapshot.error}');
                } else {
                  return ArticleGridView(articles: snapshot.data!);
                }
              },
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

class MyCarousel extends StatefulWidget {
  @override
  _MyCarouselState createState() => _MyCarouselState();
}

class _MyCarouselState extends State<MyCarousel> {
  final List<String> imagePaths = [
    'assets/images/Chaussures.png',
    'assets/images/Vetements.png',
    'assets/images/Casques.png',
    'assets/images/Voitures.png',
    // Ajoutez d'autres chemins d'image au besoin
  ];

  final CarouselController buttonCarouselController = CarouselController();
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: Alignment.bottomCenter,
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
                  setState(() {
                    currentIndex = index;
                  });
                },
              ),
              carouselController: buttonCarouselController,
            ),
            Positioned(
              bottom: 0.0,
              child: Row(
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
                      color: currentIndex == index
                          ? const Color.fromARGB(255, 231, 27, 12)
                          : Color.fromARGB(255, 6, 217, 13),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ArticleGridView extends StatelessWidget {
  final List<ModeleArticle> articles;

  ArticleGridView({required this.articles});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 500,
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        itemCount: articles.length,
        itemBuilder: (context, index) {
          final article = articles[index];
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArticleDetailPage(article: article),
                ),
              );
            },
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Image.network(
                          "http://10.0.2.2${article.photo1}",
                          height: 177,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 100.0),
                          child: Text(
                            article.titre,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

import 'package:bamadamarket/pages/articleDetailPage.dart';
import 'package:flutter/material.dart';
import 'package:bamadamarket/models/articleModel.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

const d_green = Color(0xFFF53F26);

class Article extends StatelessWidget {
  Future<List<ModeleArticle>> fetchArticles() async {
    final response =
        await http.get(Uri.parse('http://10.0.2.2:8080/annonce/lire'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);

      return jsonResponse
          .map((item) => ModeleArticle.fromJson(item))
          .toList()
          .reversed
          .toList();
    } else {
      throw Exception('Erreur lors du chargement des articles');
    }
  }

  Article({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: d_green,
          ),
        ),
        title: Row(
          children: [
            SizedBox(width: 95), // Espace entre l'icône et le texte
            Text(
              'Tous les Articles',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          BlackBorderSearchBar(),
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
    return Container(
      margin: EdgeInsets.all(12.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black, width: 1.0), // Bordure noire
        borderRadius: BorderRadius.circular(3.0), // Bordure arrondie
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
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

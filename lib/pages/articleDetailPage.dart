import 'package:bamadamarket/models/articleModel.dart';
import 'package:flutter/material.dart';
class ArticleDetailPage extends StatelessWidget {
  final ModeleArticle article;

  ArticleDetailPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(article.titre),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Image.network(article.photo1),
            Text(article.titre),
            Text(article.prix),
            Text(article.description),
          ],
        ),
      ),
    );
  }
}
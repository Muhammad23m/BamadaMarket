import 'dart:convert';
import 'package:bamadamarket/pages/accueilPage.dart';
import 'package:http/http.dart' as http;
import 'package:bamadamarket/models/commande.dart';
import 'package:bamadamarket/pages/sessionManager.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<List<Commande>> fetchCommande() async {
  var sessionManager = SessionManager(await SharedPreferences.getInstance());
  var userId = sessionManager.getidUtilisateur();
  final response = await http
      .get(Uri.parse('http://10.0.2.2:8080/commande/utilisateur/$userId'));
  if (response.statusCode == 200 || response.statusCode == 201) {
    List jsonResponse = json.decode(response.body);
    return jsonResponse.map((item) => Commande.fromJson(item)).toList();
  } else {
    print(json.decode(response.body));
    throw Exception('Erreur lors du chargement des Commande');
  }
}

class CommandePage extends StatefulWidget {
  @override
  _CommandePageState createState() => _CommandePageState();
}

class _CommandePageState extends State<CommandePage> {
  Future<List<Commande>>? _commandeFuture;

  @override
  void initState() {
    super.initState();
    _commandeFuture = fetchCommande();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes Commande',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: FutureBuilder<List<Commande>>(
        future: _commandeFuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Card(
                      child: ListTile(
                        title: Text(snapshot.data![index].titre ?? '',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            RichText(
                              text: TextSpan(
                                text: 'Quantité: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${snapshot.data![index].quantite}',
                                      style: TextStyle(color: d_green)),
                                ],
                              ),
                            ),
                            RichText(
                              text: TextSpan(
                                text: 'Prix: ',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                children: <TextSpan>[
                                  TextSpan(
                                      text: '${snapshot.data![index].prix}',
                                      style: TextStyle(color: d_green)),
                                ],
                              ),
                            ),
                          ],
                        ),
                        leading: Image.network('http://10.0.2.2' +
                            (snapshot.data![index].photo ?? '')),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      child: IconButton(
                        tooltip: "Annuler la commande",
                        icon: Icon(Icons.close),
                        onPressed: () async {
                          final url = Uri.parse(
                              'http://10.0.2.2:8080/commande/${snapshot.data![index].id}');
                          final response = await http.delete(url);

                          if (response.statusCode == 200) {
                            setState(() {
                              snapshot.data!.removeAt(index);
                            });
                          } else {
                            // Gérer l'erreur
                          }
                        },
                      ),
                    ),
                  ],
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // Par défaut, affichez un spinner de chargement.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}

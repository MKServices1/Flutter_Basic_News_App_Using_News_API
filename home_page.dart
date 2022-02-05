import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Model? model;
  List<Articles>? articles;

  //API FUNCTION
  Future<void> getDataFromApi() async {
    final response = await http.get(Uri.parse(
        "https://newsapi.org/v2/top-headlines?country=us&category=business&apiKey=f223fb7cde844caa81b3352d45062093"));

    model = Model.fromJson(jsonDecode(response.body));
    setState(() {
      articles = model!.articles;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDataFromApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          title: RichText(
            text: const TextSpan(children: [
              TextSpan(
                  text: "Banana",
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: 24,
                      fontWeight: FontWeight.w800)),
              TextSpan(
                  text: 'News',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w500))
            ]),
          ),
        ),
        body: articles == null
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView.builder(
                itemCount: articles!.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        articles![index].urlToImage == null
                            ? Container(
                                width: 300,
                                height: 50,
                                margin:
                                    const EdgeInsets.symmetric(vertical: 18),
                                color: Colors.red.withOpacity(0.1),
                                child:
                                    const Center(child: Text("Loading Failed")),
                              )
                            : Card(
                                child: Image.network(
                                    articles![index].urlToImage.toString()),
                              ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                                text: "Title ",
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: articles![index].title,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300)),
                          ]),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                                text: "CONTENT ",
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: articles![index].content,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300)),
                          ]),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        RichText(
                          text: TextSpan(children: [
                            const TextSpan(
                                text: "DESCRIPTION ",
                                style: TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w800)),
                            TextSpan(
                                text: articles![index].description,
                                style: const TextStyle(
                                    fontSize: 15, fontWeight: FontWeight.w300)),
                          ]),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  );
                }));
  }
}

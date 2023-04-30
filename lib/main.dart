// ignore_for_file: prefer_const_constructors, non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:requests/requests.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:convert';

var result_json = [];
List title_list = [];
List id_list = [];
List poster_path_list = [];
List overview_list = [];

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
  }

  _getMovies() async {
    String movie_title = text_controller.text;
    movie_title = movie_title.replaceAll(" ", "+");
    title_list = [];
    id_list = [];
    poster_path_list = [];
    overview_list = [];

    var r = await Requests.get(
        "https://api.themoviedb.org/3/search/movie?api_key=87d5585a5497b373679e8bdc7d6f0d22&query=$movie_title");

    String string_result = r.content();
    Map<String, dynamic> json_string = json.decode(string_result);

    result_json = json_string['results'];

    setState(() {
      for (var i = 0; i < result_json.length; i++) {
        Map<String, dynamic> a = result_json[i];
        title_list.add(a['title']);
        id_list.add(a['id']);
        poster_path_list.add(a['poster_path']);
        overview_list.add(a['overview']);
      }

      // print(title_list);
      // print(id_list);
      // print(poster_path_list);
      // print(overview_list);
    });
  }

  _playMovie(id) async {
    var url = "https://v2.vidsrc.me/embed/$id/";
    final uri = Uri.parse(url);
    // print(uri);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

  var text_controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("VIDSRC API BRIDGE"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 16, bottom: 4, left: 8, right: 8),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Title of Movie",
              ),
              controller: text_controller,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8, top: 4),
            child: SizedBox(
              height: 50,
              width: 2000,
              child: ElevatedButton(
                onPressed: _getMovies,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: Text("SEARCH"),
              ),
            ),
          ),
          Expanded(
            child: SizedBox(
              height: 1000,
              child: ListView.builder(
                itemCount: result_json.length,
                itemBuilder: (context, position) {
                  var poster = poster_path_list[position];
                  if (poster != null) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: SizedBox(
                        height: 300,
                        child: Card(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 300,
                                  child: Card(
                                    elevation: 10,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _playMovie(id_list[position]);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Card(
                                              child: Image.network(
                                                'https://image.tmdb.org/t/p/original$poster',
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                        title_list[position],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 20,
                                                        horizontal: 8),
                                                    child: Text(
                                                      overview_list[position],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  } else {
                    return Padding(
                      padding: const EdgeInsets.only(top: 8, left: 8, right: 8),
                      child: SizedBox(
                        height: 300,
                        child: Card(
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 300,
                                  child: Card(
                                    elevation: 10,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _playMovie(id_list[position]);
                                      },
                                      style: ElevatedButton.styleFrom(
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10)),
                                        ),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Expanded(
                                            flex: 1,
                                            child: Card(
                                              child: Image.network(
                                                'assets//images//error.jpg',
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            flex: 1,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Expanded(
                                                  flex: 1,
                                                  child: Center(
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          vertical: 8.0),
                                                      child: Text(
                                                        title_list[position],
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                                Expanded(
                                                  flex: 3,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        vertical: 20,
                                                        horizontal: 8),
                                                    child: Text(
                                                      overview_list[position],
                                                      textAlign:
                                                          TextAlign.center,
                                                      style: TextStyle(
                                                          fontSize: 14,
                                                          fontStyle:
                                                              FontStyle.italic,
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

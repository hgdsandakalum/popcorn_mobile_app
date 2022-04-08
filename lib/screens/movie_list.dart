// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn_mobile_app/cubits/cubits.dart';
import 'package:popcorn_mobile_app/models/lists.dart';
import 'package:popcorn_mobile_app/widgets/widgets.dart';
import 'dart:ui' as ui;
import 'package:popcorn_mobile_app/services/movie_lists_services.dart';

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  //late List<String> movieList = [];
  late Future<List<MovieList>> allMovieLists;

  String name = "";
  String id = "";

  final nameEditingController = TextEditingController();
  final idEditingController = TextEditingController();

  var image_url = 'https://images5.alphacoders.com/445/445155.jpg';

  @override
  void initState() {
    allMovieLists = AllMovieListsAPIs.fetchAllLists();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: PreferredSize(
        preferredSize: Size(screenSize.width, 40.0),
        child: BlocBuilder<AppBarCubit, double>(
          builder: (context, scrollOffset) {
            return CustomAppBar(scrollOffset: scrollOffset);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                      title: Text("Add Movie List"),
                      content: Column(
                        children: [
                          TextField(
                            controller: nameEditingController,
                            decoration:
                                InputDecoration(hintText: 'Enter List Name'),
                            onChanged: (String value) {
                              this.setState(() {
                                name = value;
                              });
                            },
                          ),
                          TextField(
                            controller: idEditingController,
                            decoration:
                                InputDecoration(hintText: 'Enter List Id'),
                            onChanged: (String value) {
                              this.setState(() {
                                id = value;
                              });
                            },
                          )
                        ],
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            this.setState(() {
                              AllMovieListsAPIs.addMovieList(name, id);
                            });
                          },
                          child: Text("Add"),
                        ),
                      ]);
                });
          },
          child: Icon(
            Icons.add,
            color: Colors.white,
          )),
      body: new Stack(
        fit: StackFit.expand,
        children: <Widget>[
          new Image.network(image_url, fit: BoxFit.cover),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: new Container(
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Row(
            children: [
              Flexible(
                  child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 25.0),
                child: FutureBuilder<List<MovieList>>(
                  future: allMovieLists,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      List<MovieList> contentList = snapshot.data!;
                      return ListView.builder(
                          itemCount: contentList.length,
                          itemBuilder: (BuildContext context, int index) {
                            final MovieList content = contentList[index];
                            return Dismissible(
                                key: Key(content.id),
                                child: Card(
                                    elevation: 4,
                                    margin: EdgeInsets.all(8),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(16)),
                                    child: ListTile(
                                      title: Text(content.name),
                                      trailing: IconButton(
                                        icon: Icon(Icons.delete,
                                            color: Colors.red),
                                        onPressed: () {
                                          this.setState(() {
                                            AllMovieListsAPIs.deleteMovieList(
                                                content.name);
                                          });
                                        },
                                      ),
                                    )));
                          });
                    }
                    return Container();
                  },
                ),
              ))
            ],
          )
        ],
      ),
    );
  }
}

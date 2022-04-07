// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:popcorn_mobile_app/cubits/cubits.dart';
import 'package:popcorn_mobile_app/widgets/widgets.dart';
import 'dart:ui' as ui;

class MovieListScreen extends StatefulWidget {
  const MovieListScreen({Key? key}) : super(key: key);

  @override
  State<MovieListScreen> createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  // ignore: deprecated_member_use
  late List<String> movieList = [];
  String input = "";
  var image_url = 'https://images5.alphacoders.com/445/445155.jpg';

  @override
  void initState() {
    super.initState();
    movieList.add("Action");
    movieList.add("Adventure");
    movieList.add("Comedy");
    movieList.add("Thriller");
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
                      title: Text("Add MovieList"),
                      content: TextField(
                        onChanged: (String value) {
                          input = value;
                        },
                      ),
                      actions: <Widget>[
                        FlatButton(
                          onPressed: () {
                            setState(() {
                              movieList.add(input);
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
          ListView.builder(
              itemCount: movieList.length,
              itemBuilder: (BuildContext context, int index) {
                return Dismissible(
                    key: Key(movieList[index]),
                    child: Card(
                        elevation: 4,
                        margin: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16)),
                        child: ListTile(
                          title: Text(movieList[index]),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              setState(() {
                                movieList.removeAt(index);
                              });
                            },
                          ),
                        )));
              })
        ],
      ),
    );
  }
}

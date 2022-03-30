import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:popcorn_mobile_app/cubits/cubits.dart';
import 'package:popcorn_mobile_app/data/data.dart';
import 'package:popcorn_mobile_app/screens/screens.dart';
import 'package:popcorn_mobile_app/services/services.dart';
import 'package:popcorn_mobile_app/widgets/widgets.dart';
import '../models/models.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

List<Movie> parseMovies(String responseBody) {
  final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
  return parsed.map<Movie>((json) => Movie.fromMap(json)).toList();
}

Future<List<Movie>> fetchMovie() async {
  final response = await http.get(
    Uri.parse('http://popcorn.mocklab.io/originals'),
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Credentials': 'true',
      'Access-Control-Allow-Headers': 'Content-Type',
      'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
    },
  );
  // print(response.body.toString());
  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
    // return Movie.fromJson(jsonDecode(response.body));
    return parseMovies(response.body);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load movies');
  }
}

Future<List<Movie>> fetchAllMovies() async {
  QuerySnapshot<Map<String, dynamic>> popcornOriginals =
      await FirebaseFirestore.instance.collection('popcorn_originals').get();

  return parseAllMovies(popcornOriginals);
}

List<Movie> parseAllMovies(QuerySnapshot<Map<String, dynamic>> snapshot) {
  print(snapshot.docs);
  return snapshot.docs.map((e) => Movie.fromMap(e.data())).toList();
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late ScrollController _scrollController;
  late Future<Movie> futureMovie;
  late Future<List<Movie>> originalMovies;
  late Future<List<Movie>> trendingMovies;

  @override
  void initState() {
    _scrollController = ScrollController()
      ..addListener(() {
        context.read<AppBarCubit>().setOffset(_scrollController.offset);
      });
    originalMovies = fetchMovie();
    trendingMovies = fetchAllMovies();
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: MovieHeader(featuredContent: sintelMovie),
          ),
          SliverPadding(
            padding: const EdgeInsets.only(top: 15.0),
            sliver: SliverToBoxAdapter(
              child: FutureBuilder<List<Movie>>(
                future: originalMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ContentList(
                      key: PageStorageKey('trendings'),
                      title: 'Trendings',
                      contentList: snapshot.data!,
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<Movie>>(
              future: trendingMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ContentList(
                    key: PageStorageKey('myFavourites'),
                    title: 'My Favourites',
                    contentList: snapshot.data!,
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
          SliverToBoxAdapter(
            child: FutureBuilder<List<Movie>>(
              future: originalMovies,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ContentList(
                    key: PageStorageKey('originals'),
                    title: 'Popcorn Originals',
                    contentList: snapshot.data!,
                  );
                } else if (snapshot.hasError) {
                  return Text(
                    '${snapshot.error}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  );
                }
                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            ),
          ),
          // SliverToBoxAdapter(
          //   child: FutureBuilder<QuerySnapshot>(
          //       future: popcornOriginals.get(),
          //       builder: (BuildContext context,
          //           AsyncSnapshot<QuerySnapshot> snapshot) {
          //         if (snapshot.hasError) {
          //           return Text(
          //             "Something went wrong",
          //             style: const TextStyle(
          //               color: Colors.white,
          //               fontSize: 16.0,
          //             ),
          //           );
          //         }

          //         if (!snapshot.hasData) {
          //           return Text(
          //             "Data does not exist",
          //             style: const TextStyle(
          //               color: Colors.white,
          //               fontSize: 16.0,
          //             ),
          //           );
          //         }

          //         if (snapshot.connectionState == ConnectionState.done) {
          //           return ContentList(
          //             key: PageStorageKey('test'),
          //             title: 'Test',
          //             contentList: snapshot.data!.docs,
          //           );
          //         }

          //         return Text("loading");
          //       }),
          // ),
          SliverPadding(
            padding: const EdgeInsets.only(bottom: 20.0),
            sliver: SliverToBoxAdapter(
              child: FutureBuilder<List<Movie>>(
                future: trendingMovies,
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return ContentList(
                      key: PageStorageKey('trending'),
                      title: 'Trending',
                      contentList: snapshot.data!,
                    );
                  } else if (snapshot.hasError) {
                    return Text(
                      '${snapshot.error}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20.0,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  }
                  // By default, show a loading spinner.
                  return const CircularProgressIndicator();
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  getExpenseItems(AsyncSnapshot<QuerySnapshot> snapshot) {
    return snapshot.data!.docs
        .map((doc) => new ListTile(
            title: new Text(doc["name"]), subtitle: new Text(doc["name"])))
        .toList();
  }
}

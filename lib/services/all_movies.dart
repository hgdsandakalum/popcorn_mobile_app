import '../models/models.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllMoviesService {
  static Future<List<Movie>> fetchOriginals() async {
    QuerySnapshot<Map<String, dynamic>> popcornOriginals =
        await FirebaseFirestore.instance
            .collection('popcorn_originals')
            .where('originals', isEqualTo: true)
            .get();

    // final movieRef = FirebaseFirestore.instance
    //     .collection('popcorn_originals')
    //     .where('originals', isEqualTo: true).get();

    if (popcornOriginals.docs.isEmpty) {
      throw Exception('Failed to load movies');
    } else {
      return parseAllMovies(popcornOriginals);
    }
  }

  static Future<List<Movie>> fetchTrendings() async {
    QuerySnapshot<Map<String, dynamic>> popcornOriginals =
        await FirebaseFirestore.instance
            .collection('popcorn_originals')
            .where('trendings', isEqualTo: true)
            .get();

    if (popcornOriginals.docs.isEmpty) {
      throw Exception('Failed to load movies');
    } else {
      return parseAllMovies(popcornOriginals);
    }
  }

  static Future<List<Movie>> fetchTopRated() async {
    QuerySnapshot<Map<String, dynamic>> popcornOriginals =
        await FirebaseFirestore.instance
            .collection('popcorn_originals')
            .where('topRated', isEqualTo: true)
            .get();

    return parseAllMovies(popcornOriginals);
  }

  static List<Movie> parseAllMovies(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    print(snapshot.docs);
    return snapshot.docs.map((e) => Movie.fromMap(e.data())).toList();
  }
}

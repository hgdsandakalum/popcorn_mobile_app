import '../models/models.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllMoviesService {
  static Future<List<Movie>> fetchOriginals() async {
    QuerySnapshot<Map<String, dynamic>> popcornOriginals =
        await FirebaseFirestore.instance
            .collection('movies')
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
            .collection('movies')
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
            .collection('movies')
            .where('topRated', isEqualTo: true)
            .get();

    return parseAllMovies(popcornOriginals);
  }

  static Future<DocumentSnapshot<Object?>> fetchFeatured() {
    CollectionReference featuresRef =
        FirebaseFirestore.instance.collection('featuredMovies');

    Future<DocumentSnapshot<Object?>> documentSnapshot =
        featuresRef.doc('6ojNnsjjDxcw4z2JCNvv').get();

    return documentSnapshot;
  }

  static List<Movie> parseAllMovies(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    print(snapshot.docs);
    return snapshot.docs.map((e) => Movie.fromMap(e.data())).toList();
  }
}

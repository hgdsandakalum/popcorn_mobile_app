import '../models/models.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ComingSoonService {
  static Future<List<Movie>> fetchComingSoon() async {
    QuerySnapshot<Map<String, dynamic>> comingSoon =
        await FirebaseFirestore.instance.collection('comingSoonMovies').get();

    if (comingSoon.docs.isEmpty) {
      throw Exception('Failed to load movies');
    } else {
      return parseAllMovies(comingSoon);
    }
  }

  static List<Movie> parseAllMovies(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    print(snapshot.docs);
    return snapshot.docs.map((e) => Movie.fromMap(e.data())).toList();
  }
}

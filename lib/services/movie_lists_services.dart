import '../models/models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllMovieListsAPIs {
  static Future<List<Movie>> fetchAllLists() async {
    QuerySnapshot<Map<String, dynamic>> allMovieLists =
        await FirebaseFirestore.instance.collection('movieLists').get();

    if (allMovieLists.docs.isEmpty) {
      throw Exception('Failed to load Lists');
    } else {
      return parseAllMovies(allMovieLists);
    }
  }

  static List<Movie> parseAllMovies(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    print(snapshot.docs);
    return snapshot.docs.map((e) => Movie.fromMap(e.data())).toList();
  }
}

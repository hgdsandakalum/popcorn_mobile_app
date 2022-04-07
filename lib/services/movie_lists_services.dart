import '../models/models.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AllMovieListsAPIs {
  static Future<List<MovieList>> fetchAllLists() async {
    QuerySnapshot<Map<String, dynamic>> allMovieLists =
        await FirebaseFirestore.instance.collection('movieLists').get();

    if (allMovieLists.docs.isEmpty) {
      throw Exception('Failed to load Lists');
    } else {
      return parseAllMovies(allMovieLists);
    }
  }

  static List<MovieList> parseAllMovies(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    print(snapshot.docs);
    return snapshot.docs.map((e) => MovieList.fromMap(e.data())).toList();
  }

  static Future<void> addMovieList(MovieList movieList) {
    CollectionReference favRef = FirebaseFirestore.instance
        .collection('movieLists')
        .doc('fBqWcnKBZMIpFEVOGa4d')
        .collection('movieLists');

    return favRef
        .doc(movieList.id)
        .set({
          'name': movieList.name,
        })
        .then((value) => print("Movie List Added"))
        .catchError((error) => print("Failed to add movie List: $error"));
  }

  static Future<void> deleteMovieList(String movieID) {
    CollectionReference favRef = FirebaseFirestore.instance
        .collection('movieLists')
        .doc('fBqWcnKBZMIpFEVOGa4d')
        .collection('movieLists');

    print(movieID);

    return favRef
        .doc(movieID)
        .delete()
        .then((value) => print("Movie List Deleted"))
        .catchError((error) => print("Failed to delete Movie List: $error"));
  }
}

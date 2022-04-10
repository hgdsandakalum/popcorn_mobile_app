import '../models/models.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FavouriteService {
  static Future<List<Movie>> fetchFavourites() async {
    QuerySnapshot<Map<String, dynamic>> popcornOriginals =
        await FirebaseFirestore.instance
            .collection('favouriteMovies')
            .doc('fBqWcnKBZMIpFEVOGa4d')
            .collection('userFavourites')
            .get();

    if (popcornOriginals.docs.isEmpty) {
      throw Exception('Failed to load movies');
    } else {
      return parseAllMovies(popcornOriginals);
    }
  }

  static List<Movie> parseAllMovies(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    print(snapshot.docs);
    return snapshot.docs.map((e) => Movie.fromMap(e.data())).toList();
  }

  static Future<void> addFavourtie(Movie movie) {
    CollectionReference favRef = FirebaseFirestore.instance
        .collection('favouriteMovies')
        .doc('fBqWcnKBZMIpFEVOGa4d')
        .collection('userFavourites');

    return favRef
        .doc(movie.movieId)
        .set({
          'name': movie.name,
          'imageUrl': movie.imageUrl,
          'color': movie.color,
          'description': movie.description,
          'originals': movie.originals,
          'topRated': movie.topRated,
          'trendings': movie.trendings,
          'movieId': movie.movieId
        })
        .then((value) => print("Movie Added"))
        .catchError((error) => print("Failed to add movie: $error"));
  }

  static Future<void> deleteFavourtie(String movieID) {
    CollectionReference favRef = FirebaseFirestore.instance
        .collection('favouriteMovies')
        .doc('fBqWcnKBZMIpFEVOGa4d')
        .collection('userFavourites');

    print(movieID);

    return favRef
        .doc(movieID)
        .delete()
        .then((value) => print("Movie Deleted"))
        .catchError((error) => print("Failed to delete Movie: $error"));
  }

  static Future<bool> checkIfDocExists(String? docId) async {
    try {
      // Get reference to Firestore collection
      var collectionRef = FirebaseFirestore.instance
          .collection('favouriteMovies')
          .doc('fBqWcnKBZMIpFEVOGa4d')
          .collection('userFavourites');

      var doc = await collectionRef.doc(docId).get();
      return doc.exists;
    } catch (e) {
      throw e;
    }
  }
}

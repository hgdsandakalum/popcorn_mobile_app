import '../models/models.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CommentService {
  static Future<List<MovieComment>> fetchCommentsByMovie(
      String? movieId) async {
    QuerySnapshot<Map<String, dynamic>> comments = await FirebaseFirestore
        .instance
        .collection('movieComments')
        .where('movieId', isEqualTo: movieId)
        .get();

    return parseAllComments(comments);
  }

  static List<MovieComment> parseAllComments(
      QuerySnapshot<Map<String, dynamic>> snapshot) {
    print(snapshot.docs);
    return snapshot.docs.map((e) => MovieComment.fromMap(e.data())).toList();
  }

  static Future<void> addCommentsByMovie(
      String? movieId,
      String? userId,
      String? userName,
      String? commentDate,
      String? commentTime,
      String? message) {
    CollectionReference commentRef =
        FirebaseFirestore.instance.collection('movieComments');

    return commentRef
        .add({
          'movieId': movieId,
          'userId': userId,
          'userName': userName,
          'commentDate': commentDate,
          'commentTime': commentTime,
          'message': message,
        })
        .then((value) => print("Comment Added"))
        .catchError((error) => print("Failed to add comment: $error"));
  }

  static Future<void> deleteComment(String movieId, String comment) async {
    CollectionReference commentRef =
        FirebaseFirestore.instance.collection('movieComments');

    QuerySnapshot querySnap = await FirebaseFirestore.instance
        .collection('movieComments')
        .where('movieId', isEqualTo: movieId)
        .where('message', isEqualTo: comment)
        .get();
    print(querySnap.docs);
    QueryDocumentSnapshot doc = querySnap.docs[0];
    String docRef = doc.reference.id;

    print(docRef);

    return commentRef
        .doc(docRef)
        .delete()
        .then((value) => print("Comment Deleted"))
        .catchError((error) => print("Failed to delete Comment: $error"));
  }
}

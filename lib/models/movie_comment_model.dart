import 'package:flutter/material.dart';

class MovieComment {
  String userId;
  String userName;
  String movieId;
  String commentDate;
  String commentTime;
  String message;

  MovieComment(
      {required this.userId,
      required this.userName,
      required this.movieId,
      required this.commentDate,
      required this.commentTime,
      required this.message});

  factory MovieComment.fromMap(Map<String, dynamic> json) {
    return MovieComment(
        userId: json['userId'],
        userName: json['userName'],
        movieId: json['movieId'],
        commentDate: json['commentDate'],
        commentTime: json['commentTime'],
        message: json['message']);
  }

  MovieComment.fromJson(Map<String, Object?> json)
      : this(
            userId: json['userId']! as String,
            userName: json['userName']! as String,
            movieId: json['movieId']! as String,
            commentDate: json['commentDate']! as String,
            commentTime: json['commentTime']! as String,
            message: json['message']! as String);

  Map<String, Object?> toJson() {
    return {
      'userId': userId,
      'userName': userId,
      'movieId': movieId,
      'commentDate': commentDate,
      'commentTime': commentTime,
      'message': message
    };
  }
}

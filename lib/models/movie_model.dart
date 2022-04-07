import 'package:flutter/material.dart';

class Movie {
  final String? movieId;
  final String? name;
  final String? imageUrl;
  final String? videoUrl;
  final String? description;
  final String? color;
  final bool? trendings;
  final bool? originals;
  final bool? topRated;

  Movie({
    this.movieId,
    this.name,
    this.imageUrl,
    this.videoUrl,
    this.description,
    this.color,
    this.trendings,
    this.originals,
    this.topRated,
  });

  // factory Movie.fromJson(Map<String, dynamic> json) {
  //   return Movie(
  //     name : json['name'],
  //     imageUrl : json['imageUrl'],
  //     titleImageUrl : json['titleImageUrl'],
  //     videoUrl : json['videoUrl'],
  //     description : json['videoUrl'],
  //     color : json['videoUrl'],
  //   );
  // }

  factory Movie.fromMap(Map<String, dynamic> json) {
    return Movie(
      movieId: json['movieId'],
      name: json['name'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      description: json['description'],
      color: json['color'],
      trendings: json['trendings'],
      originals: json['originals'],
      topRated: json['topRated'],
    );
  }

  Movie.fromJson(Map<String, Object?> json)
      : this(
          movieId: json['movieId']! as String,
          name: json['name']! as String,
          imageUrl: json['imageUrl']! as String,
          videoUrl: json['videoUrl']! as String,
          description: json['description']! as String,
          color: json['color']! as String,
          trendings: json['trendings']! as bool,
          originals: json['originals']! as bool,
          topRated: json['topRated']! as bool,
        );

  Map<String, Object?> toJson() {
    return {
      'movieId': movieId,
      'name': name,
      'imageUrl': imageUrl,
      'videoUrl': videoUrl,
      'description': description,
      'color': color,
      'trendings': trendings,
      'originals': originals,
      'topRated': topRated,
    };
  }
}

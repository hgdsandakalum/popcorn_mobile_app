import 'package:flutter/material.dart';

class Movie {
  final String? name;
  final String? imageUrl;
  final String? titleImageUrl;
  final String? videoUrl;
  final String? description;
  final Color? color;
  final bool? trendings;
  final bool? originals;
  final bool? topRated;

  Movie({
    this.name,
    this.imageUrl,
    this.titleImageUrl,
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
      name: json['name'],
      imageUrl: json['imageUrl'],
      titleImageUrl: json['titleImageUrl'],
      videoUrl: json['videoUrl'],
      description: json['videoUrl'],
      color: json['videoUrl'],
    );
  }

  Movie.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          imageUrl: json['imageUrl']! as String,
          titleImageUrl: json['titleImageUrl']! as String,
          videoUrl: json['videoUrl']! as String,
          description: json['description']! as String,
          color: json['color']! as Color,
          trendings: json['trendings']! as bool,
          originals: json['originals']! as bool,
          topRated: json['topRated']! as bool,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'imageUrl': imageUrl,
      'titleImageUrl': titleImageUrl,
      'videoUrl': videoUrl,
      'description': description,
      'color': color,
      'trendings': trendings,
      'originals': originals,
      'topRated': topRated,
    };
  }
}

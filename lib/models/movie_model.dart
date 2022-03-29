import 'package:flutter/material.dart';

class Movie {
  final String? name;
  final String? imageUrl;
  final String? titleImageUrl;
  final String? videoUrl;
  final String? description;
  final Color? color;

  Movie({
    this.name,
    this.imageUrl,
    this.titleImageUrl,
    this.videoUrl,
    this.description,
    this.color,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      name : json['name'],
      imageUrl : json['imageUrl'],
      titleImageUrl : json['titleImageUrl'],
      videoUrl : json['videoUrl'],
      description : json['videoUrl'],
      color : json['videoUrl'],
    );
  }

  factory Movie.fromMap(Map<String, dynamic> json) {
    return Movie(
        name : json['name'],
        imageUrl : json['imageUrl'],
        titleImageUrl : json['titleImageUrl'],
        videoUrl : json['videoUrl'],
        description : json['videoUrl'],
        color : json['videoUrl'],
    );
  }

}

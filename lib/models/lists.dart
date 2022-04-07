import 'package:flutter/material.dart';

class MovieList {
  String name;
  String id;

  MovieList({
    required this.name,
    required this.id,
  });

  factory MovieList.fromMap(Map<String, dynamic> json) {
    return MovieList(
      name: json['name'],
      id: json['id'],
    );
  }

  MovieList.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          id: json['id']! as String,
        );

  Map<String, Object?> toJson() {
    return {
      'name': name,
      'id': id,
    };
  }
}

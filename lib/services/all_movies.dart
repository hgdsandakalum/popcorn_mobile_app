import '../models/models.dart';

import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AllMoviesService {
  static List<Movie> parseMovies(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<Movie>((json) => Movie.fromMap(json)).toList();
  }

  static Future<List<Movie>> fetchMovie(String movieCat) async {
    final response = await http.get(
      Uri.parse('http://popcorn.mocklab.io/$movieCat'),
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Credentials': 'true',
        'Access-Control-Allow-Headers': 'Content-Type',
        'Access-Control-Allow-Methods': 'GET,PUT,POST,DELETE'
      },
    );
    print(response.body.toString());
    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      return parseMovies(response.body);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load movies');
    }
  }
}

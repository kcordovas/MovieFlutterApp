import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:movieflutterapp/src/models/film_model.dart';

class MoviesProvider {
  String _apiKey = '59fe4b6c516481d917ba576a9496c630';
  String _url = 'api.themoviedb.org';
  String _language = 'en-US';

  Future<List<Film>> getInCinemas() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final films = Films.fromJsonList(decodeData['results']);

    return films.items;
  }
}

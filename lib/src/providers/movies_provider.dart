import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:movieflutterapp/src/models/film_model.dart';

class MoviesProvider {
  // API KEy themoviedb
  String _apiKey = '59fe4b6c516481d917ba576a9496c630';
  // URL PAGE - https://developers.themoviedb.org
  String _url = 'api.themoviedb.org';
  // Language
  String _language = 'en-US';

  /**
   * Process Response json and transform in List<Film>
   * @return Future<List<Film>>
   */
  Future<List<Film>> _processingResponse(Uri url) async {
    final response = await http.get(url);
    final decodeData = json.decode(response.body);
    final films = Films.fromJsonList(decodeData['results']);

    return films.items;
  }

  /**
   * Get Film List with future, using Uri
   * @return Future<List<Film>>
   */
  Future<List<Film>> getInCinemas() async {
    final url = Uri.https(_url, '3/movie/now_playing',
        {'api_key': _apiKey, 'language': _language});

    return await _processingResponse(url);
  }

  /**
   * Get Film List with future, but using other Uri
   * @return Future<List<Film>>
   */
  Future<List<Film>> getPopulars() async {
    final url = Uri.https(
        _url, '3/movie/popular', {'api_key': _apiKey, 'language': _language});

    return await _processingResponse(url);
  }
}

import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';
import 'package:movieflutterapp/src/models/film_model.dart';

class MoviesProvider {
  // API KEy themoviedb
  String _apiKey = '59fe4b6c516481d917ba576a9496c630';
  // URL PAGE - https://developers.themoviedb.org
  String _url = 'api.themoviedb.org';
  // Language
  String _language = 'en-US';

  // Page is to load new films
  int _popularsPage = 0;

  bool _loading = false;

  List<Film> _populars = new List();

  // Create StreamController that send Film List
  // Broadcast is the type: is could to be to uses in some widgets
  final _popularStreamController = StreamController<List<Film>>.broadcast();

  // Add data to Stream
  Function(List<Film>) get popularsSick => _popularStreamController.sink.add;

  // Get Data with StreamController
  Stream<List<Film>> get popularsStream => _popularStreamController.stream;

  /**
   * StreamController always close with close method
   * '?' this letter is to verify that is nullable
   */
  void disposeStream() {
    _popularStreamController?.close();
  }

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
    if (_loading) return [];
    _loading = true;
    _popularsPage++;
    final url = Uri.https(_url, '3/movie/popular', {
      'api_key': _apiKey,
      'language': _language,
      'page': _popularsPage.toString()
    });

    final resp = await _processingResponse(url);

    _populars.addAll(resp);
    popularsSick(_populars);

    _loading = false;

    return resp;
  }
}

import 'package:flutter/material.dart';
import 'package:movieflutterapp/src/models/film_model.dart';

class FilmDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ModalRoute to receiver arguments
    final Film film = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      body: Center(
        child: Text('Detail ${film.title}'),
      ),
    );
  }
}

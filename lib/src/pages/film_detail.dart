import 'package:flutter/material.dart';
import 'package:movieflutterapp/src/models/film_model.dart';

class FilmDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ModalRoute to receiver arguments
    final Film film = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      // A widget that react to scrollview (slivers)
      body: CustomScrollView(
        slivers: <Widget>[
          _createAppBar(film),
        ],
      ),
    );
  }

  Widget _createAppBar(Film film) {
    return SliverAppBar(
      elevation: 2.0,
      backgroundColor: Colors.indigoAccent,
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        centerTitle: true,
        title: Text(
          film.title,
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        background: FadeInImage(
          image: NetworkImage(film.getBackgroundImg()),
          placeholder: AssetImage('assets/img/loading.gif'),
          fadeInDuration: Duration(milliseconds: 150),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

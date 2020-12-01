import 'package:flutter/material.dart';
import 'package:movieflutterapp/src/models/film_model.dart';
import 'package:movieflutterapp/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate {
  final filmProvider = MoviesProvider();

  String selection = '';
  final films = ['Superman', 'Hard kill', 'Chick Fight', 'Peninswa'];

  final recentsFilms = ['Spiderman', 'Iron Man'];
  @override
  List<Widget> buildActions(BuildContext context) {
    // The actions on our AppBar
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // Icon in the left of our Appbar
    return IconButton(
        icon: AnimatedIcon(
            icon: AnimatedIcons.menu_arrow, progress: transitionAnimation),
        onPressed: () {
          close(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    // Create Results to showing
    return Center(
      child: Container(
        height: 100.0,
        width: 100.0,
        color: Colors.blueAccent,
        child: Text(selection),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // Suggestions when typing
    if (query.isEmpty) return Container();
    return FutureBuilder(
      future: filmProvider.searchFilm(query),
      builder: (BuildContext context, AsyncSnapshot<List<Film>> snapshot) {
        if (snapshot.hasData) {
          final films = snapshot.data;
          return ListView.builder(
            itemCount: films.length,
            itemBuilder: (context, index) {
              final film = films[index];
              return ListTile(
                leading: FadeInImage(
                  placeholder: AssetImage('assets/img/no-image.jpg'),
                  image: NetworkImage(film.getPosterImg()),
                  width: 50.0,
                  fit: BoxFit.contain,
                ),
                title: Text(film.title),
                subtitle: Text(film.originalTitle),
                onTap: () {
                  close(context, null);
                  Navigator.pushNamed(context, 'detail', arguments: film);
                },
              );
            },
          );
        }
        return Center(child: CircularProgressIndicator());
      },
    );
  }
}

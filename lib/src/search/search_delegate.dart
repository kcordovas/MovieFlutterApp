import 'package:flutter/material.dart';

class DataSearch extends SearchDelegate {
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

    final suggestionList = (query.isEmpty)
        ? recentsFilms
        : films
            .where((element) =>
                element.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: Icon(Icons.movie),
          title: Text(suggestionList[index]),
          onTap: () {
            selection = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}

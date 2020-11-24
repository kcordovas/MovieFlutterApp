import 'package:flutter/material.dart';
import 'package:movieflutterapp/src/models/film_model.dart';

class MovieHorizontal extends StatelessWidget {
  // Create List<Films> to global instance
  final List<Film> films;

  // This function is an callback
  // to add new pages to PageView
  final Function nextPage;

  // Constructor that required Film List
  // required callback Function nextPage
  MovieHorizontal({@required this.films, @required this.nextPage});

  // Create an PageController Object
  // used to create an listener
  final _pageController = new PageController(
    initialPage: 0,
    // ViewPortFraction allow show in the same screen
    // some pages
    viewportFraction: 0.2,
  );

  @override
  Widget build(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    // Listener to identify the final of page
    _pageController.addListener(() {
      // Condition to detect the final with -200 pixel
      // Not is final exactly
      if (_pageController.position.pixels >=
          _pageController.position.maxScrollExtent - 200) {
        // call to us callback
        nextPage();
      }
    });

    return Container(
      height: _screenSize.height * 0.2,
      // PageView is a widget that allows
      // the effect how an tab effect,
      // could be, Horizontal or vertical
      child: PageView.builder(
        controller: _pageController,
        itemCount: films.length,
        itemBuilder: (context, position) =>
            _createCard(context, films[position], _screenSize),
        //children: _tarjetas(context),
      ),
    );
  }

  Widget _createCard(BuildContext context, Film film, Size _screenSize) {
    return Container(
      margin: EdgeInsets.only(right: 15.0),
      child: Column(
        children: [
          // ClipRRect allow give an borderRadius
          // for the widget
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              placeholder: AssetImage('assets/img/no-image.jpg'),
              image: NetworkImage(film.getPosterImg()),
              fit: BoxFit.cover,
              height: _screenSize.height * 0.15,
            ),
          ),
          SizedBox(
            width: 5.0,
          ),
          Text(
            film.title,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.caption,
          ),
        ],
      ),
    );
  }

  /**
   * Create a Widget Cards List to showing Image and a subtitle
   * @return List<Widget> return List on List<Film> 
   */
  List<Widget> _tarjetas(BuildContext context) {
    final _screenSize = MediaQuery.of(context).size;

    // Map method is a function that return an Widget
    return films.map((film) {
      return Container(
        margin: EdgeInsets.only(right: 15.0),
        child: Column(
          children: [
            // ClipRRect allow give an borderRadius
            // for the widget
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                placeholder: AssetImage('assets/img/no-image.jpg'),
                image: NetworkImage(film.getPosterImg()),
                fit: BoxFit.cover,
                height: _screenSize.height * 0.15,
              ),
            ),
            SizedBox(
              width: 5.0,
            ),
            Text(
              film.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            ),
          ],
        ),
      );
    }).toList();
  }
}

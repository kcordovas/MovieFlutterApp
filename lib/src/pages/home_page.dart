import 'package:flutter/material.dart';
import 'package:movieflutterapp/src/providers/movies_provider.dart';
import 'package:movieflutterapp/src/widgets/card_swiper_widget.dart';
import 'package:movieflutterapp/src/widgets/movie_horizontal.dart';

// Home page, Route '/'
class HomePage extends StatelessWidget {
  final provider = MoviesProvider();

  @override
  Widget build(BuildContext context) {
    // Init list
    provider.getPopulars();
    return Scaffold(
      appBar: AppBar(
        title: Text('Films'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {})
        ],
      ),
      // SafeArea, is an widget that allow
      // put an object into of a visible area,
      // function with Notch,
      // body: SafeArea(child: Text('Hello world')),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context),
          ],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    // Create with snippet FutureBuilder
    // FutureBuilder to json response with async task
    return FutureBuilder(
      // FUture, is provider.getCinemas
      future: provider.getInCinemas(),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        // Snapshot could be empty or null
        if (!snapshot.hasData) {
          // Return an Progress Indicator (Widget)
          return Container(
              height: 400.0, child: Center(child: CircularProgressIndicator()));
        }
        // Return CardSwiper, with param data snapshot
        return CardSwiper(films: snapshot.data);
      },
    );
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text(
              'Populars',
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          SizedBox(
            height: 5.0,
          ),
          // Change FutureBuilder by StreamBuilder
          StreamBuilder(
            stream: provider.popularsStream,
            builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
              if (snapshot.hasData) {
                return MovieHorizontal(
                  films: snapshot.data,
                  // Here send function getPopulars
                  // to add more Films to list
                  nextPage: provider.getPopulars,
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}

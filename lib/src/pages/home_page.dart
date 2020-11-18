import 'package:flutter/material.dart';
import 'package:movieflutterapp/src/providers/movies_provider.dart';
import 'package:movieflutterapp/src/widgets/card_swiper_widget.dart';

// Home page, Route '/'
class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
          children: <Widget>[_swiperTarjetas()],
        ),
      ),
    );
  }

  Widget _swiperTarjetas() {
    MoviesProvider provider = MoviesProvider();
    provider.getInCinemas();
    return CardSwiper(films: [1, 2, 3, 4, 5]);
  }
}

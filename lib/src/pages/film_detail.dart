import 'package:flutter/material.dart';
import 'package:movieflutterapp/src/models/actors_model.dart';
import 'package:movieflutterapp/src/models/film_model.dart';
import 'package:movieflutterapp/src/providers/movies_provider.dart';

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
          SliverList(
            delegate: SliverChildListDelegate([
              SizedBox(
                height: 10.0,
              ),
              _posterTitle(film, context),
              _description(film),
              _createFilm(film),
            ]),
          ),
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

  Widget _posterTitle(Film film, BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.0),
      child: Row(
        children: <Widget>[
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image(
              image: NetworkImage(film.getPosterImg()),
              height: 150.0,
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  film.title,
                  style: Theme.of(context).textTheme.headline5,
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  film.originalTitle,
                  style: Theme.of(context).textTheme.subtitle1,
                  overflow: TextOverflow.ellipsis,
                ),
                Row(
                  children: [
                    Icon(Icons.star),
                    Text(
                      film.voteAverage.toString(),
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                  ],
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _description(Film film) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 20.0,
      ),
      child: Text(
        film.overview,
        textAlign: TextAlign.justify,
      ),
    );
  }

  Widget _createFilm(Film film) {
    final movieProvider = MoviesProvider();
    return FutureBuilder(
      future: movieProvider.getCast(film.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
        if (snapshot.hasData) return _createActorsPageView(snapshot.data);
        return Center(child: CircularProgressIndicator());
      },
    );
  }

  Widget _createActorsPageView(List<Actor> actors) {
    return SizedBox(
      height: 200.0,
      child: PageView.builder(
        pageSnapping: false,
        controller: PageController(
          viewportFraction: 0.3,
          initialPage: 0,
        ),
        itemCount: actors.length,
        itemBuilder: (context, position) => _actorCard(actors[position]),
      ),
    );
  }

  Widget _actorCard(Actor actor) {
    return Container(
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: FadeInImage(
              image: NetworkImage(actor.getPhoto()),
              placeholder: AssetImage('assets/img/no-image.jpg'),
              height: 150.0,
              fit: BoxFit.cover,
            ),
          ),
          Text(
            actor.name,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }
}

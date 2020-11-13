import 'package:flutter/material.dart';
import 'package:movieflutterapp/src/pages/home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide Debug banner show in phone screen
      debugShowCheckedModeBanner: false,
      title: 'Movie App',
      // Init route to main (reference model web: '/')
      initialRoute: '/',
      // Define Route Map
      routes: {
        '/': (BuildContext context) => HomePage(),
      },
    );
  }
}

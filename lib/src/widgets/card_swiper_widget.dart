import 'package:flutter/material.dart';

import 'package:flutter_swiper/flutter_swiper.dart';

/*
 * Card Widget to re-use custom widget
 */
class CardSwiper extends StatelessWidget {
  // Init Films List of dynamic type (change in future)
  final List<dynamic> films;

  // Init Constructor to request Films List
  CardSwiper({@required this.films});

  @override
  Widget build(BuildContext context) {
    // MediaQuery.- use to adapt size conform to a device
    final _screenSize = MediaQuery.of(context).size;

    // Container is necessary to define width and height
    // on Swiper.
    return Container(
      padding: EdgeInsets.only(top: 16.0),
      // Swiper is the library to movement effect
      child: Swiper(
        // Effect slider
        layout: SwiperLayout.STACK,
        // To apply effect is necessary asign an itemWidth
        itemWidth: _screenSize.width * 0.7,
        itemHeight: _screenSize.height * 0.5,
        itemBuilder: (BuildContext context, int index) {
          // ClipRect is an Widget to make an shape
          // an image
          return ClipRRect(
            // BorderRadius allow to define an radio
            // with double value
            borderRadius: BorderRadius.circular(20.0),
            child: Image.network(
              "http://via.placeholder.com/350x150",
              fit: BoxFit.cover,
            ),
          );
        },
        itemCount: 3,
        // pagination: SwiperPagination(),
        // control: SwiperControl(),
      ),
    );
  }
}

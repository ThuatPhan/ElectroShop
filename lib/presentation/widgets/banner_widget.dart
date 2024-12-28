import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatelessWidget {
  const BannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 150,
        autoPlay: true,
        enlargeCenterPage: true,
        viewportFraction: 1.2,
      ),
      items: [
        Image.asset('assets/images/banner-1.png'),
        Image.asset('assets/images/banner-2.png'),
        Image.asset('assets/images/banner-3.jpg'),
        Image.asset('assets/images/banner-4.png'),
      ],
    );
  }
}

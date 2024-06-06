import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:p3lmobile/login_page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Carousel Background',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LandingPage(),
    );
  }
}

class LandingPage extends StatelessWidget {
  final List<String> imagePaths = [
    'lib/images/Lapis_Legit.jpg',
    'lib/images/Lapis_Surabaya.jpg',
    'lib/images/Mandarin.jpg',
    'lib/images/Spikoe.jpg',
    'lib/images/Mandarin2.jpg',
    'lib/images/lapislegit.jpeg',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Carousel background
          CarouselSlider(
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 7), // Interval between slides
              autoPlayAnimationDuration:
                  Duration(seconds: 2), // Duration of slide transition
              autoPlayCurve: Curves.easeInOut,
              pauseAutoPlayOnTouch: true,
              scrollDirection: Axis.horizontal,
            ),
            items: imagePaths.map((path) {
              return Image.asset(
                path,
                fit: BoxFit.cover,
                width: MediaQuery.of(context).size.width,
              );
            }).toList(),
          ),
          // Main content overlay
          Positioned(
            top: 50,
            left: 90,
            // Alignment.topCenter,
            child: Text(
              'Atma Kitchen',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(243, 191, 209, 1),
                shadows: [
                  Shadow(
                    blurRadius: 10.0,
                    color: Colors.black,
                    offset: Offset(5.0, 5.0),
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 100,
            left: 90,
            // Alignment.topCenter,
            child: Text(
              'Every Bite, Every Sip, \na Celebreation of Taste',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.normal,
                color: Colors.black,
              ),
            ),
          ),

          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  primary: Color.fromRGBO(118, 196, 223, 1)),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => LoginPage()));
              },
              child: Text('Login'),
            ),
          ),
        ],
      ),
    );
  }
}

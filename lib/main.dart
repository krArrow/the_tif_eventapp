// ignore_for_file: prefer_const_constructors

import 'package:the_tif_eventapp/homePage.dart';
import 'package:the_tif_eventapp/infocard.dart';
import 'package:the_tif_eventapp/searchEvent.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/search': (context) => SearchEvent(),
        '/eventInfo': (context) => InfoCard(),
      },
    );
  }
}

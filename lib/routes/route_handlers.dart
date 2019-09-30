import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mental_math/main/home_screen.dart';
import 'package:mental_math/main/main_screen.dart';

Handler welcomeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    // return ChangeNotifierProvider(
    //   builder: (context) => ColorTheme(quepalGradients),
    //   child: Material(
    //     child: Stack(
    //       children: <Widget>[
    //         Background(),
    //         LandingScreen()
    //       ],
    //     ),
    //   ),
    // );
  });

Handler mainHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return MainScreen();
  });
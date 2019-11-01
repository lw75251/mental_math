import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:mental_math/main/game_screen.dart';
import 'package:mental_math/main/main_screen.dart';
import 'package:mental_math/main/option_screen.dart';
import 'package:mental_math/routes/router.dart';
import 'package:mental_math/utils/fluro.dart';

Handler welcomeHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, List<String>> params) {
    return Container();
  });

Handler mainHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {
    return MainScreen();
  });

Handler optionsHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {

    // Map data = {"header": params["header"][0], "img": params["img"][0]};
    Map data = FluroUtils.paramsToMap(optionsRoute, params);
    return OptionScreen(data);
  });

Handler gameHandler = Handler(
  handlerFunc: (BuildContext context, Map<String, dynamic> params) {

    // Map Data: header, difficulty
    Map data = FluroUtils.paramsToMap(gameRoute, params);
    return GameScreen(data);
  });  
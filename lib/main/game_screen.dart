import 'package:flutter/material.dart';
import 'package:mental_math/custom/timer.dart';

class GameScreen extends StatefulWidget {
  final Map<String, String> gameSettings;
  GameScreen(
    this.gameSettings,
    {Key key}) : super(key: key);

  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       body: Padding(padding: EdgeInsets.all(8.0),
       child: Column(children: <Widget>[
         Expanded(child: Align(
           alignment: FractionalOffset.center,
           child: AspectRatio(aspectRatio: 1.0,
            child: CountDown()
           ),
         ))
       ],),),
    );
  }
}
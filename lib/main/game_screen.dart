import 'package:flutter/material.dart';
import 'package:mental_math/custom/calculator.dart';
import 'package:mental_math/custom/game_stats.dart';
import 'package:mental_math/custom/timer.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  final Map<String, String> gameSettings;
  GameScreen(
    this.gameSettings,
    {Key key}) : super(key: key);

  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  final double _iconPadding = 20.0;
  final double _iconSize = 28.0;

  Widget _buildIcon( IconData _icon, BuildContext _context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: _iconPadding-1.2),
      child: GestureDetector(
        child: Icon(_icon, color: Colors.black, size: _iconSize),
        onTap: (){
          Navigator.of(context).pop(true);
          return Future.value(false);          
        })
    );
  }

  Widget _buildGameInfo() {
    double height = 175, width = 175;
    // final stats = Provider.of<GameStats>(context);
    return  Consumer<GameStats>(
      builder: (context, stats, _ ) => Stack( children: <Widget>[
          Align(alignment: FractionalOffset(1.13,-.06),
            child: Container(height: height, width: width,
              child: AspectRatio(aspectRatio: 1,
                child: CountDown(),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, top: 10.0),
            child: Row(
              children: <Widget>[
                Row(children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text("Correct:"),
                      Text("Wrong:")
                  ]),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(children: <Widget>[
                      Text("${stats.correct}"),
                      Text("${stats.total-stats.correct}")
                    ],),
                  )
              ])
            ])
        )]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.gameSettings["header"], 
                style: TextStyle(color: Colors.black),),
        backgroundColor: Color(0XFFF2F7FB),
        elevation: 0.5,
        leading: _buildIcon(Icons.arrow_back, context),
      ),
      body: ChangeNotifierProvider(
        builder: (context) => GameStats(),
        child: Column(children: <Widget>[
          _buildGameInfo(),
          Calculator(widget.gameSettings)
          // Calculator(widget.gameSettings)
        ]),
      )
    );
  }
}
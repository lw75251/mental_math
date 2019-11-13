import 'package:flutter/material.dart';
import 'package:mental_math/custom/calculator.dart';
import 'package:mental_math/custom/circle_header.dart';
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
        child: Icon(_icon, color: Colors.white, size: _iconSize),
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
          Align(alignment: FractionalOffset(1.1,-.06),
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
        // centerTitle: true,
        // title: Text(widget.gameSettings["header"], 
        //         style: TextStyle(color: Colors.white),),
        backgroundColor: Color(0XFFc59e9f),
        elevation: 0,
        leading: _buildIcon(Icons.arrow_back, context),
      ),

        // ChangeNotifierProvider(  
        //   builder: (context) => GameStats(),
        //   child: Container(
        //     decoration: BoxDecoration(
        //       gradient: LinearGradient(
        //         begin: Alignment.topCenter,
        //         end: Alignment.bottomCenter,
        //         colors: [Color(0xFF5E6680),Color(0xFF3B4356)]
        //       )
        //     ),
        //     child: Column(children: <Widget>[
        //       _buildGameInfo(),
        //       Calculator(widget.gameSettings)
        //       // Calculator(widget.gameSettings)
        //     ]),
        //   ),
        // ),

      body: ChangeNotifierProvider(  
          builder: (context) => GameStats(),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF5E6680),Color(0xFF3B4356)]
              )
            ),
            child: Column(children: <Widget>[
              Stack(children: <Widget>[
                HalfCircle(
                  child: Container( 
                    height: MediaQuery.of(context).size.height/6.5,
                    width: MediaQuery.of(context).size.width,
                    // color: Colors.blue,)
                    color: Color(0xFFC59E9F),
                  ),
                ),
                _buildGameInfo()
              ]),

              Calculator(widget.gameSettings)
            ]),
          )
      )
    );
  }
}
import 'package:flutter/material.dart';
import 'package:mental_math/custom/calculator.dart';
import 'package:mental_math/custom/circle_header.dart';
import 'package:mental_math/custom/timer.dart';
import 'package:mental_math/models/game_stats.dart';
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
    double height = 110, width = 110;
    final infoStyle = TextStyle(color: Colors.white, fontSize: 18);
    final scoreStyle = TextStyle(color: Colors.white, fontSize: 30);
    return  Consumer<GameStats>(
      builder: (context, stats, _ ) => 
      Container(width: MediaQuery.of(context).size.width,
      height: 200,
        child:Stack( children: <Widget>[
          Align(alignment: FractionalOffset(1.05,0),
            child: Container(height: height, width: width,
              child: AspectRatio(aspectRatio: 1,
                child: CountDown(),
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 0, top: 40),
            child: Container(
              child: Row(
                children: <Widget>[
                  _buildIcon(Icons.arrow_back, context),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0),
                    child: Text("Correct: ${stats.correct}", style: infoStyle,),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: Text("Wrong: ${stats.wrong}", style: infoStyle,),
                  ),
                ]),
            ),
          ),
          Align(alignment: FractionalOffset(0.5, .6),
              child: Text("Score: ${stats.score}", style: scoreStyle),
          )
      ]),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      builder: (context) => GameStats(),
      child: Stack(children: <Widget>[
        Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Color(0XFFc59e9f),
            elevation: 0,
          ),
          body: 
          // ChangeNotifierProvider(  
          //     builder: (context) => GameStats(),
          //     child: Container(
            Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Color(0xFF5E6680),Color(0xFF3B4356)]
                  )
                ),
                child: Column( children: <Widget>[
                    Stack(children: <Widget>[
                      HalfCircle(
                        child: Container( 
                          height: MediaQuery.of(context).size.height/6.5,
                          width: MediaQuery.of(context).size.width,
                          // color: Colors.blue,)
                          color: Color(0xFFC59E9F),
                        ),
                      ),
                  ]),
                  Calculator(widget.gameSettings)
                ]),
              )
        ),
        Material(child: _buildGameInfo(), color: Color(0x00000000),),
      ]),
    );
  }
}
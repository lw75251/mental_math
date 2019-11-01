import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mental_math/custom/game_stats.dart';
import 'package:provider/provider.dart';

class Calculator extends StatefulWidget {
  final Map<String, String> gameSettings;
  const Calculator(
    this.gameSettings,
    {Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final Random _random = Random();
  
  // Difficulty level


  Map<String,int> type = {
    "Add": 0,
    "Subtract": 1,
    "Multiply": 2,
    "Divide" : 3,
    "Custom" : 4,
  };

  // Question Related Variables
  int activeIndex;
  int difficulty;

  int top;
  int bottom;
  List<int> answer = new List(4);
  List<String> operators = ["+","-","x","/"];

  String display = "";
  String _operator;

  void newQuestion() {
    if ( difficulty == 0 ) {
      top = next(1,10);
      bottom = next(1,10);
    }
    else if (difficulty == 1 ) {
      top = next(10,99);
      bottom = next(1,99);
    }
    else {
      top = next(100,999);
      bottom = next(10,999);
    }
    updateAnswers();
  }

  void updateAnswers() {
    answer[0] = top + bottom;
    answer[1] = top - bottom;
    answer[2] = top * bottom;
    answer[3] = top ~/ bottom;
  }
  
  @override
  void initState() {
    difficulty = int.parse(widget.gameSettings["difficulty"]);
    newQuestion();
    updateAnswers();
    activeIndex = type[widget.gameSettings["header"]];
    _operator = operators[activeIndex];

    super.initState();
  }

  /// Generates a number between the min and max range
  int next(int min, int max) => min + _random.nextInt(max - min);

  Widget _buildDisplay(){
    TextStyle style = TextStyle(
      fontSize: 40,
      letterSpacing: 10,
      color: Colors.black,
    );
    return Container(
      child: Column(
        children: <Widget>[
        Text(top.toString(), style: style),
        Row(children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 1.0),
            child: Text(_operator, style: style),
          ),
          Text(bottom.toString(), style: style),
        ]),
        
        Text(display.toString(), style: style)
        
      ]),
    );
  }

  Widget _buildTile(int i) {
    return SizedBox(
      width: 100,
      height: 50,
      child: MaterialButton(
        child: Text(i.toString()),
        color: Colors.blueAccent,
        onPressed: (){
          display += i.toString();
          setState(() {});
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print(difficulty);
    final stats = Provider.of<GameStats>(context); 
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height/2,
      child: Column(
        children: <Widget>[
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            _buildDisplay(),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            _buildTile(1),
            _buildTile(2),
            _buildTile(3),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            _buildTile(4),
            _buildTile(5),
            _buildTile(6),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            _buildTile(7),
            _buildTile(8),
            _buildTile(9),
          ]),
          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
            MaterialButton(
              child: Text("Clear"),
              onPressed: (){
                display = "";
                setState(() {});
              },
            ),
            _buildTile(0),
            MaterialButton(
              child: Text("Submit"),
              onPressed: (){

                bool outcome = int.parse(display) == answer[activeIndex];
                stats.stats = outcome;

                if( outcome ){
                  // Correct UI
                  print("correct");
                } else {
                  // Wrong UI
                  print("wrong");
                }
                display = "";
                newQuestion();
              },
            )        
          ])
        ],
      ),
    );
  }
}

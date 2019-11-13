import 'dart:math';

import 'package:flutter/material.dart';
import 'package:mental_math/models/game_stats.dart';

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
  String header;

  int top;
  int bottom;
  List<int> answer = new List(4);
  List<String> operators = ["+","-","x","/"];

  String display = "";
  String _operator;

  void newQuestion(String header ) {
    if (header == "Add" ) 
      newAddQuestion();
    else if ( header == "Subtract" ) 
      newSubtractQuestion();
    else if ( header == "Multiply" )
      newMultiplyQuestion();
    else if ( header == "Divide" )
      newDivideQuestion();
    else {
      activeIndex = next(0,3);
      _operator = operators[activeIndex];
      if ( activeIndex == 0 ) 
        newAddQuestion();
      else if ( activeIndex == 1 )
        newSubtractQuestion();
      else if ( activeIndex == 2 )
        newMultiplyQuestion();
      else
        newDivideQuestion();
    }

    updateAnswers();
  }

  void newAddQuestion() {
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
  }

  void newSubtractQuestion() {
    if ( difficulty == 0 ) {
      top = next(1,10);
      bottom = next(1,top);
    }
    else if (difficulty == 1 ) {
      top = next(10,99);
      bottom = next(1,top);
    }
    else {
      top = next(100,999);
      bottom = next(10,top);
    }
  }

  void newMultiplyQuestion() {
    if ( difficulty == 0 ) {
      top = next(1,10);
      bottom = next(1,10);
    }
    else if (difficulty == 1 ) {
      top = next(10,99);
      bottom = next(1,10);
    }
    else {
      top = next(10,99);
      bottom = next(10,99);
    }
  } 

  void newDivideQuestion() {
    if ( difficulty == 0 ) {
      top = next(1,10);
      bottom = next(1,10);
    }
    else if (difficulty == 1 ) {
      top = next(10,99);
      bottom = next(1,10);
    }
    else {
      top = next(10,99);
      bottom = next(10,99);
    }
  } 

  void updateAnswers() {
    answer[0] = top + bottom;
    answer[1] = top - bottom;
    answer[2] = top * bottom;
    answer[3] = top ~/ bottom;
  }
  
  @override
  void initState() {
    header = widget.gameSettings["header"];
    difficulty = int.parse(widget.gameSettings["difficulty"]);
    activeIndex = type[header];

    if (activeIndex != 4 )
      _operator = operators[activeIndex];

    newQuestion(header);
    super.initState();
  }

  /// Generates a number between the min and max range
  int next(int min, int max) => min + _random.nextInt(max - min);

  Widget _buildDisplay(){
    TextStyle style = TextStyle(
      fontSize: 40,
      letterSpacing: 10,
      color: Colors.white,
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
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.white, width: 1.0),
        child: Container(
          height: 70,
          child: Center(
            child: Text(i.toString(), 
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600
              )),
          ),
        ),
        onPressed: (){},
      ),
    );
  }

  Widget _buildActionButton(String str, ) {
    return Expanded(
      child: OutlineButton(
        borderSide: BorderSide(color: Colors.white, width: 1.0),
        child: Container(
          height: 70,
          child: Center(
            child: Text(str, 
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600
              )),
          ),
        ),
        onPressed: (){},
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final stats = Provider.of<GameStats>(context); 
    return Expanded(
      // width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height/2,
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
            _buildActionButton("AC"),
            _buildTile(0),
            _buildActionButton("Submit")
            // MaterialButton(
            //   child: Text("Submit"),
            //   onPressed: (){

            //     bool outcome = int.parse(display) == answer[activeIndex];
            //     stats.stats = outcome;

            //     if( outcome ){
            //       // Correct UI
            //       print("correct");
            //     } else {
            //       // Wrong UI
            //       print("wrong");
            //     }
            //     display = "";
            //     newQuestion(header);
            //   },
            // )        
          ])
        ],
      ),
    );
  }
}

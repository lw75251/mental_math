import 'dart:math';

import 'package:flutter/material.dart';

class Calculator extends StatefulWidget {
  final Map<String, String> gameSettings;
  const Calculator(
    this.gameSettings,
    {Key key}) : super(key: key);

  @override
  _CalculatorState createState() => _CalculatorState();
}

class _CalculatorState extends State<Calculator> {
  final int input = 0;
  final Random _random = Random();
  final bool generateQuestion = true;
  
  int activeIndex;
  int top;
  int bottom;
  List<int> answer = new List(4);

  String display = "";

  void updateAnswers() {
    answer[0] = top + bottom;
    answer[1] = top - bottom;
    answer[2] = top * bottom;
    answer[3] = top ~/ bottom;
  }
  
  @override
  void initState() { 
    top = next(0,10);
    bottom = next(0,10);
    activeIndex = int.parse(widget.gameSettings["difficulty"]);

    answer[0] = top + bottom;
    answer[1] = top - bottom;
    answer[2] = top * bottom;
    answer[3] = top ~/ bottom;

    super.initState();
  }

  /// Generates a number between the min and max range
  int next(int min, int max) => min + _random.nextInt(max - min);

  String get val => input.toString();

  Widget _buildDisplay(){
    return Container(
      child: Column(
        children: <Widget>[
        Text(top.toString()),
        Text(bottom.toString()),
        Text(display.toString())
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
                if( int.parse(display) == answer[activeIndex] ){
                  // Correct UI
                  print("correct");
                } else {
                  // Wrong UI
                  print("wrong");
                }
              },
            )        
          ])
        ],
      ),
    );
  }
}

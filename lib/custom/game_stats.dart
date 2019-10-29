import 'package:flutter/material.dart';

class GameStats with ChangeNotifier {
  int _correct = 0;
  int _score = 0;
  int _total = 0;

  GameStats();

  int get correct => _correct;
  int get score => _score;
  int get total => _total;


  // Outcome can either be true if the question was answered correctly
  // or false if it wasn't answered correctly
  set stats(bool outcome) {
    
    if ( outcome ) {
      _correct++;
      _score += 2;
    } 

    _total++;
    notifyListeners();
  }
}
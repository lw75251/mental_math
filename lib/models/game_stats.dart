import 'package:flutter/material.dart';

class GameStats with ChangeNotifier {
  int _correct = 0;
  int _total = 0;

  GameStats();

  int get correct => _correct;
  int get score => _correct*2;
  int get total => _total;
  int get wrong => _total-_correct;


  // Outcome can either be true if the question was answered correctly
  // or false if it wasn't answered correctly
  set stats(bool outcome) {
    
    if ( outcome ) {
      _correct++;
    } 

    _total++;
    notifyListeners();
  }
}
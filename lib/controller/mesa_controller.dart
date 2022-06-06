import 'package:flutter/material.dart';

class MesaController extends ChangeNotifier {

  String tableMessage = GameStatus.REVEAL_CARDS;

  void startCount() {
    tableMessage = GameStatus.START_COUNT;
    notifyListeners();
  }

  void changeStatus(String status) {
    tableMessage = status;
    notifyListeners();
  }
}

class GameStatus {
  static const NEW_GAME = "Start new voting";
  static const VOTING = "Pick your cards";
  static const REVEAL_CARDS = "Reveal cards";
  static const START_COUNT = "Start timer";
}

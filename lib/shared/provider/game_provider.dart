import 'package:flutter/material.dart';

import '../models/game_status.dart';
import '../models/player_model.dart';

class GameProvider extends ChangeNotifier {
  Set<PlayerModel> players = <PlayerModel>{};
  GameStatus gameStatus = GameStatus.VOTING;

  void addPlayers(List<PlayerModel> list) {
    players.clear();
    players.addAll(list);
    notifyListeners();
  }

  void changeStatus(GameStatus newGameStatus) {
    gameStatus = newGameStatus;
    notifyListeners();
  }
}

import 'package:flutter/material.dart';

import '../models/player_model.dart';

class GameProvider extends ChangeNotifier {
  Set<PlayerModel> players = <PlayerModel>{};

  void addPlayers(List<PlayerModel> list) {
    players.clear();
    players.addAll(list);
    notifyListeners();
  }
}

import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/shared/repositories/local_storedge_repository.dart';

import '../core/globals.dart';
import '../core/web_socket_config.dart';
import '../models/player_model.dart';

//TODO transformar em classe
AppBar customAppBar() {
  LocalStoredgeRepository localStoredge = LocalStoredgeRepository();
  return AppBar(
    title: Text('Free Planning Poker'),
    actions: [
      IconButton(
        onPressed: () {
          socketClient.send(destination: RESET);
        },
        icon: Icon(Icons.clear),
        tooltip: 'Reset',
      ),
      IconButton(
        onPressed: () {
          if (gameProvider.players.isEmpty) return;
          PlayerModel removedPlayer = gameProvider.players.first;
          socketClient.send(destination: UNREGISTER, body: removedPlayer.name);
          localStoredge.clearData();
        },
        icon: Icon(Icons.remove),
        tooltip: 'Remove',
      ),
      IconButton(
        onPressed: () {
          socketClient.send(destination: REGISTER, body: "Fulano");
        },
        icon: Icon(Icons.add),
        tooltip: 'Add',
      ),
    ],
  );
}

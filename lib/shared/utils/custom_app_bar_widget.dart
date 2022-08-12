import 'package:flutter/material.dart';

import '../core/globals.dart';
import '../models/player_model.dart';

//TODO transformar em classe
AppBar customAppBar() {
  final RESET = '/app/resetList';
  final UNREGISTER = '/app/unregister';
  final REGISTER = '/app/register';

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
      IconButton(
        onPressed: () {
          socketClient.activate();
        },
        icon: Icon(Icons.account_circle),
        tooltip: 'Connect',
      ),
      IconButton(
        onPressed: () {
          socketClient.deactivate();
        },
        icon: Icon(Icons.remove),
        tooltip: 'Disconnect',
      ),
    ],
  );
}

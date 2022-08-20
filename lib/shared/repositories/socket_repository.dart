import 'package:planning_poker_flutter/shared/models/player_model.dart';

import '../core/globals.dart';
import '../core/web_socket_config.dart';

class SocketRepository {

  void removePlayer(PlayerModel player) {
    socketClient.send(destination: UNREGISTER, body: player.name);
  }

  void addPlayer(PlayerModel player) {
    socketClient.send(destination: REGISTER, body: player.name);
  }

}
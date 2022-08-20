import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/shared/repositories/local_storedge_repository.dart';
import 'package:planning_poker_flutter/shared/repositories/player_repository.dart';
import 'package:planning_poker_flutter/shared/repositories/socket_repository.dart';

class LoadingWidget extends StatelessWidget {
  final Widget child;
  final PlayerRepository repository = PlayerRepository(Dio());

  LoadingWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      //TODO utilizar um healthCheck pra ver se servidor está respondendo
      future: loadPlayers(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return child;
        }
        if (snapshot.hasError) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Text(snapshot.error.toString(), textScaleFactor: 2),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  Future loadPlayers() {
    return Future(() async {
      await repository.listPlayers();
      var localStoradge = LocalStoredgeRepository();
      var playerLogged = await localStoradge.getPlayerLogged();
      if(playerLogged != null) {
        var socket = SocketRepository();
        socket.addPlayer(playerLogged);
      }
    });
  }
}

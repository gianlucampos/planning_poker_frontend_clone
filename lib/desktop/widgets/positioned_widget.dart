import 'package:flutter/material.dart';

import '../../shared/core/globals.dart';
import '../../shared/models/player_model.dart';
import 'player/jogador_widget.dart';
import 'table/mesa_widget.dart';

enum Direction { TOP, BOTTOM, LEFT, RIGHT }

Direction direction = Direction.TOP;
bool isAdded = false;
List<Widget> widgetsTop = [];
List<Widget> widgetsBottom = [];
List<Widget> widgetsLeft = [];
List<Widget> widgetsRight = [];

class PositionedWidget extends StatefulWidget {
  const PositionedWidget({Key? key}) : super(key: key);

  @override
  State<PositionedWidget> createState() => _PositionedWidgetState();
}

class _PositionedWidgetState extends State<PositionedWidget> {
  List<PlayerModel> playersScreen = [];

  @override
  void initState() {
    super.initState();
    socketClient.send(destination: '/app/list');
    gameProvider.addListener(() {
      if(!this.mounted) return;
      setState(() {
        loadPlayers();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgetsTop,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(children: widgetsLeft),
              MesaWidget(),
              Column(children: widgetsRight),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widgetsBottom,
          ),
        ],
      ),
    );
  }

  void loadPlayers() {
    reset();
    gameProvider.players.forEach((player) {
      if (playersScreen.any((p) => p.name == player.name)) return;
      playersScreen.add(player);
      addPlayer(player);
    });
  }

  void reset() {
    playersScreen = [];
    direction = Direction.TOP;
    isAdded = false;
    widgetsTop = [];
    widgetsBottom = [];
    widgetsLeft = [];
    widgetsRight = [];
  }

  void addPlayer(PlayerModel player) {
    buildTop(player);
    if (isAdded) {
      isAdded = false;
      return;
    }
    buildLeft(player);
    if (isAdded) {
      isAdded = false;
      return;
    }
    buildRight(player);
    if (isAdded) {
      isAdded = false;
      return;
    }
    buildBottom(player);
    isAdded = false;
  }

  void buildTop(PlayerModel player) {
    if (widgetsTop.length >= 8) return;

    if (direction == Direction.TOP) {
      widgetsTop.add(JogadorWidget(player: player));
      direction = Direction.BOTTOM;
      isAdded = true;
      super.setState(() {});
    }
  }

  void buildLeft(PlayerModel player) {
    if (direction == Direction.LEFT) {
      widgetsLeft.add(JogadorWidget(player: player));
      direction = widgetsRight.length < 3 ? Direction.RIGHT : Direction.BOTTOM;
      isAdded = true;
      super.setState(() {});
    }
  }

  void buildRight(PlayerModel player) {
    if (direction == Direction.RIGHT) {
      widgetsRight.add(JogadorWidget(player: player));
      super.setState(() {});
      direction = Direction.TOP;
      isAdded = true;
    }
  }

  void buildBottom(PlayerModel player) {
    if (widgetsBottom.length >= 8) return;
    if (direction == Direction.BOTTOM) {
      widgetsBottom.add(JogadorWidget(player: player));
      isAdded = true;
      direction = widgetsLeft.length < 3 ? Direction.LEFT : Direction.TOP;
      super.setState(() {});
    }
  }
}

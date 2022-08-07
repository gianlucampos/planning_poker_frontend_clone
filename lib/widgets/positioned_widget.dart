import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/widgets/table/mesa_widget.dart';

import '../core/globals.dart';
import '../models/player_model.dart';
import 'player/jogador_widget.dart';

enum Direction { TOP, BOTTOM, LEFT, RIGHT }

Direction direction = Direction.TOP;
bool isAdded = false;
double topLeftRight = 0;
double topLeftBottom = 0;
double bottomRightTop = 0;
double bottomLeftRight = 0;
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
    socketClient.activate();
    gameProvider.addListener(() {
      setState(() {
        loadPlayers();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: MediaQuery.of(context).size.height * 0.7,
        width: MediaQuery.of(context).size.width * 0.53,
        child: Stack(
          children: [
            Stack(children: widgetsTop),
            Stack(children: widgetsLeft),
            Stack(children: widgetsRight),
            Stack(children: widgetsBottom),
            Positioned(
              top: MediaQuery.of(context).size.width * 0.10,
              left: MediaQuery.of(context).size.width * 0.12,
              child: MesaWidget(),
            ),
          ],
        ),
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
    topLeftRight = 0;
    topLeftBottom = 0;
    bottomRightTop = 0;
    bottomLeftRight = 0;
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
      var p = Positioned(
        left: topLeftRight += 100.00,
        child: JogadorWidget(player: player),
      );
      widgetsTop.add(p);
      direction = Direction.BOTTOM;
      isAdded = true;
      super.setState(() {});
    }
  }

  void buildLeft(PlayerModel player) {
    if (direction == Direction.LEFT) {
      widgetsLeft.add(Positioned(
        top: topLeftBottom += 125.00,
        child: JogadorWidget(player: player),
      ));
      direction = widgetsRight.length < 3 ? Direction.RIGHT : Direction.BOTTOM;
      isAdded = true;
      super.setState(() {});
    }
  }

  void buildRight(PlayerModel player) {
    if (direction == Direction.RIGHT) {
      widgetsRight.add(Positioned(
        left: MediaQuery.of(context).size.width * 0.47,
        top: bottomRightTop += 125.00,
        child: JogadorWidget(player: player),
      ));
      super.setState(() {});
      direction = Direction.TOP;
      isAdded = true;
    }
  }

  void buildBottom(PlayerModel player) {
    if (widgetsBottom.length >= 8) return;
    if (direction == Direction.BOTTOM) {
      widgetsBottom.add(Positioned(
        top: MediaQuery.of(context).size.width * 0.24,
        left: bottomLeftRight += 100.00,
        child: JogadorWidget(player: player),
      ));
      isAdded = true;
      direction = widgetsLeft.length < 3 ? Direction.LEFT : Direction.TOP;
      super.setState(() {});
    }
  }
}

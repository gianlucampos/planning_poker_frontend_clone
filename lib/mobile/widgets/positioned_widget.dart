import 'package:flutter/material.dart';

import '../../shared/core/globals.dart';
import '../../shared/models/player_model.dart';
import 'player/jogador_widget.dart';
import 'mesa/mesa_widget.dart';

enum Direction { top, bottom, left, right }

Direction direction = Direction.top;
bool isAdded = false;
double spacer = 70;
double topLeftRight = 50;
double topLeftBottom = 0;
double bottomRightTop = 0;
double bottomLeftRight = 50;
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
      child: SizedBox(
        child: Stack(
          children: [
            Stack(children: widgetsTop),
            Stack(children: widgetsLeft),
            Stack(children: widgetsRight),
            Stack(children: widgetsBottom),
            const Center(child: MesaWidget()),
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
    direction = Direction.top;
    isAdded = false;
    topLeftRight = 50;
    topLeftBottom = 0;
    bottomRightTop = 0;
    bottomLeftRight = 50;
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
    if (widgetsTop.length >= 5) return;
    if (direction == Direction.top) {
      topLeftRight =
          widgetsTop.isEmpty ? topLeftRight : (topLeftRight + spacer);

      var widget = Positioned(
        top: MediaQuery.of(context).size.height * 0.05,
        left: topLeftRight,
        child: JogadorWidget(player: player),
      );
      widgetsTop.add(widget);
      direction = Direction.bottom;
      isAdded = true;
      super.setState(() {});
    }
  }

  void buildLeft(PlayerModel player) {
    if (direction == Direction.left) {
      widgetsLeft.add(Positioned(
        top: topLeftBottom += 125.00,
        child: JogadorWidget(player: player),
      ));
      direction = widgetsRight.length < 2 ? Direction.right : Direction.bottom;
      isAdded = true;
      super.setState(() {});
    }
  }

  void buildRight(PlayerModel player) {
    if (direction == Direction.right) {
      widgetsRight.add(Positioned(
        top: bottomRightTop += 125.00,
        right: MediaQuery.of(context).size.width * 0.05,
        child: JogadorWidget(player: player),
      ));
      super.setState(() {});
      direction = Direction.top;
      isAdded = true;
    }
  }

  void buildBottom(PlayerModel player) {
    if (widgetsBottom.length >= 4) return;
    bottomLeftRight =
        widgetsBottom.isEmpty ? bottomLeftRight : (bottomLeftRight + spacer);
    if (direction == Direction.bottom) {
      widgetsBottom.add(Positioned(
        top: MediaQuery.of(context).size.height * 0.55,
        left: bottomLeftRight,
        child: JogadorWidget(player: player),
      ));
      // isAdded = true;
      direction = widgetsLeft.length < 3 ? Direction.left : Direction.top;
      super.setState(() {});
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/widgets/table/mesa_widget.dart';

import '../models/player_model.dart';
import '../repositories/player_repository.dart';
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
  final repository = PlayerRepository(Dio());
  List<PlayerModel> listPlayers = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      repository
          // .listPlayers()
          .listPlayersMock()
          .then((value) => listPlayers = value)
          .whenComplete(() => super.setState(() {
                loadPlayers();
              }));
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
    listPlayers.forEach((player) {
      addPlayer(player);
    });
  }

  void addPlayer(PlayerModel player) {
    String vote = player.vote!;
    String name = player.name!;

    buildTop(vote, name);
    if (isAdded) {
      isAdded = false;
      return;
    }
    buildLeft(vote, name);
    if (isAdded) {
      isAdded = false;
      return;
    }
    buildRight(vote, name);
    if (isAdded) {
      isAdded = false;
      return;
    }
    buildBottom(vote, name);
    isAdded = false;
  }

  void buildTop(String vote, String nome) {
    if (widgetsTop.length >= 8) return;
    if (direction == Direction.TOP) {
      var p = Positioned(
        left: topLeftRight += 100.00,
        child: JogadorWidget(nome: nome, voto: vote),
      );
      widgetsTop.add(p);
      direction = Direction.BOTTOM;
      isAdded = true;
      super.setState(() {});
    }
  }

  void buildLeft(String vote, String nome) {
    if (direction == Direction.LEFT) {
      widgetsLeft.add(Positioned(
        top: topLeftBottom += 125.00,
        child: JogadorWidget(nome: nome, voto: vote),
      ));
      direction = widgetsRight.length < 3 ? Direction.RIGHT : Direction.BOTTOM;
      isAdded = true;
      super.setState(() {});
    }
  }

  void buildRight(String vote, String name) {
    if (direction == Direction.RIGHT) {
      widgetsRight.add(Positioned(
        left: MediaQuery.of(context).size.width * 0.47,
        top: bottomRightTop += 125.00,
        child: JogadorWidget(nome: name, voto: vote),
      ));
      super.setState(() {});
      direction = Direction.TOP;
      isAdded = true;
    }
  }

  void buildBottom(String vote, String name) {
    if (widgetsBottom.length >= 8) return;
    if (direction == Direction.BOTTOM) {
      widgetsBottom.add(Positioned(
        top: MediaQuery.of(context).size.width * 0.24,
        left: bottomLeftRight += 100.00,
        child: JogadorWidget(nome: name, voto: vote),
      ));
      isAdded = true;
      direction = widgetsLeft.length < 3 ? Direction.LEFT : Direction.TOP;
      super.setState(() {});
    }
  }
}

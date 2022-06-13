import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/provider/contador_provider.dart';
import 'package:planning_poker_flutter/provider/rotate_card_provider.dart';
import 'package:provider/provider.dart';

import '../models/game_status.dart';

class MesaWidget extends StatefulWidget {
  const MesaWidget({Key? key}) : super(key: key);

  @override
  State<MesaWidget> createState() => _MesaWidgetState();
}

class _MesaWidgetState extends State<MesaWidget> {
  late ContadorProvider contador =
      Provider.of<ContadorProvider>(context, listen: false);
  GameStatus gameStatus = GameStatus.REVEAL_CARDS;

  @override
  void initState() {
    super.initState();
    contador.addListener(() {
      if (contador.segundos == 0) {
        gameStatus = GameStatus.NEW_GAME;
        Provider.of<RotateCardProvider>(context, listen: false).revelarCard();
      }
    });
  }

  void statusController() {
    switch (gameStatus) {
      case GameStatus.VOTING:
        setState(() {
          gameStatus = GameStatus.REVEAL_CARDS;
        });
        break;
      case GameStatus.REVEAL_CARDS:
        contador.start();
        break;
      case GameStatus.NEW_GAME:
        Provider.of<RotateCardProvider>(context, listen: false).reset();
        setState(() {
          gameStatus = GameStatus.VOTING;
        });
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 150),
        child: TextButton(
          onPressed: statusController,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: SizedBox(
              width: 200,
              height: 200,
              child: Consumer<ContadorProvider>(
                builder: (context, contadorProvider, widget) {
                  return Center(
                    child: Text(
                      contadorProvider.isActive
                          ? '${contadorProvider.segundos}'
                          : '${gameStatus.value}',
                      textScaleFactor: 1.5,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

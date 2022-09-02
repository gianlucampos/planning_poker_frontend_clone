import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/shared/core/globals.dart';
import 'package:provider/provider.dart';

import '../../../shared/models/game_status.dart';
import '../../../shared/provider/contador_provider.dart';
import '../../../shared/provider/rotate_card_provider.dart';
import '../../../shared/provider/voto_provider.dart';

class MesaWidget extends StatefulWidget {
  const MesaWidget({Key? key}) : super(key: key);

  @override
  State<MesaWidget> createState() => _MesaWidgetState();
}

class _MesaWidgetState extends State<MesaWidget> {
  late ContadorProvider contador =
      Provider.of<ContadorProvider>(context, listen: false);
  late GameStatus gameStatus = gameProvider.gameStatus;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    gameProvider.addListener(() {
      setState(() {
        gameStatus = gameProvider.gameStatus;
      });
    });
    contador.addListener(() {
      if (contador.segundos == 0) {
        gameProvider.changeStatus(GameStatus.NEW_GAME);
        Provider.of<RotateCardProvider>(context, listen: false).revelarCard();
      }
    });
  }

  void statusController() {
    switch (gameStatus) {
      case GameStatus.VOTING:
        gameProvider.changeStatus(GameStatus.REVEAL_CARDS);
        break;
      case GameStatus.REVEAL_CARDS:
        contador.start();
        break;
      case GameStatus.NEW_GAME:
        gameProvider.changeStatus(GameStatus.VOTING);
        Provider.of<RotateCardProvider>(context, listen: false).reset();
        Provider.of<VotoProvider>(context, listen: false).reset();
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

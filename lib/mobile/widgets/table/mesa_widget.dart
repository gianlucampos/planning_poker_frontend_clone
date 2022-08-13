import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/models/game_status.dart';
import '../../../shared/provider/contador_provider.dart';
import '../../../shared/provider/game_status_provider.dart';
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
  late GameStatusProvider gameStatusProvider =
      Provider.of<GameStatusProvider>(context, listen: false);
  late GameStatus gameStatus = gameStatusProvider.gameStatus;

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    gameStatusProvider.addListener(() {
      setState(() {
        gameStatus = gameStatusProvider.gameStatus;
      });
    });
    contador.addListener(() {
      if (contador.segundos == 0) {
        gameStatusProvider.changeStatus(GameStatus.NEW_GAME);
        Provider.of<RotateCardProvider>(context, listen: false).revelarCard();
      }
    });
  }

  void statusController() {
    switch (gameStatus) {
      case GameStatus.VOTING:
        gameStatusProvider.changeStatus(GameStatus.REVEAL_CARDS);
        break;
      case GameStatus.REVEAL_CARDS:
        contador.start();
        break;
      case GameStatus.NEW_GAME:
        gameStatusProvider.changeStatus(GameStatus.VOTING);
        Provider.of<RotateCardProvider>(context, listen: false).reset();
        Provider.of<VotoProvider>(context, listen: false).reset();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextButton(
        onPressed: statusController,
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: SizedBox(
            width: 100,
            height: 100,
            child: Consumer<ContadorProvider>(
              builder: (context, contadorProvider, widget) {
                return Center(
                  child: Text(
                    contadorProvider.isActive
                        ? '${contadorProvider.segundos}'
                        : '${gameStatus.value}',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

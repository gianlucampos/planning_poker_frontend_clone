import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/models/player_model.dart';
import 'package:planning_poker_flutter/widgets/positioned_widget.dart';

import '../core/globals.dart';
import '../widgets/card/choose_card_widget.dart';
import '../widgets/utils/custom_text_buttom.dart';

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Free Planning Poker'),
        actions: [
          buildTextButton(
            text: "Reset List",
            function: () {
              socketClient.send(destination: '/app/resetList');
            },
          ),
          buildTextButton(
            text: 'List Players',
            function: () {
              socketClient.send(destination: '/app/list');
            },
          ),
          //TODO - Excluir nao atualiza em tempo real
          buildTextButton(
            text: "Remove player",
            function: () {
              if (gameProvider.players.isEmpty) return;
              PlayerModel removedPlayer = gameProvider.players.first;
              socketClient.send(
                  destination: '/app/unregister', body: removedPlayer.name);
            },
          ),
          buildTextButton(
            text: "Connect",
            function: () {
              socketClient.activate();
            },
          ),
          buildTextButton(
            text: "Disconnect",
            function: () {
              socketClient.deactivate();
            },
          ),
        ],
      ),
      body: PositionedWidget(),
      bottomNavigationBar: ChooseCardWidget(),
    );
  }
}

import 'package:flutter/material.dart';

import '../../shared/core/globals.dart';
import '../../shared/models/player_model.dart';
import '../../shared/utils/custom_text_buttom.dart';
import '../widgets/positioned_widget.dart';
import '../widgets/card/choose_card_widget.dart';

class HomePageMobile extends StatefulWidget {
  HomePageMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
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

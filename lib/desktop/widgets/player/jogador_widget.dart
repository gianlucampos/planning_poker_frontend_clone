import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/models/player_model.dart';
import '../../../shared/provider/rotate_card_provider.dart';
import '../rotate_widget.dart';

class JogadorWidget extends StatelessWidget {
  final PlayerModel player;

  const JogadorWidget({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool shouldFlip =
        Provider.of<RotateCardProvider>(context, listen: true).shouldFlip();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotateWidget(card: shouldFlip ? CardVoto() : CardBranco()),
            SizedBox(height: 15),
            Text(
              player.name!,
              textScaleFactor: 1,
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            )
          ]),
    );
  }

  //TODO: implementar 1 widget com herança
  Widget CardVoto() {
    return Container(
      width: 45,
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      child: Center(
        child: Text(
          player.vote!,
          textScaleFactor: 1.5,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget CardBranco() {
    return Container(
      width: 45,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../shared/models/player_model.dart';
import '../../../shared/provider/rotate_card_provider.dart';
import '../../../shared/widgets/rotate_widget.dart';

class JogadorWidget extends StatelessWidget {
  final PlayerModel player;

  const JogadorWidget({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool shouldFlip =
    Provider.of<RotateCardProvider>(context, listen: true).shouldFlip();
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotateWidget(card: shouldFlip ? cardVoto() : cardBranco()),
            const SizedBox(height: 10),
            Text(
              player.name!,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            )
          ]),
    );
  }

  Widget cardVoto() {
    return Container(
      width: 40,
      height: 60,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(7)),
      ),
      child: Center(
        child: Text(
          player.vote!,
          style: const TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget cardBranco() {
    return Container(
      width: 40,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(7)),
      ),
    );
  }
}

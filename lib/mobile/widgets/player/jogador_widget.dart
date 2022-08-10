import 'package:flutter/material.dart';

import '../../../shared/models/player_model.dart';

class JogadorWidget extends StatelessWidget {
  final PlayerModel player;

  const JogadorWidget({Key? key, required this.player}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // cardBranco(),
            cardVoto(),
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

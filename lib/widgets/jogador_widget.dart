import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/widgets/rotate_widget.dart';
import 'package:provider/provider.dart';

import '../controller/jogador_controller.dart';

class JogadorWidget extends StatelessWidget {
  final String nome;
  final String voto;

  const JogadorWidget({Key? key, required this.nome, required this.voto})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isVoted =
        Provider.of<JogadorController>(context, listen: true).flipCard();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotateWidget(card: isVoted ? CardVotado() : CardBranco()),
            SizedBox(height: 15),
            Text(
              nome,
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ]),
    );
  }

  Widget CardVotado() {
    return Container(
      width: 90,
      height: 140,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          voto,
          textScaleFactor: 2,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget CardBranco() {
    return Container(
      width: 90,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}

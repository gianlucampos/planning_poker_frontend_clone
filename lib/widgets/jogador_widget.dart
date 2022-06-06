import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/widgets/rotate_widget.dart';

class JogadorWidget extends StatefulWidget {
  final String nome;
  final String voto;

  const JogadorWidget({Key? key, required this.nome, required this.voto})
      : super(key: key);

  @override
  State<JogadorWidget> createState() => _JogadorWidgetState();
}

class _JogadorWidgetState extends State<JogadorWidget> {
  bool isVotoExibido = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RotateWidget(),
            SizedBox(height: 15),
            Text(
              widget.nome,
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ]),
    );
  }

}

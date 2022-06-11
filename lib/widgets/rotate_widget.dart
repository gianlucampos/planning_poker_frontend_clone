import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/controller/jogador_controller.dart';
import 'package:provider/provider.dart';

class RotateWidget extends StatefulWidget {
  const RotateWidget({Key? key}) : super(key: key);

  @override
  State<RotateWidget> createState() => _RotateWidgetState();
}

class _RotateWidgetState extends State<RotateWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Transform(
            transform: Matrix4.identity()
              ..setEntry(3, 2, 0.001)
              ..rotateY(Math.pi *
                  Provider.of<JogadorController>(context, listen: true).angle),
            alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(Math.pi),
                  child: simpleContainer(),
                ),
              ),
            ),
          )
        ],
      ),
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
          'P',
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

  Widget simpleContainer() {
    return Provider.of<JogadorController>(context, listen: false).flipCard()
        ? CardVotado()
        : CardBranco();
  }
}

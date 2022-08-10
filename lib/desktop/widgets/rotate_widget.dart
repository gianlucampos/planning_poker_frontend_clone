import 'dart:math' as Math;

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../shared/provider/rotate_card_provider.dart';

class RotateWidget extends StatefulWidget {
  final Widget card;

  const RotateWidget({Key? key, required this.card}) : super(key: key);

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
                  Provider.of<RotateCardProvider>(context, listen: false).angle),
            alignment: Alignment.center,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(Math.pi),
                  child: widget.card,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

}

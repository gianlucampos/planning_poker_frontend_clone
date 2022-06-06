import 'dart:async';
import 'dart:math' as Math;

import 'package:flutter/material.dart';

class RotateWidget extends StatefulWidget {
  const RotateWidget({Key? key}) : super(key: key);

  @override
  State<RotateWidget> createState() => _RotateWidgetState();
}

class _RotateWidgetState extends State<RotateWidget> {
  double angle = 0.0;
  double speed = 0.05;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
  }

  void rotate() {
    angle = angle >= 2 ? 0 : angle;
    setState(() {
      angle += speed;
    });
    if (angle >= 1) stop();
  }

  void start() {
    if (_timer == null) {
      _timer = Timer.periodic(const Duration(milliseconds: 5), (_) => rotate());
    }
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
  }

  void reset() {
    super.setState(() {
      angle = 0;
    });
  }

  // 0.0 - 0.5 -> nao mostra
  // 0.5 - 1.5 -> mostra
  bool isBackImage(double ang) {
    return ang >= 0.5 && ang <= 1.5;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
            onPressed: start,
            child: Text("Start"),
          ),
          TextButton(
            onPressed: reset,
            child: Text("Reset"),
          ),
          buildTransform(),
          // buildTransform(),
        ],
      ),
    );
  }

  Transform buildTransform() {
    return Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(Math.pi * angle),
        alignment: Alignment.center,
        child: Align(
            alignment: Alignment.center,
            child: Container(
                child: Transform(
                    alignment: Alignment.center,
                    transform: Matrix4.identity()..rotateY(Math.pi),
                    child: simpleContainer()))));
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
    return isBackImage(angle) ? CardVotado() : CardBranco();
  }
}

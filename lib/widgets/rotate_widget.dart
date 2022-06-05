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
    // initialize();
  }

  void initialize() {
    if (_timer == null) {
      _timer = Timer.periodic(const Duration(milliseconds: 5), (_) => start());
      // _timer = Timer.periodic(const Duration(seconds: 1), (_) => start());
    }
  }

  void start() {
    angle = angle >= 2 ? 0 : angle;
    setState(() {
      angle += speed;
    });
    print(angle.toString());
    if (angle >= 1) stop();
  }

  void stop() {
    _timer?.cancel();
    _timer = null;
    // angle = 0;
  }

  // 0.0 - 0.5 -> nao mostra
  // 0.5 - 1.5 -> mostra
  bool isFrontImage(double ang) {
    return ang >= 0.5 && ang <= 1.5;
    // return ang >= 0.05 && ang <= 0.15;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          TextButton(
            onPressed: () {
              initialize();
            },
            child: Text("Start"),
          ),
          TextButton(
            onPressed: () {
              stop();
            },
            child: Text("Stop"),
          ),
          TextButton(
            onPressed: () {
              super.setState(() {
                angle = 0;
              });
            },
            child: Text("Reset"),
          ),
          buildTransform(),
          Text('Joao')
          // buildTransform(),
        ],
      ),
    ));
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
                color: const Color(0xffaaffff),
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..rotateY(Math.pi),
                  child: simpleContainer(),
                  // child: testingGradient(),
                ))));
  }

  Widget simpleContainer() {
    return Column(
      children: [
        Container(
          child: isFrontImage(angle)
              ? Center(child: Text('P', textScaleFactor: 8))
              : null,
          height: 200,
          width: 200,
          color: Color(0xff74b3ff),
        ),
      ],
    );
  }


}

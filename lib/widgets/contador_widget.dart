import 'dart:async';

import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/controller/contador_controller.dart';

class ContadorWidget extends StatefulWidget {
  final ContadorController contadorController;

  const ContadorWidget({Key? key, required this.contadorController})
      : super(key: key);

  @override
  State<ContadorWidget> createState() => _ContadorWidgetState();
}

class _ContadorWidgetState extends State<ContadorWidget> {
  late ContadorController controller;

  Duration get decDuration => controller.decDuration;

  Timer? get timer => controller.timer;

  @override
  void initState() {
    super.initState();
    controller = widget.contadorController;
    controller.addListener(() {
      if (this.mounted) setState(() {});
    });
    controller.initializeTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Text('${decDuration.inSeconds}',
        textScaleFactor: 2, style: TextStyle(color: Colors.white));
  }
}

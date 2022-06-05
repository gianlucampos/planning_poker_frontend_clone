import 'dart:async';

import 'package:flutter/material.dart';

class StopWatchWidget extends StatefulWidget {
  const StopWatchWidget({Key? key}) : super(key: key);

  @override
  State<StopWatchWidget> createState() => _StopWatchWidgetState();
}

class _StopWatchWidgetState extends State<StopWatchWidget> {
  Duration decDuration = Duration(seconds: 3);
  Timer? timer;

  void initializeTimer() {
    if (timer == null) {
      timer = Timer.periodic(Duration(seconds: 1), (_) => start());
    }
  }

  void start() {
    decreaseTime();
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
  }

  void decreaseTime() {
    final removeSeconds = 1;
    setState(() {
      final seconds = decDuration.inSeconds - removeSeconds;
      if (seconds == 0) timer?.cancel();
      decDuration = Duration(seconds: seconds);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          TextButton(
              onPressed: () {
                setState(() {
                  initializeTimer();
                });
              },
              child: Text('Start')),
          TextButton(
              onPressed: () {
                stopTimer();
              },
              child: Text('Stop')),
          TextButton(
              onPressed: () {
                setState(() {
                  decDuration = Duration(seconds: 3);
                });
              },
              child: Text('Reset')),
          Center(child: Text('${decDuration.inSeconds}', textScaleFactor: 2)),
        ],
      ),
    );
  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';

class ContadorController extends ChangeNotifier {
  Duration decDuration = Duration(seconds: 3);
  Timer? timer;

  void initializeTimer() {
    if (timer == null) {
      timer = Timer.periodic(Duration(seconds: 1), (_) => decreaseTime());
    }
  }

  void stopTimer() {
    timer?.cancel();
    timer = null;
    notifyListeners();
  }

  void decreaseTime() {
    final removeSeconds = 1;
    notifyListeners();
    final seconds = decDuration.inSeconds - removeSeconds;
    if (seconds == 0) stopTimer();
    decDuration = Duration(seconds: seconds);
  }

  void reset() {
    timer?.cancel();
    timer = null;
    decDuration = Duration(seconds: 4);

  }
}

import 'dart:async';

import 'package:flutter/cupertino.dart';

class ContadorProvider extends ChangeNotifier {
  int segundos = 3;
  Timer? timer;
  bool isActive = false;

  start() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => _control());
  }

  stop() {
    isActive = false;
    timer?.cancel();
    segundos = 3;
  }

  _control() {
    isActive = true;
    segundos--;
    notifyListeners();
    if (segundos == 0) stop();
  }
}

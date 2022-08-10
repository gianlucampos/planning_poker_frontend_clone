import 'package:flutter/cupertino.dart';

class VotoProvider extends ChangeNotifier {
  String? voto;
  bool isFirstVote = true;
  bool isReset = false;

  void changeVoto(String? newVoto) {
    isFirstVote = false;
    voto = newVoto;
    notifyListeners();
  }

  void reset() {
    voto = null;
    isFirstVote = true;
    isReset = true;
    notifyListeners();
  }

  @override
  String toString() {
    return 'VotoProvider{voto: $voto, isFirstVote: $isFirstVote, isReset: $isReset}';
  }
}

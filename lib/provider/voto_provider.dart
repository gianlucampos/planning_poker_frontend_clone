import 'package:flutter/cupertino.dart';

class VotoProvider extends ChangeNotifier {
  bool isVoted = true;

  String? voto;

  void vote(String newVoto) {
    isVoted = !isVoted;
    voto = newVoto;
  }
}

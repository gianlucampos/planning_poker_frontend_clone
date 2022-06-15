import 'package:flutter/cupertino.dart';
import 'package:planning_poker_flutter/models/game_status.dart';

class GameStatusProvider extends ChangeNotifier {
    GameStatus gameStatus = GameStatus.VOTING;

    void changeStatus(GameStatus newGameStatus) {
        gameStatus = newGameStatus;
        notifyListeners();
    }

}
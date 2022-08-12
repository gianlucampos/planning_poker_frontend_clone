enum GameStatus { VOTING, REVEAL_CARDS, NEW_GAME }

extension GameStatusExtension on GameStatus {
  static const values = {
    GameStatus.VOTING: "Pick your cards",
    GameStatus.REVEAL_CARDS: "Reveal cards",
    GameStatus.NEW_GAME: "Start new voting",
  };

  String? get value => values[this];
}

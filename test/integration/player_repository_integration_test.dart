import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:planning_poker_flutter/repositories/player_repository.dart';

void main() {
  final repository = PlayerRepository(Dio());

  test('Deve retornar uma lista de Jogadores', () async {
    final players = await repository.listPlayers();
    print(players);

    expect(players, isA<List>());
    expect(players.isNotEmpty, equals(true));
  });
}

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:planning_poker_flutter/shared/repositories/player_repository.dart';

class DioMock extends Mock implements Dio {}

void main() {
  final dio = DioMock();
  final repository = PlayerRepository(dio);
  final responseFixture = Response(
      statusCode: 200,
      data: [
        {"name": "Gianluca", "vote": "PP"}
      ],
      requestOptions: RequestOptions(path: 'path'));

  test('Deve retornar uma lista de Jogadores', () async {
    when(() => dio.get(any())).thenAnswer((_) async => responseFixture);

    final players = await repository.listPlayers();

    expect(players, isA<List>());
    expect(players.isNotEmpty, equals(true));
  });
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:planning_poker_flutter/shared/models/player_model.dart';
import 'package:planning_poker_flutter/shared/repositories/local_storedge_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() {

  test('Should add a player', () async {
    PlayerModel playerMock = PlayerModel(name: 'Gianluca', vote: 'PP');

    final repository = LocalStoredgeRepository();
    repository.addPlayer(playerMock);
    PlayerModel? player = await repository.getPlayerLogged();

    expect(player!, isNotNull);
    expect(player.name, 'Gianluca');
    expect(player.vote, 'PP');
  });

  test('Should return a player', () async {
    PlayerModel playerMock = PlayerModel(name: 'Gianluca', vote: 'PP');
    String playerString = jsonEncode(playerMock.toMap());
    SharedPreferences.setMockInitialValues({'user': playerString});

    final repository = LocalStoredgeRepository();
    PlayerModel? player = await repository.getPlayerLogged();

    expect(player!, isNotNull);
    expect(player.name, 'Gianluca');
    expect(player.vote, 'PP');
  });

  test('Should return null', () async {
    SharedPreferences.setMockInitialValues({});

    final repository = LocalStoredgeRepository();
    PlayerModel? player = await repository.getPlayerLogged();

    expect(player, isNull);
  });

}
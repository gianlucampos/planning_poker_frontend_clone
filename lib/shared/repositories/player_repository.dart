import 'package:dio/dio.dart';

import '../models/player_model.dart';

class PlayerRepository {
  final Dio _dio;
  final String _url_base =
      'https://planning-poker-spring.herokuapp.com/v1/api/players';

  PlayerRepository(this._dio);

  Future<List<PlayerModel>> listPlayers() async {
    final response = await _dio.get(_url_base);
    var players = response.data.map((e) => PlayerModel.fromMap(e));
    return List<PlayerModel>.from(players);
  }

  Future<List<PlayerModel>> listPlayersMock() async {
    return [
      PlayerModel(name: 'Gianluca', vote: 'PP'),
      PlayerModel(name: 'Victor', vote: 'PP'),
      PlayerModel(name: 'Caio', vote: 'PP'),
      PlayerModel(name: 'Ricardo', vote: 'P'),
      PlayerModel(name: 'Bruno', vote: 'P'),
      PlayerModel(name: 'Bruna', vote: 'P'),
      PlayerModel(name: 'Renata', vote: 'M'),
      PlayerModel(name: 'Geovanni', vote: 'G'),
    ];
  }
}

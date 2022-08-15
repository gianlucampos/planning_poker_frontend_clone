import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/player_model.dart';

class LocalStoredgeRepository {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<void> addPlayer(PlayerModel player) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString('user', jsonEncode(player.toMap()));
  }

  Future<PlayerModel?> getPlayerLogged() async {
    final SharedPreferences prefs = await _prefs;
    String? userJson = prefs.get('user') as String?;
    if( userJson == null) return null;
    var map = jsonDecode(userJson) as Map<String, dynamic>;
    return PlayerModel.fromMap(map);
  }
}

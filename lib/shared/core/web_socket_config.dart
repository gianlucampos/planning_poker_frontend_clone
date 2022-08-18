import 'dart:convert';
import 'dart:developer';

import 'package:stomp_dart_client/stomp.dart';
import 'package:stomp_dart_client/stomp_config.dart';
import 'package:stomp_dart_client/stomp_frame.dart';

import '../models/player_model.dart';
import 'globals.dart';

final RESET = '/app/resetList';
final UNREGISTER = '/app/unregister';
final REGISTER = '/app/register';

class WebSocketConfig {
  static final _socketUrl =
      'https://planning-poker-spring.herokuapp.com/ws-message';

  static final LIST_USERS_TOPIC = '/topic/users';
  static final LIST_USERS_CHANNEL = '/app/list';

  static void onConnect(StompFrame frame) {
    //Lista jogadores
    stompClient.subscribe(
      destination: LIST_USERS_TOPIC,
      callback: (StompFrame frame) {
        final json = jsonDecode(frame.body!);
        final List<PlayerModel> players = json
            .map<PlayerModel>(
                (p) => PlayerModel.fromMap(Map<String, String>.from(p)))
            .toList();
        gameProvider.addPlayers(players);
      },
    );

    stompClient.send(destination: LIST_USERS_CHANNEL);
  }

  static final stompClient = StompClient(
    config: StompConfig.SockJS(
      url: _socketUrl,
      onConnect: onConnect,
      onWebSocketDone: () => log('Done', time: DateTime.now()),
      onWebSocketError: (dynamic error) => print(error.toString()),
      // stompConnectHeaders: {'Authorization': 'Bearer yourToken'},
      // webSocketConnectHeaders: {'Authorization': 'Bearer yourToken'},
    ),
  );
}

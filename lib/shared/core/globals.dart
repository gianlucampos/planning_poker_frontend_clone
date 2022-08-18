library my_prj.globals;

import 'dart:developer' as devtools;

import '/shared/provider/game_provider.dart';
import 'web_socket_config.dart';

GameProvider gameProvider = GameProvider();
final socketClient = WebSocketConfig.stompClient;

logger(dynamic msg) => devtools.log(msg.toString(), time: DateTime.now());

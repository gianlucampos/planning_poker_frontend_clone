library my_prj.globals;

import 'dart:developer' as devtools;

import '/shared/provider/game_provider.dart';
import 'web_socket_config.dart';

GameProvider gameProvider = GameProvider();
final socketClient = WebSocketConfig.stompClient;

logger(String msg) => devtools.log(msg, time: DateTime.now());

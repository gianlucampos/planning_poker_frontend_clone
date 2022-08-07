library my_prj.globals;

import '../provider/game_provider.dart';
import 'dart:developer' as devtools;

import 'web_socket_config.dart';

GameProvider gameProvider = GameProvider();
final socketClient = WebSocketConfig.stompClient;

logger(String msg) => devtools.log(msg);

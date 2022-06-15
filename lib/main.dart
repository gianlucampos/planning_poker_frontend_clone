import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/provider/contador_provider.dart';
import 'package:planning_poker_flutter/provider/game_status_provider.dart';
import 'package:planning_poker_flutter/provider/rotate_card_provider.dart';
import 'package:planning_poker_flutter/provider/voto_provider.dart';
import 'package:provider/provider.dart';

import 'core/app_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RotateCardProvider()),
        ChangeNotifierProvider(create: (_) => ContadorProvider()),
        ChangeNotifierProvider(create: (_) => VotoProvider()),
        ChangeNotifierProvider(create: (_) => GameStatusProvider()),
      ],
      child: const AppWidget(),
    ),
  );
}

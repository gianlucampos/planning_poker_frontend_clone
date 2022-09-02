import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/shared/core/app_widget.dart';
import 'package:planning_poker_flutter/shared/core/globals.dart';
import 'package:planning_poker_flutter/shared/provider/contador_provider.dart';
import 'package:planning_poker_flutter/shared/provider/rotate_card_provider.dart';
import 'package:planning_poker_flutter/shared/provider/voto_provider.dart';
import 'package:provider/provider.dart';

void main() {
  socketClient.activate();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RotateCardProvider()),
        ChangeNotifierProvider(create: (_) => ContadorProvider()),
        ChangeNotifierProvider(create: (_) => VotoProvider()),
      ],
      child: const AppWidget(),
    ),
  );
}

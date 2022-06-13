import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/provider/contador_provider.dart';
import 'package:planning_poker_flutter/provider/jogador_provider.dart';
import 'package:provider/provider.dart';

import 'core/app_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JogadorProvider()),
        ChangeNotifierProvider(create: (_) => ContadorProvider()),
      ],
      child: const AppWidget(),
    ),
  );
}

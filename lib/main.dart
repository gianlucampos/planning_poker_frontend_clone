import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/controller/jogador_controller.dart';
import 'package:provider/provider.dart';

import 'core/app_widget.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => JogadorController()),
      ],
      child: const AppWidget(),
    ),
  );
}

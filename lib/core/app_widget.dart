import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/widgets/jogador_widget.dart';
import 'package:provider/provider.dart';

import '../provider/jogador_provider.dart';
import '../widgets/mesa_widget.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Free Planning Poker'),
        ),
        body: HomePage(),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: new List.generate(
            4,
                (index) =>
                JogadorWidget(
                  nome: "Fulano",
                  voto: "G",
                ),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            Provider.of<JogadorProvider>(context, listen: false).reset();
          },
          child: Text('Reset'),
        ),
        MesaWidget(),
      ]),
    );
  }
}

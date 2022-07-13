import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/models/player_model.dart';
import 'package:planning_poker_flutter/repositories/player_repository.dart';
import 'package:planning_poker_flutter/widgets/choose_card_widget.dart';
import 'package:planning_poker_flutter/widgets/jogador_widget.dart';

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

class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final repository = PlayerRepository(Dio());

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Expanded(child: futureBuilder()),
        MesaWidget(),
        ChooseCardWidget()
      ]),
    );
  }

  FutureBuilder futureBuilder() {
    return FutureBuilder(
        future: repository.listPlayers(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              snapshot.hasData) {
            return players(snapshot.data);
          }
          if (snapshot.hasError) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Text(snapshot.error.toString(), textScaleFactor: 1.5),
            );
          }
          return CircularProgressIndicator();
        });
  }

  Widget players(List<PlayerModel> players) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: players.length,
        itemBuilder: (context, index) {
          var player = players[index];
          return JogadorWidget(
            nome: player.name!,
            voto: player.vote!,
          );
        });
  }
}

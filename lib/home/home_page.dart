import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/widgets/positioned_widget.dart';

import '../widgets/card/choose_card_widget.dart';


class HomePage extends StatefulWidget {
  HomePage({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Free Planning Poker'),
      ),
      body: PositionedWidget(),
      bottomNavigationBar: ChooseCardWidget(),
    );
  }

}

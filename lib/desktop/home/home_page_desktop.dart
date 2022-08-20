import 'dart:html';

import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/shared/core/globals.dart';

import '../../shared/utils/custom_app_bar_widget.dart';
import '../../shared/widgets/loading_widget.dart';
import '../widgets/card/choose_card_widget.dart';
import '../widgets/positioned_widget.dart';

class HomePageDesktop extends StatefulWidget {
  HomePageDesktop({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageDesktop> createState() => _HomePageDesktopState();
}

class _HomePageDesktopState extends State<HomePageDesktop> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
     body: LoadingWidget(child: PositionedWidget()),
      bottomNavigationBar: ChooseCardWidget(),
    );
  }
}

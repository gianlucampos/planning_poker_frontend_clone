import 'package:flutter/material.dart';

import '../../shared/utils/custom_app_bar_widget.dart';
import '../widgets/card/choose_card_widget.dart';
import '../widgets/positioned_widget.dart';

class HomePageMobile extends StatefulWidget {
  HomePageMobile({
    Key? key,
  }) : super(key: key);

  @override
  State<HomePageMobile> createState() => _HomePageMobileState();
}

class _HomePageMobileState extends State<HomePageMobile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: PositionedWidget(),
      bottomNavigationBar: ChooseCardWidget(),
    );
  }
}

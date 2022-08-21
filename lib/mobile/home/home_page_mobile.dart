import 'dart:html';

import 'package:flutter/material.dart';

import '../../shared/core/globals.dart';
import '../../shared/repositories/local_storedge_repository.dart';
import '../../shared/repositories/socket_repository.dart';
import '../../shared/utils/custom_app_bar_widget.dart';
import '../../shared/widgets/loading_widget.dart';
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
  void initState() {
    super.initState();
    window.addEventListener('beforeunload', beforeUnload);
  }

  @override
  void dispose() {
    super.dispose();
    window.removeEventListener('beforeUnload', beforeUnload);
  }

  void beforeUnload(Event e) {
    LocalStoredgeRepository localStoredge = LocalStoredgeRepository();
    SocketRepository socket = SocketRepository();
    localStoredge.getPlayerLogged().then((user) {
      if (user != null) {
        logger('${user.name} saiu do jogo');
        socket.removePlayer(user);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: LoadingWidget(child: PositionedWidget()),
      bottomNavigationBar: ChooseCardWidget(),
    );
  }
}

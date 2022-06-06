import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/controller/contador_controller.dart';
import 'package:planning_poker_flutter/controller/mesa_controller.dart';

import 'contador_widget.dart';

class MesaWidget extends StatefulWidget {
  const MesaWidget({Key? key}) : super(key: key);

  @override
  State<MesaWidget> createState() => _MesaWidgetState();
}

class _MesaWidgetState extends State<MesaWidget> {
  final mesaController = MesaController();
  final contadorController = ContadorController();

  String get tableMessage => mesaController.tableMessage;

  @override
  void initState() {
    super.initState();
    mesaController.addListener(() {
      setState(() {});
    });
    contadorController.addListener(() {
      if (contadorController.decDuration.inSeconds == 1) {
        mesaController.changeStatus(GameStatus.REVEAL_CARDS);
        contadorController.reset();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 550,
      height: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 60, horizontal: 150),
        child: TextButton(
          onPressed: mesaController.startCount,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: SizedBox(
              width: 200,
              height: 200,
              child: mesaPlaceholder(),
            ),
          ),
        ),
      ),
    );
  }

  Widget mesaPlaceholder() {
    if (tableMessage == GameStatus.START_COUNT) {
      return Center(
          child: ContadorWidget(
        contadorController: contadorController,
      ));
    }
    return Center(
      child: Text(
        tableMessage,
        textScaleFactor: 1.5,
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
      ),
    );
  }
}

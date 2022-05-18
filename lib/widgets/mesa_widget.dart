import 'dart:developer';

import 'package:flutter/material.dart';

List<String> mensagens = [
  "Start new game",
  "Pick your cards",
  "Reveal cards",
  "Count"
];

class MesaWidget extends StatefulWidget {
  const MesaWidget({Key? key}) : super(key: key);

  @override
  State<MesaWidget> createState() => _MesaWidgetState();
}

class _MesaWidgetState extends State<MesaWidget> {
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
          onPressed: () => {log("Start new voting")},
          child: Container(
            decoration: BoxDecoration(
              color: Colors.blueGrey,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: Center(
                child: Text(
              "Start new voting",
              textScaleFactor: 1.5,
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            )),
          ),
        ),
      ),
    );
  }
}

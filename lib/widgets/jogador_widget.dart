import 'package:flutter/material.dart';

class JogadorWidget extends StatefulWidget {
  final String nome;
  final String voto;

  const JogadorWidget({Key? key, required this.nome, required this.voto})
      : super(key: key);

  @override
  State<JogadorWidget> createState() => _JogadorWidgetState();
}

class _JogadorWidgetState extends State<JogadorWidget> {
  bool isVotoExibido = false;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isVotoExibido ? CardVotado() : CardBranco(),
            SizedBox(height: 15),
            Text(
              widget.nome,
              textScaleFactor: 1.5,
              style: TextStyle(fontWeight: FontWeight.bold),
            )
          ]),
    );
  }

  void mostrarVoto() {
    setState(() {
      isVotoExibido = true;
    });
  }

  Widget CardVotado() {
    return Container(
      width: 90,
      height: 140,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Center(
        child: Text(
          widget.voto,
          textScaleFactor: 2,
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget CardBranco() {
    return Container(
      width: 90,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        border: Border.all(color: Colors.grey, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
    );
  }
}

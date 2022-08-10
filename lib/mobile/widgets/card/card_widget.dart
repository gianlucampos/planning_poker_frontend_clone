import 'package:flutter/material.dart';

class CardWidget extends StatefulWidget {
  final String voto;

  const CardWidget({Key? key, required this.voto}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  final Color _background = Colors.white;
  final Color _textColor = Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: 75,
          height: 120,
          decoration: BoxDecoration(
            color: _background,
            border: Border.all(color: Colors.blueAccent, width: 3),
            borderRadius: const BorderRadius.all(Radius.circular(12)),
          ),
          child: Center(
            child: Text(
              widget.voto,
              textScaleFactor: 2,
              style: TextStyle(color: _textColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/provider/voto_provider.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatefulWidget {
  final String voto;

  const CardWidget({Key? key, required this.voto}) : super(key: key);

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  Color _background = Colors.white;
  Color _textColor = Colors.blue;

  void voteController() {
    Provider.of<VotoProvider>(context, listen: false).isVoted
        ? _swapColors()
        : _defaultColors();
  }

  void _defaultColors() {
    setState(() {
      _background = Colors.white;
      _textColor = Colors.blue;
      Provider.of<VotoProvider>(context, listen: false).vote(widget.voto);
    });
  }

  void _swapColors() {
    setState(() {
      _background = Colors.blue;
      _textColor = Colors.white;
      Provider.of<VotoProvider>(context, listen: false).vote(widget.voto);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: voteController,
        child: Container(
          width: 85,
          height: 140,
          decoration: BoxDecoration(
            color: _background,
            border: Border.all(color: Colors.blueAccent, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: Center(
            child: Text(
              widget.voto,
              textScaleFactor: 2.5,
              style: TextStyle(color: _textColor, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}

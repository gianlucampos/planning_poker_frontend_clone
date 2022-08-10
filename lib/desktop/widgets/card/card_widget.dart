import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/shared/models/game_status.dart';
import 'package:planning_poker_flutter/shared/provider/game_status_provider.dart';
import 'package:planning_poker_flutter/shared/provider/voto_provider.dart';
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
  bool isVoted = false;

  @override
  void setState(fn) {
    if(mounted) {
      super.setState(fn);
    }
  }

  @override
  void initState() {
    super.initState();
    VotoProvider votoProvider =
        Provider.of<VotoProvider>(context, listen: false);
    votoProvider.addListener(() {
      setState(() {
        print(votoProvider.toString());
        //TODO Deixar controle de voto no widget pai
        if (votoProvider.isReset) {
          _background = Colors.white;
          _textColor = Colors.blue;
        }
        Provider.of<GameStatusProvider>(context, listen: false).changeStatus(
            votoProvider.voto != null
                ? GameStatus.REVEAL_CARDS
                : GameStatus.VOTING);
      });
    });
  }

  void voteController() {
    isVoted = !isVoted;
    isVoted ? _swapColors() : _defaultColors();
  }

  void _defaultColors() {
    _background = Colors.white;
    _textColor = Colors.blue;
    Provider.of<VotoProvider>(context, listen: false).changeVoto(null);
  }

  void _swapColors() {
    if (!Provider.of<VotoProvider>(context, listen: false).isFirstVote &&
        Provider.of<VotoProvider>(context, listen: false).voto != null) {
      isVoted = false;
      return;
    }
    _background = Colors.blue;
    _textColor = Colors.white;
    Provider.of<VotoProvider>(context, listen: false).changeVoto(widget.voto);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: InkWell(
        onTap: voteController,
        child: Container(
          width: 75,
          height: 120,
          decoration: BoxDecoration(
            color: _background,
            border: Border.all(color: Colors.blueAccent, width: 3),
            borderRadius: BorderRadius.all(Radius.circular(12)),
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

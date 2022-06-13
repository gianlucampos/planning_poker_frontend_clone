import 'package:flutter/material.dart';
import 'package:planning_poker_flutter/widgets/card_widget.dart';

class ChooseCardWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        bottomNavigationBar: Container(
          height: 130,
          child: FittedBox(
            fit: BoxFit.contain,
            child: Wrap(
              alignment: WrapAlignment.center,
              children: [
                Column(
                  children: [
                    Text('Choose your card 👇', textScaleFactor: 2),
                    Wrap(
                      alignment: WrapAlignment.center,
                      children: [
                        CardWidget(voto: 'PP'),
                        CardWidget(voto: 'P'),
                        CardWidget(voto: 'M'),
                        CardWidget(voto: 'G'),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

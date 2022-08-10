import 'package:flutter/material.dart';

import 'card_widget.dart';

class ChooseCardWidget extends StatelessWidget {
  const ChooseCardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: FittedBox(
        fit: BoxFit.contain,
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
            Column(
              children: [
                const Text('Choose your card 👇', textScaleFactor: 2),
                Wrap(
                  alignment: WrapAlignment.center,
                  children: const [
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
    );
  }
}
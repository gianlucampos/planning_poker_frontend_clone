import 'package:flutter/material.dart';

class MesaWidget extends StatefulWidget {
  const MesaWidget({Key? key}) : super(key: key);

  @override
  State<MesaWidget> createState() => _MesaWidgetState();
}

class _MesaWidgetState extends State<MesaWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: 200,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColorLight,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      child: TextButton(
        onPressed: () {},
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.blueGrey,
            borderRadius: BorderRadius.all(Radius.circular(20)),
          ),
          child: const SizedBox(
            width: 100,
            height: 100,
            child: Center(
              child: Text(
                'Vote',
                textScaleFactor: 1.5,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

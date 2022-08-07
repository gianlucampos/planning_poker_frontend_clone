import 'package:flutter/material.dart';

TextButton buildTextButton(
    {required VoidCallback function, required String text}) {
  return TextButton(
    onPressed: () {
      function.call();
    },
    child: Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(text),
      ),
    ),
  );
}

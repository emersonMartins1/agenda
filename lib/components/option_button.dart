import 'package:flutter/material.dart';

class OptionButton extends StatelessWidget {
  final String title;
  final void Function() pressedFunction;

  const OptionButton(
      {Key? key, required this.title, required this.pressedFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: TextButton(
        onPressed: pressedFunction,
        child: Text(
          title,
          style: const TextStyle(color: Colors.blue, fontSize: 20),
        ),
      ),
    );
  }
}

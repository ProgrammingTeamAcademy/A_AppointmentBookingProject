import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  const Button(
      {super.key,
      required this.widith,
      required this.title,
      required this.disable,
      required this.onprssed});
  final double widith;
  final String title;
  final bool disable;
  final Function() onprssed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      width: widith,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            backgroundColor: Colors.amber, foregroundColor: Colors.white),
        onPressed: disable ? null : onprssed,
        child: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

// Dice Widget
class DiceWidget extends StatefulWidget {
  final Function(int) onRoll;

  const DiceWidget({Key? key, required this.onRoll}) : super(key: key);

  @override
  _DiceWidgetState createState() => _DiceWidgetState();
}

class _DiceWidgetState extends State<DiceWidget> {
  int dice1Value = 0;
  int dice2Value = 0;
  Random random = Random();

  void rollDice() {
    setState(() {
      dice1Value = random.nextInt(6) + 1; // Dice value between 1 and 6
      dice2Value = random.nextInt(6) + 1; // Dice value between 1 and 6
    });
    // Trigger the callback with the sum of the dice values
    widget.onRoll(dice1Value + dice2Value);
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: rollDice,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.red, // You can change this color to any sand-like shade
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Center(
              child: Text(
                dice1Value == 0 ? '?' : dice1Value.toString(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: rollDice,
          child: Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.yellow,
              border: Border.all(color: Colors.black, width: 2),
            ),
            child: Center(
              child: Text(
                dice2Value == 0 ? '?' : dice2Value.toString(),
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

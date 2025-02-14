import 'package:flutter/material.dart';

class Keyboard extends StatelessWidget {
  final Function(String) onKeyPressed;
  const Keyboard({required this.onKeyPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      itemCount: 12,
      itemBuilder: (context, index) {
        List<String> keys = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '', '0', '⌫'];
        return GestureDetector(
          onTap: () => keys[index] != '' ? onKeyPressed(keys[index]) : null,
          child: Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.orange, width: 2),
            ),
            alignment: Alignment.center,
            child: Text(keys[index], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          ),
        );
      },
    );
  }
}

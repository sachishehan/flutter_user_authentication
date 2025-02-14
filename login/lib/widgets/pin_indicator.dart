import 'package:flutter/material.dart';

class PinIndicator extends StatelessWidget {
  final int pinLength;
  const PinIndicator({required this.pinLength, super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 20),
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index < pinLength ? Colors.orange : Colors.grey,
          ),
        );
      }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:login/services/auth_services.dart';
import 'package:login/widgets/keyboard.dart';
import '../widgets/pin_indicator.dart';
import 'username_login_screen.dart';
import 'home_screen.dart';

class PinLoginScreen extends StatefulWidget {
  const PinLoginScreen({super.key});

  @override
  _PinLoginScreenState createState() => _PinLoginScreenState();
}

class _PinLoginScreenState extends State<PinLoginScreen> {
  String enteredPin = '';
  String userId = "user123";

  void _onKeyPressed(String value) async {
    setState(() {
      if (value == '⌫') {
        if (enteredPin.isNotEmpty) {
          enteredPin = enteredPin.substring(0, enteredPin.length - 1);
        }
      } else if (enteredPin.length < 5) {
        enteredPin += value;
      }
    });

    if (enteredPin.length == 5) {
      final response = await AuthService.loginWithPin(userId, enteredPin);
      if (response.containsKey('error')) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['error'], style: TextStyle(color: Colors.red))),
        );
      } else {
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Enter Your PIN", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          PinIndicator(pinLength: enteredPin.length),
          Keyboard(onKeyPressed: _onKeyPressed),
          TextButton(
            onPressed: () => Navigator.push(
              context, MaterialPageRoute(builder: (_) => const UsernameLoginScreen())),
            child: const Text("Login with Username & Password"),
          ),
        ],
      ),
    );
  }
}
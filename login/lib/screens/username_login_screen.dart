import 'package:flutter/material.dart';
import 'package:login/services/auth_services.dart';

class UsernameLoginScreen extends StatefulWidget {
  const UsernameLoginScreen({super.key});

  @override
  _UsernameLoginScreenState createState() => _UsernameLoginScreenState();
}

class _UsernameLoginScreenState extends State<UsernameLoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String? _errorMessage;
  Future<void> _login() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final response = await AuthService.loginWithUsername(
        _usernameController.text,
        _passwordController.text,
      );

      print(response);

      if (mounted) {
        setState(() {
          _isLoading = false;
          if (response.containsKey('error')) {
            _errorMessage = response['error'];
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Login Successful!")),
            );
            // Navigate to the home screen or another page after login
            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
          }
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _errorMessage = "Something went wrong. Please try again.";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Enter Username & Password",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: "Username"),
              ),
              TextField(
                controller: _passwordController,
                decoration: const InputDecoration(labelText: "Password"),
                obscureText: true,
              ),
              if (_errorMessage != null)
                Text(_errorMessage!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _login,
                      child: const Text("Login"),
                    ),
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text("Login with PIN"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

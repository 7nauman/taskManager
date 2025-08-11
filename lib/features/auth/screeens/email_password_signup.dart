import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/features/auth/widgets/custom_button.dart';

class EmailPasswordSignup extends StatefulWidget {
  const EmailPasswordSignup({super.key});

  @override
  State<EmailPasswordSignup> createState() => _EmailPasswordSignupState();
}

class _EmailPasswordSignupState extends State<EmailPasswordSignup> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  String _strengthLabel = "";
  double _strength = 0;
  bool _isLoading = false;

  void _checkPasswordStrength(String password) {
    double strength = 0;
    String label = "";

    if (password.isEmpty) {
      strength = 0;
      label = "";
    } else if (password.length < 6) {
      strength = 0.25;
      label = "Weak";
    } else {
      bool hasUpper = password.contains(RegExp(r'[A-Z]'));
      bool hasLower = password.contains(RegExp(r'[a-z]'));
      bool hasDigit = password.contains(RegExp(r'[0-9]'));
      bool hasSpecial = password.contains(RegExp(r'[!@#\$&*~]'));

      int matches =
          [hasUpper, hasLower, hasDigit, hasSpecial].where((m) => m).length;

      if (matches >= 3 && password.length >= 8) {
        strength = 1.0;
        label = "Strong";
      } else {
        strength = 0.5;
        label = "Medium";
      }
    }

    setState(() {
      _strength = strength;
      _strengthLabel = label;
    });
  }

  Future<void> _signUp() async {
    setState(() {
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pushReplacementNamed(context, '/home'); // <-- Redirect to home
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      if (e.code == 'weak-password') {
        errorMessage =
            'Password is too weak. Use at least 6 characters with numbers & symbols.';
      } else if (e.code == 'email-already-in-use') {
        errorMessage =
            'This email is already registered. Try logging in instead.';
      } else if (e.code == 'invalid-email') {
        errorMessage =
            'The email address is not valid. Please enter a valid one.';
      } else {
        errorMessage = 'An error occurred: ${e.message}';
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sign Up - Email & Password"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(labelText: 'Password'),
                onChanged: _checkPasswordStrength,
              ),
              const SizedBox(height: 8),
              LinearProgressIndicator(
                value: _strength,
                backgroundColor: Colors.grey[300],
                color: _strength == 1.0
                    ? Colors.green
                    : (_strength >= 0.5 ? Colors.orange : Colors.red),
              ),
              Text(
                _strengthLabel,
                style: TextStyle(
                  color: _strength == 1.0
                      ? Colors.green
                      : (_strength >= 0.5 ? Colors.orange : Colors.red),
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              CustomButton(
                onPressed: _isLoading ? null : _signUp,
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Sign Up"),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, '/email-password-login');
                    },
                    child: Text("Login"),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

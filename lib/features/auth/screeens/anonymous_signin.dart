import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AnonymousSignin extends StatefulWidget {
  const AnonymousSignin({super.key});

  @override
  State<AnonymousSignin> createState() => _AnonymousSigninState();
}

class _AnonymousSigninState extends State<AnonymousSignin> {
  bool _isLoading = false;

  Future<void> _signInAnonymously() async {
    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential credential =
          await FirebaseAuth.instance.signInAnonymously();

      print("Signed in as: ${credential.user?.uid}");
      // Navigate to home screen after successful sign-in
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
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
        title: const Text("Anonymous Sign-In"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _isLoading ? null : _signInAnonymously,
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text("Sign in as Guest"),
        ),
      ),
    );
  }
}

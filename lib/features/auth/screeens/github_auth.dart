import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class GithubAuth extends StatefulWidget {
  const GithubAuth({super.key});

  @override
  State<GithubAuth> createState() => _GithubAuthState();
}

class _GithubAuthState extends State<GithubAuth> {
  bool _isLoading = false;

  Future<void> continueWithGitHub() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final provider = GithubAuthProvider();
      provider.addScope('read:user');
      provider.addScope('user:email');

      await FirebaseAuth.instance.signInWithProvider(provider);

      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print("Error during GitHub Sign-In: $e");
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
      appBar: AppBar(title: const Text("GitHub Sign-In")),
      body: Center(
        child: ElevatedButton(
          onPressed: _isLoading ? null : continueWithGitHub,
          child: _isLoading
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text("Sign in with GitHub"),
        ),
      ),
    );
  }
}

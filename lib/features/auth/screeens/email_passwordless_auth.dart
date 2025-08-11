import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/features/auth/widgets/custom_button.dart';

class EmailPasswordlessAuth extends StatefulWidget {
  const EmailPasswordlessAuth({super.key});

  @override
  State<EmailPasswordlessAuth> createState() => _EmailPasswordlessAuthState();
}

class _EmailPasswordlessAuthState extends State<EmailPasswordlessAuth> {
  final _emailController = TextEditingController();
  bool _isLoading = false;

  Future<void> _sendSignInLink() async {
    setState(() {
      _isLoading = true;
    });

    final email = _emailController.text.trim();

    ActionCodeSettings acs = ActionCodeSettings(
      url:
          'https://taskmanager-914aa.firebaseapp.com', // <-- Replace with your app's URL
      handleCodeInApp: true,
      androidPackageName:
          'com.example.task_manager', // <-- Replace with your package name
      androidInstallApp: true,
      androidMinimumVersion: '21',
    );

    try {
      await FirebaseAuth.instance.sendSignInLinkToEmail(
        email: email,
        actionCodeSettings: acs,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Sign-in link sent to $email. Check your inbox!')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: ${e.message}')),
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
        title: const Text("Sign Up - Email Passwordless"),
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
              const SizedBox(height: 24),
              CustomButton(
                onPressed: _isLoading ? null : _sendSignInLink,
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text("Send Sign-In Link"),
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

import 'package:flutter/material.dart';
import 'package:task_manager/features/auth/widgets/auth_button.dart';

class AuthOptionsScreen extends StatelessWidget {
  const AuthOptionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Authentication Options'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                AuthButton(
                  text: "Email & Password",
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, '/email-password-signup');
                  },
                ),
                const SizedBox(height: 10),
                AuthButton(
                  text: "Email Link (Passwordless)***",
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, '/email-passwordless-auth');
                  },
                  color: Colors.green,
                ),
                const SizedBox(height: 10),
                AuthButton(
                  text: "Phone Number",
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, '/phone-number-auth');
                  },
                  color: const Color.fromARGB(255, 78, 93, 105),
                ),
                const SizedBox(height: 10),
                AuthButton(
                  text: "Google Sign-In",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/google-signin');
                  },
                  color: Colors.red,
                ),
                const SizedBox(height: 10),
                AuthButton(
                  text: "Anonymous Sign In",
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, '/anonymous-signin');
                  },
                  color: Colors.grey[800]!,
                ),
                const SizedBox(height: 10),
                AuthButton(
                  text: "Facebook Sign In",
                  onPressed: () {},
                  color: Colors.blue[900]!,
                ),
                const SizedBox(height: 10),
                AuthButton(
                  text: "Twitter Sign In",
                  onPressed: () {},
                  color: Colors.lightBlue,
                ),
                const SizedBox(height: 10),
                AuthButton(
                  text: "Play Games Sign In",
                  onPressed: () {},
                  color: Colors.green[800]!,
                ),
                const SizedBox(height: 10),
                AuthButton(
                  text: "GitHub Sign In",
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/github-auth');
                  },
                  color: Colors.black,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

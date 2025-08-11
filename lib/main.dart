import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:task_manager/features/auth/screeens/anonymous_signin.dart';
import 'package:task_manager/features/auth/screeens/auth_options_screen.dart';
import 'package:task_manager/features/auth/screeens/email_password_login.dart';
import 'package:task_manager/features/auth/screeens/email_password_signup.dart';
import 'package:task_manager/features/auth/screeens/email_passwordless_auth.dart';
import 'package:task_manager/features/auth/screeens/github_auth.dart';
import 'package:task_manager/features/auth/screeens/google_signin.dart';
import 'package:task_manager/features/auth/screeens/login_screen.dart';
import 'package:task_manager/features/auth/screeens/phone_number_auth.dart';
import 'package:task_manager/features/auth/screeens/signup_screen.dart';
import 'package:task_manager/features/home/screens/homescreen.dart';
import 'package:task_manager/features/onboardings/screens/on_boarding_page.dart';
import 'package:task_manager/features/splash/screens/splash_screen.dart';
import 'package:task_manager/firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize Firebase if needed
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/onboarding': (context) => const OnBoardingPage(),
        '/auth_options': (context) => const AuthOptionsScreen(),
        '/email-password-signup': (context) => const EmailPasswordSignup(),
        '/home': (context) => const Homescreen(),
        '/email-password-login': (context) => const EmailPasswordLogin(),
        '/email-passwordless-auth': (context) => const EmailPasswordlessAuth(),
        '/phone-number-auth': (context) => PhoneNumberAuth(),
        '/anonymous-signin': (context) => const AnonymousSignin(),
        '/google-signin': (context) => const GoogleSignin(),
        '/github-auth': (context) => const GithubAuth(),
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignUpScreen(),
      },
    );
  }
}

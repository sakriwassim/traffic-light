import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hospital_car/signin_screen.dart';

import 'home_screen.dart';

class LoginEmailVerificationScreen extends StatefulWidget {
  const LoginEmailVerificationScreen({super.key});

  @override
  State<LoginEmailVerificationScreen> createState() =>
      _LoginEmailVerificationScreenState();
}

class _LoginEmailVerificationScreenState
    extends State<LoginEmailVerificationScreen> {
  bool isEmailVerified = false;
  Timer? timer;
  bool canResendEmail = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();
    }
    timer =
        Timer.periodic(Duration(seconds: 3), (Timer t) => checkEmailVerified());
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  _header(context) {
    return const Column(
      children: [
        Text(
          "Verifie email",
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _header(context),
                SizedBox(height: 20),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      'Nous vous avons envoyé un e-mail à ${auth.currentUser?.email}',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                const SizedBox(height: 8),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      'Vérifer votre l\u0027 e-mail....',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 32.0),
                  child: Center(
                    child: Text(
                      'Veuillez vérifier votre dossier spam',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.purple),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: ElevatedButton(
                    onPressed: () {
                      try {
                        canResendEmail
                            ? FirebaseAuth.instance.currentUser
                                ?.sendEmailVerification()
                            : null;
                      } catch (e) {
                        debugPrint('$e');
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      shape: const StadiumBorder(),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.purple,
                    ),
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: const Text(
                          "Resend",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: ElevatedButton(
                      onPressed: () => Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => SigninPage()),
                      ),
                      style: ElevatedButton.styleFrom(
                        shape: const StadiumBorder(),
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        backgroundColor: Colors.purple,
                      ),
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: const Text(
                            "Back",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future sendVerificationEmail() async {
    try {
      final user = FirebaseAuth.instance.currentUser!;
      await user.sendEmailVerification();
      setState(() => canResendEmail = false);
      await Future.delayed(Duration(seconds: 5));
      setState(() => canResendEmail = true);
    } catch (e) {
      SnackBar(
        backgroundColor: Colors.red,
        content: Text(e.toString()),
      );
    }
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;

      if (isEmailVerified) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      }
    });
  }
}

// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_app/Auth/sign_up_screen.dart';
import 'package:firebase_app/home/home_screen.dart';
import 'package:firebase_app/widget/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
                height: 200,
                child: Image(image: AssetImage('assets/icons/profile.png'))),
            const SizedBox(
              height: 30,
            ),
            TextFieldWidget(
              controller: emailController,
              hindText: 'Enter E-mail',
              iconData: Icons.mail,
            ),
            TextFieldWidget(
              controller: passController,
              hindText: 'Enter password',
              iconData: Icons.lock_person_outlined,
              obscureText: true,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CupertinoButton(
                      color: Colors.red,
                      child: const Text('Sign In'),
                      onPressed: () async {
                        try {
                          //  CircularProgressIndicator();
                          final credential = await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passController.text);
                          // ignore: unnecessary_null_comparison
                          if (credential != null) {
                            Get.offAll(
                              () => const HomeScreen(),
                            );
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'user-not-found') {
                            log('No user found for that email.');
                          } else if (e.code == 'wrong-password') {
                            log('Wrong password provided for that user.');
                          }
                        }
                      }),
                  CupertinoButton(
                      color: Theme.of(context).primaryColor,
                      child: const Text('Sign Up'),
                      onPressed: () async {
                        Get.to(() => const SignUpScreen());
                      }),
                ],
              ),
            )
          ],
        ),
      )),
    );
  }
}

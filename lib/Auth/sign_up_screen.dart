import 'package:firebase_app/widget/botton_widget.dart';
import 'package:firebase_app/widget/text_field_widget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cPasswordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
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
                controller: passwordController,
                hindText: 'Enter password',
                iconData: Icons.lock_person_outlined,
                obscureText: true,
              ),
              TextFieldWidget(
                controller: cPasswordController,
                hindText: 'Enter confirm password',
                iconData: Icons.lock_person_outlined,
                obscureText: true,
              ),
              BottonWidget(
                onTap: () async {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty ||
                      cPasswordController.text.isEmpty) {
                    Get.defaultDialog(
                      title: 'Register Account',
                      content: const Text(
                        'Please check TextField ,because have Empty field',
                      ),
                      confirm: TextButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          'Ok',
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  } else {
                    if (cPasswordController.text == passwordController.text) {
                      try {
                        final credential = await FirebaseAuth.instance
                            .createUserWithEmailAndPassword(
                                email: emailController.text,
                                password: passwordController.text);
                        if (credential != null) {
                          Get.back();
                        }
                      } on FirebaseAuthException catch (e) {
                        if (e.code == 'user-not-found') {
                          print('No user found for that email.');
                        } else if (e.code == 'wrong-password') {
                          print('Wrong password provided for that user.');
                        }
                      }
                    } else {
                      Get.defaultDialog(
                        title: 'Register Account',
                        content: const Text(
                          'Please check TextField ,because password not equal confirmpassword',
                        ),
                        confirm: TextButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text(
                            'Ok',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    }
                  }
                },
                text: 'Register',
              )
            ],
          ),
        ),
      ),
    );
  }
}

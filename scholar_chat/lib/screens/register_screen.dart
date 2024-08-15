import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_chat/screens/chat_screen.dart';

import 'package:scholar_chat/widgets/button.dart';
import 'package:scholar_chat/widgets/constants.dart';
import 'package:scholar_chat/widgets/text_field.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});
  static String Regid = 'RegisterScreen';

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmpasswordController = TextEditingController();

  void SignUserIn() async {
    /*showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );*/
    try {
      if (passwordController.text == confirmpasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text, password: passwordController.text);
      } else {
        showErrorMessage('Passwords don\'t match!');
      }
      Navigator.pushNamed(context, ChatScreen.id);
    } on FirebaseAuthException catch (e) {
      showErrorMessage(e.code);
    }
  }

  void showErrorMessage(String message) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.black,
            title: Center(
              child: Text(
                message,
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),

                Image.asset('lib/images/scholar.png'),
                const Text(
                  'Scholar Chat',
                  style: TextStyle(
                    fontSize: 32,
                    fontFamily: 'pacifico',
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 100,
                ),
                const Row(
                  children: [
                    Text(
                      ' Sign In',
                      style: TextStyle(
                        fontSize: 26,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                //Email Field
                CustomTextField(
                  controller: emailController,
                  obscure: false,
                  hintText: 'Email',
                ),
                const SizedBox(
                  height: 10,
                ),
                //Password Field
                CustomTextField(
                  obscure: true,
                  controller: passwordController,
                  hintText: 'Password',
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextField(
                  obscure: true,
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButton(
                  OnTap: SignUserIn,
                  text: 'Sign In',
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Already have an account?  ',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Log In!',
                        style: TextStyle(
                            color: Color(0xffd3f3f3),
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

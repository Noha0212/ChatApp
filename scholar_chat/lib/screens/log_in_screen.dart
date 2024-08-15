import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:scholar_chat/screens/chat_screen.dart';
import 'package:scholar_chat/screens/register_screen.dart';
import 'package:scholar_chat/services/snack_bar_service.dart';

import 'package:scholar_chat/widgets/button.dart';
import 'package:scholar_chat/widgets/constants.dart';
import 'package:scholar_chat/widgets/text_field.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({super.key});
  static String Logid = 'LogInScreen';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final formkey = GlobalKey<FormState>();

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  bool isLoading = false;

  LogUserIn() async {
    if (formkey.currentState!.validate()) {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      if (email.isEmpty) {
        SnackBarService.showErrorMessage('Please enter a valid email address');
        return;
      }
      if (password.isEmpty) {
        SnackBarService.showErrorMessage('Please enter a valid password');
        return;
      }
    }

    EasyLoading.show();
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      EasyLoading.dismiss();
      SnackBarService.showSuccessMessage('Successfully signed in');
      // ignore: use_build_context_synchronously
      Navigator.pushNamed(context, ChatScreen.id,
          arguments: emailController.text);
    } on FirebaseAuthException catch (e) {
      EasyLoading.dismiss();
      if (e.code == 'user-not-found') {
        SnackBarService.showErrorMessage('No user found for that email');
      } else if (e.code == 'wrong password') {
        SnackBarService.showErrorMessage('Wrong password for that user');
      } else {
        SnackBarService.showErrorMessage('Wrong email or wrong password');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: kPrimaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: SafeArea(
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /*const Spacer(
                      flex: 1,
                    ),*/
                    const SizedBox(
                      height: 80,
                    ),

                    Image.asset(kLogo),
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
                          ' Log In',
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
                      controller: passwordController,
                      obscure: true,
                      hintText: 'Password',
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomButton(
                        text: 'Log In',
                        OnTap: // LogUserIn,
                            () {
                          if (formkey.currentState!.validate()) {
                            setState(() {
                              isLoading = false;
                            });
                            LogUserIn;
                          }
                        }),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          'Don\'t have an account?  ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              RegisterScreen.Regid,
                            );
                          },
                          child: const Text(
                            'Register Now!',
                            style: TextStyle(
                                color: Color(0xffd3f3f3),
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        )
                      ],
                    ),
                    /*const Spacer(
                      flex: 2,
                    ),*/
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:chat_app/backend/auth/user_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});
  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final UserAuth _userAuth = UserAuth();
  // global key
  final formKey = GlobalKey<FormState>();
  //text fields
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmPasswordTextController = TextEditingController();
  // focus nodes
  final FocusNode emailFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();
  final FocusNode confirmPasswordFocus = FocusNode();

  // error message
  late String errorMessage = '';

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    emailTextController.dispose();
    passwordTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox(
      height: MediaQuery.of(context).size.height * 0.70,
      width: double.infinity,
      child: Form(
        key: formKey,
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.only(top: 5.0, left: 14.0, right: 14.0),
              children: [
                const Padding(
                  padding: EdgeInsets.all(2.0),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 36.0,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    errorMessage,
                    style: const TextStyle(fontSize: 14.0, color: Colors.red),
                    textAlign: TextAlign.center,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a valid email.';
                      }
                      return null;
                    },
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    controller: emailTextController,
                    keyboardType: TextInputType.emailAddress,
                    autofocus: true,
                    textInputAction: TextInputAction.next,
                    focusNode: emailFocus,
                    onFieldSubmitted: (term) {
                      FocusScope.of(context).requestFocus(passwordFocus);
                    },
                    decoration: InputDecoration(
                      hintText: 'Email',
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.length < 8) {
                        return 'Password must be longer than 8 characters.';
                      }
                      return null;
                    },
                    autofocus: false,
                    obscureText: true,
                    keyboardType: TextInputType.text,
                    controller: passwordTextController,
                    textInputAction: TextInputAction.next,
                    focusNode: passwordFocus,
                    onTapOutside: (event) {
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    onFieldSubmitted: (term) {
                      FocusScope.of(context).requestFocus(confirmPasswordFocus);
                    },
                    decoration: InputDecoration(
                      hintText: 'Password',
                      contentPadding:
                          const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(32.0),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    try {
                      _userAuth.registerUser(emailTextController.text,
                          passwordTextController.text);
                    } on FirebaseAuthException catch (error) {
                      errorMessage = error.code;
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 210, 217, 131),
                  fixedSize: const Size(250, 15),
                ),
                child: const Text('Sign Up',
                    style: TextStyle(color: Colors.black)),
              ),
            ),
            Padding(
              padding: EdgeInsets.zero,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(250, 15),
                ),
                onPressed: () {
                  context.pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}

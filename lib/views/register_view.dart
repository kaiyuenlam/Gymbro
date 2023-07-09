
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';
import '../widgets/custom_toast_message.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({super.key});

  @override
  State<RegisterView> createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {

  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [

        TextField(
          controller: _email, 
          enableSuggestions: false,
          autocorrect: false,
          keyboardType: TextInputType.emailAddress,
          decoration: const InputDecoration(
            hintText: 'Enter your email here'
          ),
        ),

        TextField(
          controller: _password,
          obscureText: true,
          enableSuggestions: false,
          autocorrect: false,
          decoration: const InputDecoration(
            hintText: 'Enter your password here'
          ),
        ),

        TextButton(
        onPressed: () async {
          //get email and password from TextEditingController
          final email = _email.text;
          final password = _password.text;

          try {
            //call Firebase Auth to register
            final UserCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: email, 
            password: password
            );
          } on FirebaseAuthException catch (e) {
            late String message;
            print(e.code);
            if (e.code == 'invalid-email') {
              message = 'Invalid Email Entered';
            } else if (e.code == 'email-already-in-use') {
              message = 'Email is already in use';
            } else if (e.code == 'weak-password') {
              message = 'Weak Password!\nPlease set the password more than 6 chars.';
            } else {
              message = 'Invalid Email or Password';
            }
            ScaffoldMessenger.of(context).showSnackBar(
              customToastMessage(message),
            );
          }
  
          
          
        }, 
        child: const Text('Register'),
        ),
      ],
    );
  }
}
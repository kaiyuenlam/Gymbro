import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:gymbro/firebase_options.dart';
import 'package:gymbro/widgets/custom_toast_message.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
                options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
              return const Text('None');
            
            case ConnectionState.waiting:
              return const Text('Loading');

            case ConnectionState.active:
              return const Text('Loading');

            case ConnectionState.done:
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
                      //call Firebase Auth to login
                      final UserCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: email, password: password
                      );
                      print(UserCredential);
                    } on FirebaseAuthException catch (e) {
                      late String message;
                      if (e.code == 'invalid-email') {
                        message = 'Invalid Email';
                      } else {
                        message = 'Invalid Email or Password';
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        customToastMessage(message),
                      );
                    }
                  }, 
                  child: const Text('Login'),
                  ),
                ],
              );
              default:
                return const Text('Loading');
          }
        },
      ),
    );
  }
}
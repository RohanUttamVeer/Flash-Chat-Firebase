import 'package:firebase_auth/firebase_auth.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';
import '../constants.dart';
import 'chat_screen.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginAuth = FirebaseAuth.instance;

  late String loginEmail;
  late String loginPassword;
  bool showSpinner = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Hero(
                tag: 'logo',
                child: Container(
                  height: 150,
                  child: Image.asset('assets/chat.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    loginEmail = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'enter your email'),
                ),
              ),
              TextField(
                textInputAction: TextInputAction.done,

                obscureText: true,
                // obscuringCharacter: '❄',
                onChanged: (value) {
                  loginPassword = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'enter your password'),
              ),
              RoundButton(
                  buttonName: 'Log In',
                  bColor: Colors.blue[400],
                  onTapped: () async {
                    setState(() {
                      showSpinner = true;
                    });
                    try {
                      final oldUser =
                          await _loginAuth.signInWithEmailAndPassword(
                              email: loginEmail, password: loginPassword);
                      if (oldUser != null)
                        Navigator.pushNamed(context, ChatScreen.id);
                      setState(() {
                        showSpinner = false;
                      });
                    } catch (e) {
                      print(e);
                    }
                  })
            ],
          ),
        ),
      ),
    );
  }
}

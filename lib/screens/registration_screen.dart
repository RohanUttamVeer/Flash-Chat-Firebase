import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _registrationAuth = FirebaseAuth.instance;
  late String registrationEmail;
  late String registrationPassword;
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
              Flexible(
                child: Hero(
                  tag: 'logo',
                  child: Container(
                    height: 150,
                    child: Image.asset('assets/chat.png'),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                child: TextField(
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  textAlign: TextAlign.center,
                  onChanged: (value) {
                    registrationEmail = value;
                  },
                  decoration: kTextFieldDecoration.copyWith(
                      hintText: 'enter your email'),
                ),
              ),
              TextField(
                textInputAction: TextInputAction.done,

                textAlign: TextAlign.center,
                obscureText: true,
                // obscuringCharacter: '☺',
                onChanged: (value) {
                  registrationPassword = value;
                },
                decoration: kTextFieldDecoration.copyWith(
                    hintText: 'enter your password'),
              ),
              RoundButton(
                  buttonName: 'Register',
                  bColor: Colors.blue[600],
                  onTapped: () async {
                    setState(() {
                      showSpinner = true;
                    });

                    try {
                      final newUser = await _registrationAuth
                          .createUserWithEmailAndPassword(
                              email: registrationEmail,
                              password: registrationPassword);
                      if (newUser != null)
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

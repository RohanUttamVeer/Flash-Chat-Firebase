import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'chat_screen.dart';

class LoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
                onChanged: (value) {},
                decoration:
                    kTextFieldDecoration.copyWith(hintText: 'enter your email'),
              ),
            ),
            TextField(
              onChanged: (value) {},
              decoration: kTextFieldDecoration.copyWith(
                  hintText: 'enter your password'),
            ),
            RoundButton(
                buttonName: 'Log In',
                bColor: Colors.blue[400],
                onTapped: () {
                  Navigator.pushNamed(context, ChatScreen.id);
                })
          ],
        ),
      ),
    );
  }
}

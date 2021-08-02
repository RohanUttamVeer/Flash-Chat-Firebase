import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  static const String id = 'registration_screen';

  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
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
                buttonName: 'Register',
                bColor: Colors.blue[600],
                onTapped: () {
                  Navigator.pushNamed(context, ChatScreen.id);
                })
          ],
        ),
      ),
    );
  }
}

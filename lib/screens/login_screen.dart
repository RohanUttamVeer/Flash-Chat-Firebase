import 'package:flash_chat/components/rounded_button.dart';
import 'package:flutter/material.dart';

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
            TextField(
              onChanged: (value) {},
              decoration: InputDecoration(
                hintText: 'enter your email',
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(32),
                ),
              ),
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

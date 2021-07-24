import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Hero(
                  tag: 'logo',
                  child: Container(
                    child: Image.asset('assets/chat.png'),
                    height: 60.0,
                  ),
                ),
                Text(
                  ' Flash Chat',
                  style: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                top: 70,
              ),
              child: Material(
                elevation: 5.0,
                color: Colors.lightBlueAccent,
                borderRadius: BorderRadius.circular(30),
                child: MaterialButton(
                  onPressed: () {
                    Navigator.pushNamed(context, LoginScreen.id);
                  },
                  child: Text('Log In'),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 25),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    primary: Colors.lightBlueAccent,
                    shape: StadiumBorder(),
                    padding: EdgeInsets.all(15.0)),
                child: Text('Register'),
                onPressed: () {
                  Navigator.pushNamed(context, RegistrationScreen.id);
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

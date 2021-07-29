import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 1),
      vsync: this,
      // upperBound: 60,
    );
    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white)
        .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
      print(animation!.value);
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation!.value,
      // backgroundColor: Colors.deepOrangeAccent.withOpacity(controller!.value),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
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
                    // height: animation!.value * 70,
                  ),
                ),
                // ignore: deprecated_member_use
                TextLiquidFill(
                  text: ' Flash Chat',
                  // ' ${controller!.value.toInt()}%',
                  boxBackgroundColor: Colors.white,
                  waveColor: Colors.blueGrey,
                  boxHeight: 100,
                  boxWidth: 230,
                  
                  textStyle: TextStyle(
                      fontSize: 45,
                      fontWeight: FontWeight.w900,
                      color: Colors.black),
                ),
              ],
            ),
            RoundButton(
                buttonName: 'Login',
                bColor: Colors.blue[400],
                onTapped: () {
                  Navigator.pushNamed(context, LoginScreen.id);
                }),
            RoundButton(
              buttonName: 'Register',
              bColor: Colors.blue[600],
              onTapped: () {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CharScreen extends StatefulWidget {
  static const String id = 'chat_screen';

  @override
  _CharScreenState createState() => _CharScreenState();
}

class _CharScreenState extends State<CharScreen> {
  @override
  Widget build(BuildContext context) {
    return Text(
      'chat screen',
      style: TextStyle(color: Colors.black),
    );
  }
}

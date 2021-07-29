import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  RoundButton({this.buttonName, this.bColor, required this.onTapped});
  final String? buttonName;
  final Color? bColor;
  final Function onTapped;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 5.0,
            primary: bColor,
            shape: StadiumBorder(),
            padding: EdgeInsets.all(15.0)),
        child: Text(buttonName!),
        onPressed: () => onTapped.call(),
      ),
    );
  }
}

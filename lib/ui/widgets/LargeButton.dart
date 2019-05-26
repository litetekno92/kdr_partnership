import 'package:flutter/material.dart';

class LargeButton extends StatelessWidget
{
  Function _onPressed;
  String _text;
  LargeButton({@required Function onPressed, String text}) {
    _onPressed = onPressed;
    _text = text;
  }
  @override
  Widget build(BuildContext) {
    return (new Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          color: Colors.lightBlueAccent,
          child: Text(this._text, style: TextStyle(color: Colors.white)),
          onPressed: this._onPressed,
        ),
      ),
    ));
  }
}
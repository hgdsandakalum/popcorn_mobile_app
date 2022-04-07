import 'package:flutter/material.dart';

class BaseAlertDialog extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  Color _color = Color.fromARGB(172, 0, 0, 0);

  late String _title;
  late String _content;
  late String _yes;
  late String _no;
  late Function _yesOnPressed;
  late Function _noOnPressed;

  BaseAlertDialog(
      {required String title,
      required String content,
      required Function yesOnPressed,
      required Function noOnPressed,
      String yes = "Yes",
      String no = "No"}) {
    this._title = title;
    this._content = content;
    this._yesOnPressed = yesOnPressed;
    this._noOnPressed = noOnPressed;
    this._yes = yes;
    this._no = no;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        this._title,
        style: new TextStyle(color: Colors.white),
      ),
      content: new Text(
        this._content,
        style: new TextStyle(color: Colors.white),
      ),
      backgroundColor: this._color,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        new TextButton(
          child: new Text(
            this._yes,
            style: new TextStyle(color: Colors.redAccent),
          ),
          onPressed: () {
            this._yesOnPressed();
          },
        ),
        new TextButton(
          child: Text(
            this._no,
            style: new TextStyle(color: Colors.grey),
          ),
          onPressed: () {
            this._noOnPressed();
          },
        ),
      ],
    );
  }
}

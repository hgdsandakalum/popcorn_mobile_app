import 'package:flutter/material.dart';

class BaseAlertDialog2 extends StatelessWidget {
  //When creating please recheck 'context' if there is an error!

  Color _color = Color.fromARGB(222, 0, 0, 0);

  late String _title;
  late String _share;
  late String _remove;
  late String _edit;
  late Function _removeOnPressed;
  late Function _editOnPressed;

  BaseAlertDialog2(
      {required Function removeOnPressed,
      required Function editOnPressed,
      String title = "More Options",
      String share = "Share",
      String remove = "Remove",
      String edit = "Edit"}) {
    this._share = share;
    this._title = title;
    this._removeOnPressed = removeOnPressed;
    this._editOnPressed = editOnPressed;
    this._remove = remove;
    this._edit = edit;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: new Text(
        this._title.toUpperCase(),
        textAlign: TextAlign.center,
        style: new TextStyle(color: Colors.white),
      ),
      backgroundColor: this._color,
      shape:
          RoundedRectangleBorder(borderRadius: new BorderRadius.circular(15)),
      actions: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextButton.icon(
                onPressed: () => {},
                icon: Icon(Icons.share, color: Colors.white),
                label: Text(
                  this._share.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 10),
            TextButton.icon(
                onPressed: () {
                  this._editOnPressed();
                },
                icon: Icon(Icons.edit, color: Colors.white),
                label: Text(
                  this._edit.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )),
            SizedBox(height: 10),
            TextButton.icon(
                onPressed: () {
                  this._removeOnPressed();
                },
                icon: Icon(Icons.delete, color: Colors.white),
                label: Text(
                  this._remove.toUpperCase(),
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold),
                )),
          ],
        )
      ],
    );
  }
}

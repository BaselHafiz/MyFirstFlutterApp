import 'package:flutter/material.dart';

class WarningDialog extends StatelessWidget {
  final BuildContext myContext;

  WarningDialog(this.myContext);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Are you sure?"),
      content: Text('This action can\'t be undone'),
      actions: <Widget>[
        FlatButton(
          child: Text("Discard"),
          onPressed: () => Navigator.pop(myContext), // close the alert dialog
        ),
        FlatButton(
            child: Text("Continue"),
            onPressed: () {
              Navigator.pop(myContext);
              Navigator.pop(myContext, true);
            }),
      ],
    );
  }
}

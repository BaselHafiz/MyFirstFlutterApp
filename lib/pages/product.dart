import 'package:flutter/material.dart';
import 'dart:async';

class ProductPage extends StatelessWidget {
  final String imageUrl;
  final String title;

  ProductPage(this.title, this.imageUrl);

  _showWarningDialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Are you sure?"),
            content: Text('This action can\'t be undone'),
            actions: <Widget>[
              FlatButton(
                child: Text("Discard"),
                onPressed: () =>
                    Navigator.pop(context), // close the alert dialog
              ),
              FlatButton(
                  child: Text("Continue"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context, true);
                  }),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(imageUrl),
            Container(
              padding: EdgeInsets.all(10),
              child: Text(title),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Text("Delete"),
              onPressed: () => _showWarningDialog(context),
            )
          ],
        ),
      ),
    );
  }
}

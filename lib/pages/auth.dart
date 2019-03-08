import 'package:flutter/material.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Center(
          child: RaisedButton(
              child: Text("Login"),
              color: Theme.of(context).primaryColor,
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/productsPage');
              }),
        ));
  }
}

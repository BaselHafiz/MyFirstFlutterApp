import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  String _email = '';
  String _password = '';
  bool _acceptTerms = false;

  DecorationImage _buildDecorationImage() {
    return DecorationImage(
        image: AssetImage('assets/background.png'),
        fit: BoxFit.cover,
        colorFilter: ColorFilter.mode(
          Colors.black.withOpacity(0.2),
          BlendMode.dstATop,
        ));
  }

  Widget _buildEmailTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Email'),
      onChanged: (String value) {
        setState(() {
          _email = value;
        });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextField(
      decoration: InputDecoration(labelText: 'Password'),
      onChanged: (String value) {
        setState(() {
          _password = value;
        });
      },
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _acceptTerms,
      title: Text('Accept Terms'),
      onChanged: (bool value) {
        setState(() {
          _acceptTerms = value;
        });
      },
    );
  }

  void _submitForm() =>
      Navigator.pushReplacementNamed(context, '/productsPage');

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 700 : deviceWidth * 0.95;

    return Scaffold(
        appBar: AppBar(
          title: Text('Login'),
        ),
        body: Container(
          width: targetWidth,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            image: _buildDecorationImage(),
          ),
          padding: EdgeInsets.all(15),
          child: ListView(
            children: <Widget>[
              _buildEmailTextField(),
              _buildPasswordTextField(),
              SizedBox(
                height: 20,
              ),
              _buildAcceptSwitch(),
              SizedBox(
                height: 20,
              ),
              RaisedButton(
                child: Text("Login"),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                onPressed: _submitForm,
              ),
            ],
          ),
        ));
  }
}

import 'package:flutter/material.dart';

class AuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  Map<String, dynamic> _formData = {
    'email': null,
    'password': null,
    'acceptTerms': false
  };

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    //
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Email is required';
        } else if (!RegExp(r'^\w+[\w-\.]*\@\w+((-\w+)|(\w*))\.[a-z]{2,3}$')
            .hasMatch(value)) {
          return 'Email isn\'t correct';
        }
      },
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(labelText: 'Email'),
      onSaved: (String value) {
        setState(() {
          _formData['email'] = value;
        });
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      validator: (String value) {
        if (value.isEmpty) {
          return 'Password is required';
        } else if (value.length < 5) {
          return 'Password should be 5+ characters';
        }
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Password'),
      onSaved: (String value) {
        setState(() {
          _formData['password'] = value;
        });
      },
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return RaisedButton(
      child: Text("Login"),
      textColor: Colors.white,
      color: Theme.of(context).primaryColor,
      onPressed: _submitForm,
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      title: Text('Accept Terms'),
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
    );
  }

  void _submitForm() {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }

    if (_formData['acceptTerms']) {
      Navigator.pushReplacementNamed(context, '/productsPage');
    } else {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text('Please Accept Terms'),
        duration: Duration(seconds: 3),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final double deviceWidth = MediaQuery.of(context).size.width;
    final double targetWidth = deviceWidth > 550 ? 700 : deviceWidth * 0.98;

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Form(
          key: _formKey,
          child: Container(
            width: targetWidth,
            alignment: Alignment.center,
            decoration: BoxDecoration(image: _buildDecorationImage()),
            padding: EdgeInsets.all(15),
            child: ListView(
              children: <Widget>[
                _buildEmailTextField(),
                _buildPasswordTextField(),
                SizedBox(height: 20),
                _buildAcceptSwitch(),
                SizedBox(height: 20),
                _buildLoginButton(context),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

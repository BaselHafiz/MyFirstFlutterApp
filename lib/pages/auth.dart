import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped_models/main.dart';

enum AuthMode { SignUp, Login }

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
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;

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
      controller: _passwordTextController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Password'),
      onSaved: (String value) {
        setState(() {
          _formData['password'] = value;
        });
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return TextFormField(
      validator: (String value) {
        if (_passwordTextController.text != value) {
          return 'Password do not match';
        }
      },
      obscureText: true,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(labelText: 'Confirm Password'),
    );
  }

  Widget _buildLoginButton(BuildContext context) {
    return ScopedModelDescendant<MainModel>(
      builder: (BuildContext context, Widget child, MainModel model) {
        return RaisedButton(
          child: Text('${_authMode == AuthMode.Login ? 'Login' : 'Sign Up'}'),
          textColor: Colors.white,
          color: Theme.of(context).primaryColor,
          onPressed: () => _submitForm(model.login, model.signUp),
        );
      },
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

  void _submitForm(Function login, Function signUp) async {
    _formKey.currentState.save();
    if (!_formKey.currentState.validate()) {
      return;
    }

    if (_authMode == AuthMode.Login) {
      if (_formData['acceptTerms']) {
        login(_formData['email'], _formData['password']);
        Navigator.pushReplacementNamed(context, '/productsPage');
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Please Accept Terms'),
          duration: Duration(seconds: 3),
        ));
      }
    } else {
      if (_formData['acceptTerms']) {
        final Map<String, dynamic> successInfo =
            await signUp(_formData['email'], _formData['password']);
        if (successInfo['success']) {
          Navigator.pushReplacementNamed(context, '/productsPage');
        } else {
          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  title: Text('An error occurred !'),
                  content: Text('${successInfo['message']}'),
                  actions: <Widget>[
                    FlatButton(
                      child: Text('Ok'),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    )
                  ],
                );
              });
        }
      } else {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text('Please Accept Terms'),
          duration: Duration(seconds: 3),
        ));
      }
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
                _authMode == AuthMode.SignUp
                    ? _buildPasswordConfirmTextField()
                    : Container(),
                SizedBox(height: 20),
                _buildAcceptSwitch(),
                SizedBox(height: 20),
                FlatButton(
                  child: Text(
                      'Switch to ${_authMode == AuthMode.Login ? 'Sign Up' : 'Login'}'),
                  onPressed: () {
                    setState(() {
                      _authMode = _authMode == AuthMode.Login
                          ? AuthMode.SignUp
                          : AuthMode.Login;
                    });
                  },
                ),
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

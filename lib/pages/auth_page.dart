import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthPage extends StatefulWidget {
  Function _setAccount;

  AuthPage(this._setAccount);

  @override
  State<StatefulWidget> createState() {
    return _AuthPageState();
  }
}

class _AuthPageState extends State<AuthPage> {
  Future<void> _handleSignIn() async {
    try {
      GoogleSignIn(
        scopes: ['email', 'https://www.googleapis.com/auth/spreadsheets'],
      ).signIn().then((GoogleSignInAccount account) {
        widget._setAccount(account);
        Navigator.pushReplacementNamed(context, '/list');
      });
    } catch (error) {
      print(error);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('log in here'),
      ),
      body: Container(
        child: Center(
          child: RaisedButton(
            child: Text('Log in with Google'),
            onPressed: _handleSignIn,
          ),
        ),
      ),
    );
  }
}

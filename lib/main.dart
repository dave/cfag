import 'package:cfag/pages/auth_page.dart';
import 'package:cfag/pages/list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() => runApp(CfagApp());

class CfagApp extends StatefulWidget {
  @override
  State createState() {
    return _FcagAppState();
  }
}

class _FcagAppState extends State<CfagApp> {
  GoogleSignInAccount account;

  void setAccount(GoogleSignInAccount value) {
    account = value;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (BuildContext context) => AuthPage(setAccount),
        '/list': (BuildContext context) => ListPage(account),
      },
    );
  }
}

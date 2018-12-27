//import 'package:dart/googleapis.sheets.v4';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/sheets/v4.dart';
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart';

class ListPage extends StatefulWidget {
  GoogleSignInAccount _account;

  ListPage(this._account);

  @override
  State<StatefulWidget> createState() {
    return _ListPageState(_account);
  }
}

const sheetId = '16crK2P-qtpm99vJIGBngNJik9kys2Im7IvosXC4D_KU';

class _ListPageState extends State<ListPage> {
  Spreadsheet sheet;

  GoogleSignInAccount _account;
  _ListPageState(this._account);

  @override
  void initState() {
    _account.authentication.then((GoogleSignInAuthentication auth) {
      var authClient = authenticatedClient(
        Client(),
        AccessCredentials(
          AccessToken(
            "Bearer",
            auth.accessToken,
            DateTime.now().toUtc().add(Duration(days: 1)),
          ),
          null,
          ['email', 'https://www.googleapis.com/auth/spreadsheets'],
        ),
      );
      SpreadsheetsResourceApi sapi = SheetsApi(authClient).spreadsheets;
      sapi
          .get(
        sheetId,
        includeGridData: true,
      )
          .then((Spreadsheet value) {
        setState(() {
          sheet = value;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Text('loading...');
    if (sheet != null) {
      content = ListView.builder(
        itemCount: sheet.sheets[0].data[0].rowData.length - 1,
        itemBuilder: (BuildContext context, int i) {
          var row = sheet.sheets[0].data[0].rowData[i + 1];
          var email = row.values[0].formattedValue;
          var fname = row.values[1].formattedValue;
          var lname = row.values[2].formattedValue;
          return ListTile(
            title: Text(fname + ' ' + lname),
            subtitle: Text(email),
            leading: Icon(Icons.person),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Members List'),
      ),
      body: Container(
        child: Center(
          child: content,
        ),
      ),
    );
  }
}

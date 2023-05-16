import 'package:flutter/material.dart';
import './home.dart';

class AdminSignInScreen extends StatefulWidget {
  @override
  _AdminSignInScreenState createState() => _AdminSignInScreenState();
}

class _AdminSignInScreenState extends State<AdminSignInScreen> {
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Sign In'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TextFormField(
              obscureText: true,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  _password = value;
                });
              },
            ),
            SizedBox(height: 16.0),
            MaterialButton(
              color: Colors.amber,
              child: Text('Sign In'),
              onPressed: () {
                // TODO: Implement sign in logic using password entered by user
                if (_password == 'mrmiel')
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => AdminPage()),
                  );
                else
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Mot de passe incorrect'),
                    ),
                  );
              },
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class AuthForm extends StatefulWidget {
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: EdgeInsets.all(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
              child: SingleChildScrollView(
            child: Column(
              // this to make column take min height like wrap content
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Mail'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Username'),
                ),
                TextField(
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 10,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Login'),
                ),
                FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Create new account',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    )),
              ],
            ),
          )),
        ),
      ),
    );
  }
}

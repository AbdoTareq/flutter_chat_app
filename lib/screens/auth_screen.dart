import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/auth/auth_form.dart';

class AuthScreen extends StatelessWidget {

  _submitAuthForm(String mail, String pass, String username,bool isSignin){

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Theme.of(context).primaryColor,
      body: AuthForm(_submitAuthForm)
    );
  }
}
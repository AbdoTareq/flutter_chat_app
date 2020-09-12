import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/widgets/auth/auth_form.dart';

class AuthScreen extends StatelessWidget {
  final _auth = FirebaseAuth.instance;

  _submitAuthForm(
    String mail,
    String pass,
    String username,
    bool isSignin,
    // as this method will excute in level below so it can't use context from another level
    BuildContext ctx,
  ) async {
    UserCredential userCredential;
    try {
      if (isSignin) {
        userCredential =
            await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      } else {
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: mail, password: pass);
      }
    } on PlatformException catch (e) {
      var message = 'An error occurred, Please check your credentials';
      if (e.message != null) {
        message = e.message;
      }
      showDialog(
          context: ctx,
          builder: (ctx) => AlertDialog(
                title: Text('An error occurreda'),
                content: Text(message),
                actions: [
                  FlatButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                    },
                    child: Text('Ok'),
                  )
                ],
              ));
    }catch(e){
      print('dart mess: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm));
  }
}

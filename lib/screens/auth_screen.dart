import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_app/widgets/auth/auth_form.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final _auth = FirebaseAuth.instance;

  bool _isLoading = false;

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
      setState(() {
        _isLoading = true;
      });
      if (isSignin) {
        userCredential =
            await _auth.signInWithEmailAndPassword(email: mail, password: pass);
      } else {
        // new user
        userCredential = await _auth.createUserWithEmailAndPassword(
            email: mail, password: pass);
        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user.uid)
            .set({
          'mail': mail,
          'username': username,
        });
      }
    } on PlatformException catch (e) {
      var message = 'An error occurred, Please check your credentials';
      if (e.message != null) {
        message = e.message;
      }
      setState(() {
        _isLoading = false;
      });
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
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('dart mess: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).primaryColor,
        body: AuthForm(_submitAuthForm, _isLoading));
  }
}

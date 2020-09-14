import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_chat_app/widgets/auth/profile_image.dart';

class AuthForm extends StatefulWidget {
  final Function(String mail, String pass, String username, File image,
      bool isSignin, BuildContext ctx) submitAuthForm;

  final bool _isLoading;
  const AuthForm(this.submitAuthForm, this._isLoading);

  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  // these fields for go to nest field in form
  // 4 steps
  // 1.
  final _usernameFocusNode = FocusNode();
  final _passFocusNode = FocusNode();
  final _form = GlobalKey<FormState>();
  bool _isSiginin = true;
  String _mail = '';
  String _username = '';
  String _pass = '';
  File _imageFile;

  _pickedImageFn(File imageFile) {
    _imageFile = imageFile;
  }

  @override
  void dispose() {
    super.dispose();
    // step 4. this to prevent memory leaks if the screen isn't visible anymore
    _usernameFocusNode.dispose();
    _passFocusNode.dispose();
  }

  _validateSaveForm() {
    // this to close keyboard if fileds are valid
    FocusScope.of(context).unfocus();
    if (_imageFile == null && !_isSiginin) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text('Please pick image'),
      ));
      return;
    }
    if (!_form.currentState.validate()) {
      return;
    }

    _form.currentState.save();
    widget.submitAuthForm(_mail.trim(), _pass.trim(), _username.trim(),
        _imageFile, _isSiginin, context);
    print('dart mess:  $_imageFile');
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
        height: !_isSiginin ? 480 : 280,
        child: Card(
          margin: EdgeInsets.all(12),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
                key: _form,
                child: SingleChildScrollView(
                  child: Column(
                    // this to make column take min height like wrap content
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (!_isSiginin) ProfileImage(_pickedImageFn),
                      TextFormField(
                        //key is to diffirentiate every TextFormField to stop a bug like if enter username then switch to login pass will have username value
                        key: ValueKey('mail'),
                        autocorrect: false,
                        enableSuggestions: true,
                        textCapitalization: TextCapitalization.none,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(labelText: 'Mail'),
                        validator: (value) {
                          if (value.isEmpty || !value.contains('@')) {
                            return 'Please enter valid mail';
                          }
                          // null here means it's a valid input
                          return null;
                        },
                        onFieldSubmitted: (value) {
                          //step 2. these fields for go to nest field in form
                          !_isSiginin
                              ? FocusScope.of(context)
                                  .requestFocus(_usernameFocusNode)
                              : FocusScope.of(context)
                                  .requestFocus(_passFocusNode);
                        },
                        onSaved: (newValue) => _mail = newValue,
                      ),
                      if (!_isSiginin)
                        TextFormField(
                          key: ValueKey('username'),
                          // step 3. these fields for go to nest field in form
                          focusNode: _usernameFocusNode,
                          autocorrect: true,
                          enableSuggestions: true,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(labelText: 'Username'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter username';
                            }
                            // null here mean it's a valid input
                            return null;
                          },
                          onFieldSubmitted: (value) {
                            //step 2. these fields for go to nest field in form
                            FocusScope.of(context).requestFocus(_passFocusNode);
                          },
                          onSaved: (newValue) => _username = newValue,
                        ),
                      TextFormField(
                        key: ValueKey('pass'),
                        // step 3. these fields for go to nest field in form
                        focusNode: _passFocusNode,
                        decoration: InputDecoration(labelText: 'Password'),
                        obscureText: true,
                        validator: (value) {
                          if (value.isEmpty || value.length <= 7) {
                            return 'Please enter valid pass longer than 8 chars';
                          }
                          // null here mean it's a valid input
                          return null;
                        },
                        onSaved: (newValue) => _pass = newValue,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      widget._isLoading
                          ? CircularProgressIndicator()
                          : RaisedButton(
                              onPressed: _validateSaveForm,
                              child: Text(_isSiginin ? 'Login' : 'Sign up'),
                            ),
                      FlatButton(
                          onPressed: () {
                            setState(() {
                              _isSiginin = !_isSiginin;
                            });
                          },
                          child: Text(
                            _isSiginin
                                ? 'Create new account'
                                : 'Already have account',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor),
                          )),
                    ],
                  ),
                )),
          ),
        ),
      ),
    );
  }
}
